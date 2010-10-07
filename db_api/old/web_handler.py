#!/usr/bin/env jython
########################### web_handler.py ##############################
# Author: Steve Langer
# Date:   9/21/06
# Purpose: This module has the following purposes:
#	a) Require/support the Authenticator checks before permitting web associations
#	b) Support Checks that Authenticated caller can do requested Command on target object
#	c) Then perform Qry/updates of dbase info to the web page
#
# Architechture: There is an instance of this code for each protocol
#		 a) DICOM
#		 b) HL7
#		 c) Web XML
#		 
# External Dependencies: 
# 1) the file "form.py" which can be called from Apache, does CGI parsing & calls this via jython
# 2) this calls objects in web-form.py
#######################################################################
import sys, os

# need to set path to get modules in ../src
sys.path.append("/home/sglanger/code/prime/img-arch/src")
from utils import *

# 10/13/2006 
# Need a .py file to handle web form variables, but .jy file 
# to talk to the DBase.
# This is a puzzle. How to fix this?
# we could use a AJAX call to a .py parser, 
# then it could call this w/ jython and wait for the returned values ...

# Global vars
global db, alert_lvl, cwd


def call_factory (klas, method, user, cert, arg):
################################################
# Purpose: The web server called us w/ a Get/Post operation and we
#               need to parse the command args,set up the call and 
#               return the formatted results. 
#           To boost performance and keep the runtime size of this code
#           small, we pulled out the actual HTML page handling Classes
#           to web_forms.py. Then below we only import the Class needed 
#           to service the AJAX call for the specific HTML page
#
# Caller: main
#############################################
	module="web-handler: call_factory"

	#First, we must verify that this agent is who they claim
	stat = checkCert (user, cert)
	if stat == 1 :
		result = "This agent has not been certifed by Authenticator"
                err_status = 1
		return err_status, result

        print "klas %s, method %s, args %s" % (klas, method,arg)
        # arg is a string consisting of one or more real args.
        # depending on the method being called it may need parsing
        if klas == "agent_related":
                from web_forms import agent_related
                obj = agent_related(alert_lvl, db)
                if method == "list_by_related":
                        err, stat = obj.list_by_related (user, cert, arg)
                elif method == "list_by_agent":
                        err, stat = obj.list_by_agent (user, cert, arg)
                elif method == "c_mod_agent_rel":
                        err, stat = obj.c_mod_agent_rel (user, cert, arg[0][0:])
                elif method == "read_agent_related":
                        err, stat = obj.read_agent_related (user, cert, arg[0][0:])
                elif method == "read_related_events":
                        err, stat = obj.read_related_events (user, cert)
                
        elif klas == "agent_group":
                from web_forms import agent_group
                obj = agent_group (alert_lvl, db)
                if method == "c_mod_agent_grp":
                        err, stat = obj.c_mod_agent_group (user, cert, arg[0][0:])
                elif method == "list_by_group":
                        err, stat = obj.list_by_group(user, cert, arg[0][0:])
                elif method == "list_by_agent":
                        err, stat = obj.list_by_agent(user, cert, arg[0][0:])
                elif method == "read_roles":
                        err, stat = obj.read_roles(user, cert)
                elif method == "read_groups":
                        err, stat = obj.read_groups(user, cert)
                elif method == "read_agent_grp":
                        err, stat = obj.read_agent_grp(user, cert, arg[0][0:])

        # print string, err, stat
        return err, stat 



####################################################################
# Init code block
# By Assigning globals here, they occur after Function/Classes that reference them
# and are visable to both Classes, Functions and __main__
################################################################

# 1 = print, 2 = print and log_file, 3 = print and DBase_log
alert_lvl = 3
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
        cwd = cwd + '/' + module + ".log"	

	alert (module, 'starting up', alert_lvl, db, cwd)

	try:
		a = sys.argv[1]
	except:
		print "Unknown command line option in", module
		print "Usage is: jython RTLvalidator.py h/w/t "

	if sys.argv[1] == 'h':
		print "Usage is: jython ./RTLvalidator.py h/w/t "
		print "jython ./RTLvalidator.py h    -- prints this help message"
		print "jython ./RTLvalidator.py t    -- runs a test of dbase connection to Actor"
		print "jython ./RTLvalidator.py w    -- starts DICOM services"
	elif sys.argv[1] == 'w':
                # set up call to the method factory 
                err, res = call_factory (sys.argv[2], sys.argv[3], sys.argv[4], sys.argv[5], sys.argv[6])
		msg = " exiting web mode. res = \n%s" % (res)
	elif sys.argv[1] == 't':
                #err, res = test (db, alert_lvl)
                err, res = call_factory("agent_related", "list_by_agent",'me', '1', '2')
                #err, res = call_factory("agent_related", 'list_by_related','me', '1', '37')
                #err, res = call_factory("agent_related", 'read_agent_related','me', '1', '26977')
                #err, res = call_factory("agent_related", 'read_related_events', 'me', '1')
              
                # err, res = call_factory("agent_group", "c_mod_agent_grp",'me', '1', 'Mayo', '78', 'Clerk')
                #err, res = call_factory("agent_group", 'list_by_group','me', '1', 'Mayo')
                #err, res = call_factory("agent_group", 'list_by_agent','me', '1', '1')
                #err, res = call_factory("agent_group", "read_groups",'me', '1')
                #err, res =  call_factory("agent_group", "read_roles",'me', '1') 
                #err, res = call_factory("agent_group", 'read_agent_grp','me', '1', '26951')
		msg = 'exiting test mode '

	alert (module, msg, alert_lvl, db, cwd)
	db.close()
        if err > 0 :
                sys.exit (err)
        else :
                sys.exit (res)


