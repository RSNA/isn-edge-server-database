#!/usr/bin/env jython
######################### web_forms.py ############################
# Author: Steve Langer
# Date:   9/21/06
# Purpose: This is a child file of web-handler.py, it contains the 
#       the Class objects used in that file
#
# External Dependencies
# 1) the file "form.py" which can be called from Apache, and calls web-handler.py
# 2) the file web-handler.py which calls into this
###############################################################
from  web_handler import alert, callStoredProc
import string


class agent_related :
#####################################################
# Purpose: Handle all the AJAX I/O to pgSQL-dbase
#       for the indicated web page 
#Caller: Web page 'agent_related'
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
		module="web_forms:agent_related: c_alert"
		
		alert(mod, msg, alert_lvl)
		return


        def c_mod_agent_rel (self, agent, cert, related, roles):
        ##########################################################
        # Purpose: Set the share events between an agent/related agent pair
        #
        # Caller: from Web-server
        ######################################################
		module="web_forms::agent_related: c_mod_agent_rel"

                # call stored proc
                # Need to modify the StoredProc below to accept "Role" array
		f = "cmod_agent_rel ('%s', '%s', '%s'. '%s')" % (agent, cert, related, roles)
		err_status, result = callStoredProc (db, f)
                
                # and return status, 0 - no err, 1 = err
                return err_status, result


        def formRow (self, result):
        ##########################################
        # Purpose: Strip extra stuff from returns from list_by funcs
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


        def formDroplist (self, result):
        ##########################################
        # Purpose: Strip extra stuff from returns from list_by funcs
        #
        # Caller: list_by_group and list_by_agent 
        #############################################
                module="web_forms::agent_related: formDropList"
                res = ""

                lst = string.split(result, "\n")
                for  a in lst:
                        try :
                                # print a
                                parts = string.split(a, ",")
                                tmp = "%s \n" % (parts[1])
                                res = "%s %s" % (res, tmp)
                                # print tmp
                        except :
                                pass

                return res


	def list_by_agent (self, userID, cert, agent):
	##########################################
	# Purpose: Receives request from Javascript in web page 
	#
	# Caller: Actor web page
	#############################################
		module="web_forms::agent_related: list-by-agent"

		f = "view_agent_related ('%s', '%s', '%s', '%%')" % (userID, cert, agent)
		err_status, result = callStoredProc (db, f)
                result = self.formRow (result)
		# 0 = no err, 1 = err. 
		return err_status, result 


	def list_by_related (self, userID, cert, rel_agent):
	##########################################
	# Purpose: Receives request from Javascript in web page 
	#
	# Caller: Actor web page
	#############################################
		module="web_forms:agent_related: list-by-related"

		f = "view_agent_related ('%s', '%s', '%%', '%s')" % (userID, cert, rel_agent)
		err_status, result = callStoredProc (db, f)
                #print "mod %s, err = %s, res = %s" % (module, err_status, result)
                result = self.formRow (result)
                #print "after call %s" % (result)
		# 0 = no err, 1 = err.    
		return err_status, result 


        def read_related_events (self, userID, cert):
        ##########################################
	# Purpose: When the web page loads, it calls this
	#            to populate "event" grid with alphabetized
        #            list of events
        # Caller: Onload event for web page
        #######################################
		module="web_forms:agent_related: read-related_events"

		f = "read_related_events ('%s', '%s')" % (userID, cert)
		err_status, result = callStoredProc (db, f) 
                result = self.formDroplist (result)
		return err_status, result 


	def read_agent_related (self, userID, cert, oid):
	##########################################
	# Purpose: Looks up a given row from the "groups" table and 
	#            decodes the role mask for web display
        #
	# Caller: Actor web page "OnClick" event in listing pane
	#############################################
		module="web_forms:agent_related: read-agent_related"

		f = "read_agent_related_event ('%s', '%s', '%s')" % (userID, cert, oid)
		err_status, result = callStoredProc (db, f)

		return err_status, result 


class agent_group :
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

        def c_mod_agent_grp (self, userID, cert, agent, grp, roles):
        ##########################################################
        # Purpose: Take contents from agent-grp-relation FOrm and pass
        #               to dbase table "groups".
        #
        # Caller: 
        # Args:  agent, grp obvious. Roles is a string array containing 
        #           the "roles" that were checked in the form
        ######################################################
		module="web_forms:agent_group: c_mod_agent_grp"
 
                # call stored proc
                # Need to modify the StoredProc below to accept "Role" array
		f = "cmod_agent_grp ('%s', '%s','%s', '%s'. '%s')" % (userID, cert, grp, agent, roles)
		err_status, result = callStoredProc (db, f)
                
                # and return status, 0 - no err, 1 = err
                return err_status, res


        def formRow (self, result):
        ##########################################
        # Purpose: Strip extra stuff from returns from list_by funcs
        #
        # Caller: list_by_group and list_by_agent 
        #############################################
                module="web_forms:agent_group: formRow"
                res = ""

                lst = string.split(result, "\n")
                for  a in lst:
                        try :
                                # print a
                                parts = string.split(a, ",")
                                tmp = "%s %s %s %s \n" % (parts[0], parts[1], parts[4],parts[5])
                                res = "%s %s" % (res, tmp)
                                # print tmp
                        except :
                                pass

                return res


        def formDroplist (self, result):
        ##########################################
        # Purpose: Strip extra stuff from returns from list_by funcs
        #
        # Caller: list_by_group and list_by_agent 
        #############################################
                module="web_forms:agent_group: formDroplist"
                res = ""

                lst = string.split(result, "\n")
                for  a in lst:
                        try :
                                # print a
                                parts = string.split(a, ",")
                                tmp = "%s \n" % (parts[0])
                                res = "%s %s" % (res, tmp)
                                # print tmp
                        except :
                                pass

                return res

  
	def list_by_group (self, userID, cert,  group):
	##########################################
	# Purpose: Receives request from Javascript in web page 
	#
	# Caller: Actor web page
	#############################################
		module="web_forms:agent_group: list-by-group"

		# if we got here the Agent has a valid Kerberos Cert
		# SO now check for authorization on this Actor for
		# this caller to do desired operation to the desired Study
		f = "view_grp_agent_role2 ('%s', '%s', '%%', '%s')" % (userID, cert, group)
		err_status, result = callStoredProc (db, f)
                res = self.formRow (result)
		# 0 = no err, 1 = err. 
		return err_status, res 	


	def list_by_agent (self, userID, cert, agent):
	##########################################
	# Purpose: Receives request from Javascript in web page 
	#
	# Caller: Actor web page
	#############################################
		module="web_forms:agent_group: list-by-agent"

		f = "view_grp_agent_role2 ('%s', '%s', '%s', '%%')" % (userID, cert, agent)
		err_status, result = callStoredProc (db, f)
                result = self.formRow (result)
		# 0 = no err, 1 = err. 
                # print "err = %s, res = %s" % (err_status, result)
		return err_status, result 	


        def read_roles (self, userID, cert):
        ##########################################
	# Purpose: When the web page loads, it calls this
	#            to populate "role" grid
        #
        # Caller: Onload event for web page
        #######################################
		module="web_forms:agent_group: read-roles"

		f = "read_roles ('%s', '%s')" % (userID, cert) 
		err_status, result = callStoredProc (db, f) 
                result = self.formDroplist (result)
		return err_status, result 


        def read_groups (self, userID, cert):
        ####################################
	# Purpose: When the web page loads, it calls this
	#            to populate "group" drop down list
        #
        # Caller: Onload event for web page
        #######################################
		module="web_forms:agent_group: read-groups"

		f = "read_groups ('%s', '%s')" % (userID, cert) 
		err_status, result = callStoredProc (db, f) 
                result = self.formDroplist (result)
		return err_status, result 


	def read_agent_grp (self, userID, cert, oid):
	##########################################
	# Purpose: Looks up a given row from the "groups" table and 
	#            decodes the role mask for web display
        #
	# Caller: Actor web page "OnClick" event in listing pane
	#############################################
		module="web_forms:agent_group: read-agent_grp"

		f = "read_grp_agent_role ('%s', '%s','%s')" % (userID, cert, oid)
		err_status, result = callStoredProc (db, f)
                # Result should look like
                # "agent", "group", "role1, role2, role3 ..."
		# 0 = no err, 1 = err. 
		return err_status, result 

