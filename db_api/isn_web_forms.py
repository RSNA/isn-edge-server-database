#!/usr/bin/env jython
######################### web_forms.py ############################
# Author: Steve Langer
# Date:   8/1/08
# Purpose: This is a container of class wrappers for the rsna dbase
#
# External Dependencies
# 1) isn_utils
# 2) isn_db_api is the starting call in the _rsna_dbapi class
###############################################################
import string

# need to set path to get modules in ../src
# sys.path.append("/home/sglanger/code/prime/img-arch/src")
from isn_utils import *

class Patient :
#####################################################
# Purpose: Handle all the AJAX I/O to pgSQL-dbase
#       for the indicated web page 
#Caller: Web page 'agent_related'
###############################################

        def __init__ (self, alert, dbase, curdir):
        #################################
        # Purpose: Set globals
        # Caller: web_handler:call_factory
        ###############################
                global alert_lvl, db, cwd
		alert_lvl = alert
		db = dbase
		cwd = curdir
		msg = ''
		
		mrn = 0
		rsnaID = ''
		patName = ''
		dob = ''
		sex = ''
		street = ''
		city = ''
		state =  ''
		zip = ''
		modDate = ''
		
	def c_alert(self, mod, msg):
	#######################################
	# Purpose: Receive System.err logging 
	#	from Java code and funnel to 
	#	handler.py alert() method
	#
	# Caller: Java processes
	#######################################
		module="web_forms:agent_related: c_alert"
		
		alert(mod, msg, alert_lvl, db, cwd)
		return


        def create (self, mrn, patName, dob, sex, street, city, state, zip):
        ##########################################################
        # Purpose: Create a new patient record in the patients table
        #
        # Caller: from Web-server
        ######################################################
		module="web_forms::Patient.create"

		if mrn == '' :
			self.msg = "Usage is %s, %s, %s" % (mrn, rsnaID, patName)
			err_status = 1
		else :
			# call dbase
			f = "insert into patients VALUES ('%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s')" % (mrn, patName, dob, sex, street, city, state, zip)
			#print "f=%s" % f
			err_status, cnt, result = callStoredProc (db, f)
			if err_status < 1 :
				#load the object variables with what we just created
				err = self.retrieve(mrn, patName, dob)
			else :
				self.msg = result
			
		# and return status, 0 - no err, 1 = err
                return err_status


        def delete (self, result):
        ##########################################
        # Purpose: Delete an existing record in the
	#	patients table
        #
        # Caller: list_by_group and list_by_agent 
        #############################################
                module="web_forms::agent_related: formRow"
                res = ""

                if string.find(result, "None") > -1 :
                        #print "here, a %s" % (result)
                        return result

                lst = string.split(result, "\n")
                for  a in lst:
                        try :
                                #print a
                                parts = string.split(a, ",")
                                tmp = "%s %s %s\n" % (parts[0], parts[2], parts[3])
                                res = "%s %s" % (res, tmp)
                                # print tmp
                        except :
                                pass

                return res

	def find (self, patID, mrn, rsnaID):
	##########################################
	# Purpose: Return a list of near matches for Patient
	#	based on closeness to 3 different IDs
	#
	# Caller: external Java app
	#############################################
		module="web_forms::agent_related: list-by-agent"
				
		if patID == '' :
			self.msg = "Usage: ID, lastname, fistname, DOB"
			err_status = 1
		else :
			# f = "select * from patients where patientID=%s" % (patID)
			f = "select * from patients " 
			err_status, cnt, result = callStoredProc (db, f)
			#result = self.formRow (result)
			
		# 0 = no err, 1 = err.
		return err_status, result 


        def update (self, mrn, patName, dob, sex, street, city, state, zip):
        ##########################################
        # Purpose: Update an existing patient table row
        #
        # Caller: list_by_group and list_by_agent 
        #############################################
                module="web_forms::agent_related: formDropList"
                res = ""

		if mrn == '' :
			self.msg = "Error: Usage is mrn, patName, dob, sex, street, city, state, zip"
			err_status = 1
		else :		
			# call dbase
			f = "update into patients VALUES ('%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s')" % (mrn, patName, dob, sex, street, city, state, zip)
			#print "f=%s" % f
			err_status, cnt, result = callStoredProc (db, f)
			if err_status < 1 and result != [] :
				#load the object variables with what we just Updated
				err = self.retrieve(mrn, patName, dob)
			else :
				self.msg = result
				
                # and return status, 0 - no err, 1 = err
                return err_status


	def retrieve (self, mrn, patID, rsnaID):
	##########################################
	# Purpose: Return a single record for an 
	#	exact match on the IDs above
	#
	# Caller: external Java app
	#############################################
		module="web_forms::agent_related: list-by-agent"
				
		if mrn == '' :
			self.msg = "Error: Usage is mrn, patID and rsnaID"
			err_status = 1
		else :
			f = "select * from patients where mrn=('%s')" % (mrn)
			err_status, cnt, result = callStoredProc (db, f)
			#print "err=%s res2 = %s" % (err_status, result)
                        if err_status < 1 and result != []:
				self.mrn = result[0][1]
				self.patName = result[0][2]
				self.dob = result[0][3]
				self.sex = result[0][4]
				self.street = result[0][5]
				self.city = result[0][6]
				self.state = result[0][7]
				self.zip = result[0][8]
			else :
                                #print "in rtrv"
                                err_status = 1
				self.msg = "null result"
			
                #result = self.formRow (result)
		# 0 = no err, 1 = err.
		return err_status



class Job :
##################################################
# Purpose: Handle all the AJAX I/O to pgSQL-dbase
#       for the indicated web page 
# 
# Caller: Web page 'agent_group', 
#       allied dbase table are: groups, groups_aet, role_privs
#       allied dbase funcs are: cmod_agent_grp, view_grp_agent_role
###############################################

        def __init__ (self, alert, dbase):
        #################################
        # Purpose: Set globals
        # Caller: web_handler:call_factory
        ###############################
                global db, alert_lvl, cwd
                alert_lvl = alert
                db = dbase

	def c_alert(self, mod, msg):
	#######################################
	# Purpose: Receive System.err logging 
	#	from Java code and funnel to 
	#	handler.py alert() method
	#
	# Caller: Java processes
	#######################################
		module="web_forms:agent_group: c_alert"
		
		alert(mod, msg, alert_lvl)
		return

