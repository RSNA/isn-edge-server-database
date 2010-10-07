#!/usr/bin/env jython
##########################  utils.py  ############################
# Author: Steve Langer
# Date: 1/7/2007
#
# Purpose: collect common methods used by the DICOM, Web and HL7 codes
#################################################################
import time, sys
# the below does not exist in mod_python
from com.ziclix.python.sql import zxJDBC

# Global vars
global db, alert_lvl, cwd

def alert(mod, msg, alert_lvl, db, cwd):
##########################################
# Purpose: One stop shopping for communicating errors
#	   Can write to StdOut, log file, email, pgSQL
#
# Caller: module wide and Pixelmed lib. 
# Note: GLobal alert_lvl sets behavior
#############################################
	module="utils_alert"

	date = time.strftime("%Y-%m-%d")
	_time = time.strftime("%H:%M:%S")
	buf2 = 'in '+ mod+ ' time = %s--%s' % (date, _time) 
	buf = buf2 +' \n msg = '+ msg + '\n\n'
	if alert_lvl == 1:
		print buf
	elif alert_lvl == 2:
		print buf
		# do an append write (r, w, a)
		f= open(cwd, 'a')
		f.write(buf)
		f.close()
	elif alert_lvl == 3:
		# print buf
		s = "create_log ('%s', '%s')" % (mod, msg)
		err, status = callStoredProc (db, s)
	else:
		print "in ", module, " unknown alert level"

	return


def callStoredProc(db, func):
################################################
# Purpose: One stop shopping for pgSQL communication
#	   Use "func" as called Procedure, rest are args
#
# Caller: DICOM handler
# SQL Server example from http://www.jython.org/docs/zxjdbc.html
#############################################
	module="utils: callStoredProc"
	s='select  '
	err = 1
	result = ' '

	c = db.cursor(1)
	sql= s + func 
        #print sql

	# c.callproc(func, args)	# Does not work in zxJDBC, use SQL style in Execute
	c.execute(sql)
        try:
                for a in c.fetchall():
                        #print a
		        try:
			     # If here, we have a multi-line list (string), second index gets element in 
			     # the selected row
			     # print a[0][0:]
			     if a[0][0:2] == '1:' :
				    #print "failure"
				    db.rollback()
				    c.close()
				    return err, a
			     else :
				    #print "success, a=%s" % (a)
				    # There are 3 possible returns: a string, a Tuple, a multi Tuple
				    err = 0			
				    # if this is a multi-line-Tuple cannot break out, but
				    # must build up the multi-tuple     
				    result = result + '%s' % (a)
		        except:
			     #print "in CallStoreProc, hit exception = ", sys.exc_type, sys.exc_value	
			     # If this is an Attribute Error, the return 'a' is a tuple and
			     # the above a[][n:p] syntax is not valid
			     err = 0
			     result = result + '%s \n' % (a[0])

        except:
                #print "in outer except = ", sys.exc_type, sys.exc_value
                # we hit this becuase the Qry returned Null
                err = 0
                result = '%s \n' % ("None")

        db.commit()
	c.close()
	# SGL 7/4/06 Return both err Boolean and any Msg/Tuple from Dbase
	# This means caller has to do a little work to parse, but it
	# allows callers to get Tuples back. Should call like
	# 		err, msg = callStoredProc (func)
        #print "err %s, result %s " % (err, result)
	return err, result


def checkCert(ID, cert):
##########################################
# Purpose: Interrogate this host agent and see
#	a) if they have a Cert and 
#	b) is it known to be valid from Authenticator?
#
#       More info, this is the outer ring of a 2 ring
#       security system. Here we vet only that the connecting
#       agent has a valid Session Cert. We do not know if
#       that Cert is known to the Actor Dbase, what group or
#       what privs the Cert has. Those checks are done inside
#       the dbase so they are not exposed on the network
#
# Caller: any of the methods in the Web/DICOM/HL7 handler classes 
#       that call callStoredProc
#############################################
	module="utils: checkCERT"
	err = 1

	# right now this is a stub until I figure out how to
	# hook into a Kerberos client
	# pgSQL actually has a method to use Ker4 or Ker5

	err =0 
	return err


def init_jdbc():
############################
#Purpose: open a JDBC connection to
#	  this Actor's pgSQL dbase
#Caller: main
#############################
        module="utils: init_jdbc"
        # print "in ", module
        d,u,p,v = "jdbc:postgresql://localhost/img_arc2","postgres","","org.postgresql.Driver"

        try :
                # if called from command line with .login CLASSPATH setup right, this works
                db = zxJDBC.connect(d, u, p, v)
        except:
                # if called from Apache or account where the .login has not set CLASSPATH
                # need to use run-time classPathHacker
                try :
                        jarLoad = classPathHacker()
                        a = jarLoad.addFile("/usr/share/java/postgresql-jdbc3.jar")
                        db = zxJDBC.connect(d, u, p, v)
                except :
                        sys.exit ("still failed \n%s" % (sys.exc_info() ))

        return db


def test(db, alert_lvl):
#############################
# Purpose: test if we can connect 
#	   as the given user and dbase
#
# Caller: Main test case
###############################
	module="utils: test"

        alert (module, "test", alert_lvl, db)
	c = db.cursor(1) 
	c.execute("select read_logs('%','%','%','%')")
 	# c.execute("select  * from read_events('dicom')") 
	for a in c.fetchall():
		print a

	c.close()
	return 


class classPathHacker :
##########################################################
# from http://forum.java.sun.com/thread.jspa?threadID=300557
#
# Author: SG Langer Jan 2007 translated the above Java to this
#       Jython class
# Purpose: Allow runtime additions of new Class/JARs either from
#       local files or URL. This permits programmatic control of 
#       JARs when don't have access to envVariable CLASSPATH (as
#       is true when running CGI from APACHE) 
######################################################
        import java.lang.reflect.Method
        import java.io.File, java.net.URL, java.net.URLClassLoader 
        import jarray

        def addFile (self, s):
        #############################################
        # Purpose: If adding a file/jar call this first
        #       with s = path_to_jar 
        #############################################
                module = "utils:classPathHacker: addFile"

                # make a URL out of 's'
                f = self.java.io.File (s)
                u = f.toURL ()
                a = self.addURL (u)
                return a

        def addURL (self, u):
        ##################################
        # Purpose: Call this with u= URL for
        #       the new Class/jar to be loaded
        #################################
                module = "utils:classPathHacker: addURL"

                parameters = self.jarray.array([self.java.net.URL], self.java.lang.Class)
                sysloader =  self.java.lang.ClassLoader.getSystemClassLoader()
                sysclass = self.java.net.URLClassLoader
                method = sysclass.getDeclaredMethod("addURL", parameters)
                a = method.setAccessible(1)
                jar_a = self.jarray.array([u], self.java.lang.Object) 
                b = method.invoke(sysloader, jar_a)
                return b



