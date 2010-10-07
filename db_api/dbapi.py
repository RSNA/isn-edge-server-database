#!/usr/bin/env jython
########################### dbapi.py ##############################
# Author: Steve Langer
# Date:   7/29/2010
# Purpose: This module has the following purposes:
#	a) Provide Java Class wrappers to RSNA-ISN dbase
#	b) mediate all dbase commun
#	c) error handling of b)
#		 
# External Dependencies: 
# 1) the file "isn-utils.py" which performs dbase calls via jython JDBC
# 2) the upstream Java code that calls rsna_dpapi Classes to get ot the dbase
#######################################################################
import sys, os

# need to set path to get modules in ../src
# sys.path.append("/home/sglanger/code/prime/img-arch/src")
from isn_utils import *

# Global vars
global db, alert_lvl, cwd


class dbapi:
        "@sig public void dbapi()"
#####################################################
# Purpose: Since Java cannot do anything without a 
#	Class, we define this one here to encapsulate
#	all the RSNA_db functions that need to be Java accessable
#
#	Each of the classes provides basic CRUD plus Find and Alert
#
#Caller: upstrean java
###############################################
	from isn_web_forms import *

	def alertFromJava(self, mod, msg):
                "@sig public void alertFromJava(java.lang.String mod, java.lang.String msg)"
	#######################################
	# Purpose: Receive System.err logging 
	#	from Java code and funnel to 
	#	utils alert() method which can send to dbase
	#
	# Caller: Java processes
	#######################################
                
                module="_rsna_dbapi: alertFromJava"
		
		alert(mod, msg, alert_lvl, db, cwd)
		return
	
	def init (self) :
	################################
	# Purpose: Setup the dbase and directory info for using
	#	the API in a form that is reachable by external
	#	Java methods
	#
	# Caller: Java processes
	###############################
		module="_rsna_dbapi: init"
		
		return os.getcwd() , init_jdbc()


####################################################################
# Init code block
# By Assigning globals here, they occur after Function/Classes that reference them
# and are visable to both Classes, Functions and __main__
################################################################

# 1 = print, 2 = print and log_file, 3 = print and DBase_log
alert_lvl = 1
# cwd = os.getcwd() 
# db = init_jdbc()

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

	api = dbapi()
	cwd, db = api.init()
	cwd = cwd + '/' + module + '.log'
	alert (module, 'starting', alert_lvl, db, cwd)
	try :
		if sys.argv[1] == 'h':
			print "Usage is: jython ./isn-dp-api.py h/w/t "
			print "h    -- prints this help message"
			print "t    -- runs a test of dbase connection to Actor"
			msg = 'exiting help mode '
		elif sys.argv[1] == 't':
			api = dbapi.Patient(alert_lvl, db, cwd)
			#err, res = api.find('123', 'abc', 'jack')
                        err = api.retrieve('123456', '', '')
                        if err < 1 :
                            msg = 'exiting test mode \n err= %s \n res=%s' % (err, api.patName)
                        else:
                            msg = api.msg 
	except :
		msg = "Usage is: jython isn-dp-api.py h/w/t "

	alert (module, msg, alert_lvl, db, cwd)
	db.close()
        if err > 0 :
                sys.exit (err)
        else :
                #sys.exit (res)
		sys.exit()


