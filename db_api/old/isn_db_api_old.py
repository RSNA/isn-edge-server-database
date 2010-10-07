#!/usr/bin/env jython
########################### isn-db-api.py ##############################
# Author: Steve Langer
# Date:   7/29/2010
# Purpose: This module has the following purposes:
#	a) Provide Java Class wrappers to RSNA-ISN dbase
#	b) mediate all dbase commun
#	c) error handling of b)
#
#		 
# External Dependencies: 
# 1) the file "isn-utils.py" which performs dbase calls via jython
# 2) the upstream Java code that would call "call_factory" to get ot the dbase
#######################################################################
import sys, os

# need to set path to get modules in ../src
# sys.path.append("/home/sglanger/code/prime/img-arch/src")
from isn_utils import *

# Global vars
global db, alert_lvl, cwd


class _rsna_dbapi:
#####################################################
# Purpose: Since Java cannot do anything without a 
#	Class, we define this one here to encapsulate
#	all the RSNA_db functions that need to be Java accessable
#
#Caller: upstrean java
###############################################
	from isn_web_forms import *

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

	def call_factory (self, klas, method, user, cert, arg):
	################################################
	# Purpose: The web server called us w/ a Get/Post operation and we
	#               need to parse the command args,set up the call and 
	#               return the formatted results. 
	#
	#		klas = Patient, Job, Exam, Report, Users, Devices, etc
	#		method = create, delete, update or find
	#		user, cert = can be left blank for now
	#		arg = variable length object (or string) depending on the Class.method being called
	#
	# Caller: main or upstream Java code
	#############################################
		module="web-handler: call_factory"
	
		print "klas= %s, method= %s, args= %s" % (klas, method,arg)
		# arg is a string consisting of one or more real args.
		# depending on the method being called it may need parsing
		if klas == "Patient":
			print 'a'
			from isn_web_forms import Patient
			obj = Patient (alert_lvl, db)
		elif klas == "Job":
			from isn_web_forms import Job
			obj = Job (alert_lvl, db)
		elif klas == "Exam":
			from isn_web_forms import Study
			obj = Study (alert_lvl, db)
			
		if method == "create":
			err, stat = obj.create (user, cert, arg)
		elif method == "delete":
			err, stat = obj.delete (user, cert, arg)
		elif method == "update":
			err, stat = obj.update (user, cert, arg)
		elif method == "find":
			print 'b'
			err, stat = obj.find (user, cert, arg)

		# print string, err, stat
		print "err= %s, stat= %s" % (err, stat)
		return err, stat 



####################################################################
# Init code block
# By Assigning globals here, they occur after Function/Classes that reference them
# and are visable to both Classes, Functions and __main__
################################################################

# 1 = print, 2 = print and log_file, 3 = print and DBase_log
alert_lvl = 1
cwd = os.getcwd() 
db = init_jdbc()

# redirect errors to browser if running in CGI mode
sys.stderr = sys.stdout
	
if __name__ == '__main__':
##################################################
# Purpose: Format the command line calls into a generic call to 
#       the Call_Factory
#
# Caller: form.py or human at cmd ln. 
####################################################	
	module="web-handler"
	err = 0
	res=""
        cwd = cwd + '/' + module + ".log"
	sys.argv[1].rstrip
	arg_s = 'args= %s ' % (sys.argv[1])

	alert (module, arg_s, alert_lvl, db, cwd)
	try :
		if sys.argv[1] == 'h':
			print "Usage is: jython ./isn-dp-api.py h/w/t "
			print "h    -- prints this help message"
			print "t    -- runs a test of dbase connection to Actor"
			msg = 'exiting help mode '
		elif sys.argv[1] == 't':
			api = _rsna_dbapi.Patient(alert_lvl, db)
			err, res = api.find('','','')
			# err, res = api.call_factory("Patient", "find",'', '', '')
			msg = 'exiting test mode \n err= %s \n res= %s ' % (err, res)
	except :
		print "Unknown command line option in", module
		print "Usage is: jython isn-dp-api.py h/w/t "
		msg = 'exiting from invalid startup mode '

	alert (module, msg, alert_lvl, db, cwd)
	db.close()
        if err > 0 :
                sys.exit (err)
        else :
                sys.exit (res)


