#!/usr/bin/python

###################### form.py ####################################
# Author: SG Langer, 10/13/2006
# Purpose: Middle-ware from Apache AJAX to web-handler.py
#
# External Files:
# 1) This calls web-handler.py (which is run by jython)
# example of mod_Python server side parsing from 
# http://localhost/manual/mod/mod_python/hand-pub-intro.html
#################################################################
import string, os, sys, time

try:
        from mod_python import util
except:
        # when called from command line we won't resolve mod_python
        pass

# GLobal scope vars
global alert_lvl, home, jypath, cwd


def alert(mod, msg):
##########################################
# Purpose: One stop shopping for communicating errors
#	   Can write to StdOut, log file, email, pgSQL
#
# Caller: module wide  
# Note: GLobal alert_lvl sets behavior
#############################################
	module="form_alert"

	date = time.strftime("%Y-%m-%d")
	_time = time.strftime("%H:%M:%S")
	buf2 = 'in '+ mod+ ' time = %s--%s' % (date, _time) 
	buf = buf2 +' \n msg = '+ msg + '\n\n'
	if alert_lvl == 1:
		print buf
	elif alert_lvl == 2:
		print buf
		# do an append write (r, w, a)
		name= "%s/%s.log" % (home, module)
		f= open(name, 'a')
		f.write(buf)
		f.close()
	else:
		print "in ", module, " unknown alert level"

	return


def parser (klas, method, user, cert, args):
####################################################
# Purpose: This is a middle-man. Its entire reason
#       for being is that Apache cannot call Jython direct
#       to run web-handler.py (which uses the JDBC bridge)
#
# Caller: Ajax calls from Apache via the HTML pages. mod_python
#       cleverly maps CGI tag values to func args
###############################################
        module = "form.py: parser"
        res = ""
        # sys.stderr = sys.stdout

        # first we use APACHE mod_python parsers to get args for call_str
        call_str = "%sjython %sweb_handler.py w %s %s %s %s %s 2>&1" % (jypath, home, klas, method, user, cert, args)
        alert (module, call_str)

        # now call Web-handler and format the return into clean tuples
        for line in os.popen(call_str).readlines() :
                # want to peel off the () but leave the \n
                start = string.find(line, "(") + 1
                end = string.find(line, ")")
                line = line[start:end] 
                line = string.strip(line) + "\n"
                res = res + line 

        # Why is popen not working from Web call???
        # Its Jython writing to stdErr again, see img-arch.pl, use
        #  os.popen('command 2>&1')
        msg = " exiting, res = \n%s \n ***************" % (res)
        alert (module, msg)
        return (res)


####################################################################
# Init code block
# By Assigning globals here, they occur after Function/Classes that reference them
# and are visable to both Classes, Functions and __main__
################################################################

# Alert-lvl behavior: One means print, 2 means logfile
alert_lvl = 2
home = "/home/sglanger/code/prime/img-arch/web/"
jypath = "/usr/jython2.2/"
cwd = os.getcwd()


if __name__ == '__main__':
#######################################
# Purpose: command line testing
#       Need to comment out the mod_python import
#       when running from command line. otherwise complains
#       CAN"T FIND APACHE
#####################################     
        mod = "form.py:main"

	ret = parser ("agent_related", "list_by_agent", 1, 1, 2)
	sys.exit (ret)


