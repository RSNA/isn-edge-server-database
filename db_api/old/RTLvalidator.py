#!/usr/bin/env jython
###################################################################
# Author: Steve Langer
# Date:   3/8/2005
# Purpose: This module has 4 main purposes:
#	a) Require/support the Authenticator checks before permitting associations
#	b) Check the rights of the caller to do requested Command on target object
#	c) Return required info (DICOM triplet) to the Caller (for C-Moves, etc)
#  	d) Asychronously pass Trigger Events from pgSQL back to DICOM Handler for action
#
#	  The guiding philosophy of this RTLvalidator is it shuold not know
#	  anything about the pgSQL schema, just the CallProcs API 
#     	  to the Actor's dbase
#
# Architechture: There is an instance of this code for each protocol
#		 a) DICOM
#		 b) HL7
#		 c) Web XML
#		 
#
# External Dependencies: 
# 1) Copy .jython user registry file to your home dir ~/
# The line python.path contains some links to the Java libraries which are required to run the DICOM receiver.
#
#
# 2) Add prime.jar to the classpath (I still need to find the right place to add this in the Jython registry.)
# CLASSPATH=/usr/share/java/postgresql-jdbc3.jar:/usr/share/java/zxJDBC.jar:/home2/ntc01/prime/DICOM/dev/prime.jar:
#
# 3) Now start up the RTL
# Server:
# jython RTLvalidator.py d 5032 nick /home2/ntc01/downloads
#
# Clients: (echo and store, on a new terminal window)
# C-Echo
# /home2/ntc01/prime/DICOM/dev/oldenburg/dcmtk-3.5.4-linux-i686/bin/echoscu -v -aec nick -aet anyscu localhost 5032
#
# C-Store
# /home2/ntc01/prime/DICOM/dev/oldenburg/dcmtk-3.5.4-linux-i686/bin/storescu -v aec nick -aet anyscu localhost 5032 /home2/# ntc01/downloads/images/MR.1.2.840.113619.2.134.1762387655.2833.1141130127.790
###################################################3333####################
import sys, os, string

# need to set path to get modules in ../src
sys.path.append("../src")
from utils import *

from com.prime import ImageArchiveSCP
from com.prime.Util import DbPoll, DicomEventProcessor

# Global vars
global db, alert_lvl, cwd, eventProcess 


class DCMtoRTL:
#####################################################
# Purpose: Since Java cannot do anything without a 
#	Class, we define this one here to encapsulate
#	all the RTL functions that need to be Java accessable
#
#Caller: DICOM handler (Pixelmed reciever) library
###############################################

	def alertFromJava(self, mod, msg):
	#######################################
	# Purpose: Receive System.err logging 
	#	from Java code and funnel to 
	#	RTLvalidator.py alert() method
	#
	# Caller: Java processes
	#######################################
		module="RTLvalidator:DCMtoRTL: alertFromJava"
		
		alert(mod, msg, alert_lvl, db)
		return


	def clearEvent(self, pkey):
	#######################################
	# Purpose: As Pixelmed clears events sent to it from 
	#      time_Callback, it shuld call this so that
	#      a pgSQL StoredProc sets the Service time on rows in
	#      Event_Que thus taking them out of pending status
	# Caller: DICOM handler
	#######################################
		module="RTLvalidator:DCMtoRTL: clearEvent"
		
                pkey = string.split(pkey, "(")
                f = " mod_event ('%s')" % (pkey[1])
                # print "f = %s, %s" % ( f, pkey[1])
                err, result  = callStoredProc (db, f)
		return


        def createStudy(self, pkey, studyID):
        ########################################
        # Purpose: After DICOM handler gets OK from validateAgent for a 
        #       C-Store, come here when we know the StudyID
        #
        # Args: pkey must be an array of OIDs like this (with {})
        #       {oid1, oid2, oid3 ...}
        # Caller: DICOM Handler about to store a study
        ###########################################
		module="RTLvalidator:DCMtoRTL: createStudy"

                f = " create_study ('%s', %s)" % (pkey, studyID)
                # print "f = %s" % ( f)
                err, result  = callStoredProc (db, f)
                # print "in %s, err and result are %s %s" % (module, err, result)
		return err


        def getAgentInfo(self, callerAET, targetAET):
        ##############################################
        # Purpose: Idea is, pgSQL should be the source for 
        #       all Data to build associations.
        # 
        # Caller:  DICOM handler
        ############################################
                module="RTLValidator:DCMtoRTL: getDICOMinfo"

		# C-MOVE syntax only gives AET, so guess what??
		# we have to require unique AET in table Agents

                f = " read_dcm_agent ('%s','%s')" % (callerAET, targetAET)
                # status should be a Tuple of IP, AET, Port
                err, result  = callStoredProc (db, f)
		# print "err = %s, result = %s" % (err, result)
		if err != 0 :
			# print "in err"
			return result
		else:
			# in here parse tuplet into DICOM triplet
			list = string.split(result, ",")
			# print "list = ", list[5]
			result = "%s, %s, %s" % (list[5], list[6], list[7])
			return result


	def validateAgent(self, host, callingAET, calledAET, study, command):
	##########################################
	# Purpose: Receives request from Java DICOM environment to validate agent 
	#
	# Caller: Pixelmed Java DICOM handler
	#############################################
		module="RTLvalidator:DCMtoRTL: validateAgent"
		err_status = 1

		# After this module starts the Java Reciever in MAIN, the only way 
		# anything will happen in this module are calls by Java to this class
	
		#First, we must verify that this agent is who they claim
		stat = checkCert (host, callingAET)
		if stat == 1 :
			# This agent has not been certifed by Authenticator
			return err_status

		# if we got here the Agent has a valid Kerberos Cert
		# SO now check for authorization on this Actor for
		# this caller to do desired operation to the desired Study
		f = "read_DCM_rights ('%s', '%s','%s','%s', '%s')" % (host, callingAET, calledAET, study, command)
		err_status, result = callStoredProc (db, f)
		# 0 = no err, 1 = err. 
                # Result contains OID for later Java-Store call to Create_Study in dbase
                # print "err = %s, res = %s" % (err_status, result)
		return err_status 	


        def time_callback(arg):
        #################################################
        # Purpose: Check if there are pending DICOM events in table event_que
        #	   and send to Java DICOM engine if yes.
        #           This func. sends one event at a time to DICOM handler.
        #           The Handler calls clearEvent(parts[0]) to clear events
        #           from teh que.
        # Caller: STarted in init code before main
        ################################################
	       module="RTLvalidator:DCMtoRTL:time_callback"

	       f = " read_events ('dicom')"
	       err, result  = callStoredProc (db, f)                
                
	       if string.count(result, '\n') > 0 :
		# need to alert Pixelmed to pending events	
		# Pixelmed needs to know these things:
		# a) What external Agent do I need to signal
		# b) What Pat/Study/Series info do I need to send it
		# c) What is required event_type (Study_Content, New Order, etc)  	
                        lst = string.split(result, "\n")
                        for  a in lst:
                                try :
                                        # print a
                                        parts = string.split(a, ",")
                                        # order below is Pkey, Event,patID, serID, studyID, targetAET
                                        # print parts[0],parts[6],parts[7],parts[8], parts[9],parts[10]
                                        eventProcess.processEvent(parts[0], parts[6],parts[7], parts[8], parts[9], parts[10]) 
                                        # As "processEvent" serves events, it must use clearEvent above 
                                        # to set event Service time,  thus taking it out of pending status
                                except:
                                        print "in Callback, exception = ", sys.exc_type, sys.exc_value
                                        pass

	       # there is nothing left to report
	       return


####################################################################
# Init code block
# By Assigning globals here, they occur after Function/Classes they reference and
# are visable to both DCMtoRTL and __main__
################################################################

# 1 = print, 2 = print and log_file, 3 = print and DBase_log
alert_lvl = 3
cwd = os.getcwd()
db = init_jdbc()
eventProcess = DicomEventProcessor()
poller  = DbPoll(15, 'time_callback')  # DbPoll cannot resolve outside of Class DCMtoRTL
#poller.startPoll()

	
if __name__ == '__main__':
#####################################
# Purpose: Set up a listener for DICOM inputs, 
#	  format the required Callablemore statemnts to pgSQL, 
#	  execute the stored procedures on pgSQL and, 
#	  return result set to caller. 
#
#	  Also, support callbacks (how??) from pgSQL if 
#	  events fire on dbase that are of interest to other
#	  registered agents. Then send a msg back out to the 
#	  DICOM or HL7 module to alert registered agent
#
# Caller: actor's main Start/Stop script
####################################################	
	module="RTLvalidator:main"	

	alert (module, 'starting up', alert_lvl, db)

	try:
		a = sys.argv[1]
	except:
		print "Unknown command line option in", module
		print "Usage is: jython RTLvalidator.py h/d/t "

	if sys.argv[1] == 'h':
		print "Usage is: jython ./RTLvalidator.py h/d/t "
		print "jython ./RTLvalidator.py h    -- prints this help message"
		print "jython ./RTLvalidator.py t    -- runs a test of dbase connection to Actor"
		print "jython ./RTLvalidator.py d port AET rcv_dir   -- starts DICOM services"
	elif sys.argv[1] == 'd':
		# runme.main(["5032", "nick", "/home2/ntc01/downloads/receive"])
		# The next 2 lines start a Pixelmed listener but ...		
		runme = ImageArchiveSCP()
		runme.main([sys.argv[2], sys.argv[3], sys.argv[4]])
		# They do not return unless SCPTest is killed so ...
		# the only to do if we return here is exit 
		msg = " exiting DICOM mode"
	elif sys.argv[1] == 't':
		# test(db)
		d = DCMtoRTL()
		#ret =  d.getAgentInfo ('img_mgr', 'ct_ii')
		ret = d.validateAgent ('ct_ii', 'ct_ii', 'Mayo_1', '','c-store')
                #ret = d.createStudy ('{45292, 45294}', '5113')
		msg = 'exiting Test mode with ret = %s ' % (ret)
		# print msg

	alert (module, msg, alert_lvl, db)
	poller.stopPoll()
	db.close()
	sys.exit (msg)

