#!/usr/bin/env jython
##########################  isn-utils.py  #######################
# Author: Steve Langer
# Date: 7/29/2010
#
# Purpose: dbase tools and methods
#################################################################
import time, sys, string

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


def callStoredProc(db, sql):
################################################
# Purpose: One stop shopping for pgSQL communication
#	   Use "func" as called Procedure, rest are args
#
# Caller: classes in isn-web-forms.py
# SQL Server example from http://www.jython.org/docs/zxjdbc.html
############################################
	module="utils: callStoredProc"
	err = 1
	result = 0
	res2 = []
	
	c = db.cursor(1)
        # print "in mod=%s \n %s" % (module, sql)
        try:
		# c.callproc(func, args)	# Did not work in old zxJDBC, use SQL style in Execute
		c.execute(sql)
		cnt = c.rowcount
		res2 = c.fetchall()
		# print "res = %s" % res2
		err = 0
        except:
                #print "in outer except = ", sys.exc_type, sys.exc_value
                # we hit this becuase the Qry returned Null
		print "cursor exception"
                result = '%s \n' % ("None")

        db.commit()
	c.close()
	# SGL 7/4/06 Return both err Boolean and any Msg/Tuple from Dbase
	# This means caller has to do a little work to parse, but it
	# allows callers to get Tuples back. Should call like
	# 		err, msg = callStoredProc (func)
        #print "err %s, result %s " % (err, result)
	return err, cnt, res2


def init_jdbc():
############################
#Purpose: open a JDBC connection to
#	  this Actor's pgSQL dbase
#Caller: main
#############################
        module="utils: init_jdbc"
        # print "in ", module
        d,u,p,v = "jdbc:postgresql://localhost/rsnadb","edge","edge01","org.postgresql.Driver"
	#d,u,p,v = "jdbc:postgresql://172.22.3.85/rsnadb","edge","edge01","org.postgresql.Driver"
	
        try :
                # if called from command line with .login CLASSPATH setup right, this works
                db = zxJDBC.connect(d, u, p, v)
        except:
                # if called from Apache or account where the .login has not set CLASSPATH
                # need to use run-time classPathHacker
                try :
                        jarLoad = classPathHacker()
                        a = jarLoad.addFile("postgresql.jar")
                        db = zxJDBC.connect(d, u, p, v)
                except :
			sys.exit ("still failed \n%s" % (db) )
                        sys.exit ("still failed \n%s" % (sys.exc_info() ))
        return db


def test(db, alert_lvl, cwd):
#############################
# Purpose: test if we can connect 
#	   as the given user and dbase
#
# Caller: Main test case
###############################
	module="utils: test"
	 	
        alert (module, "test", alert_lvl, db, cwd)
	c = db.cursor(1)
	sql = "select read_logs('%','%','%','%')"
	sql = "select  * from read_events('dicom')"
	sql = "select * from patients"
	c.execute(sql)
	# c.execute("select read_logs('%','%','%','%')")
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
		#print "u = %s" % u
		
                parameters = self.jarray.array([self.java.net.URL], self.java.lang.Class)
                sysloader =  self.java.lang.ClassLoader.getSystemClassLoader()
                sysclass = self.java.net.URLClassLoader
                method = sysclass.getDeclaredMethod("addURL", parameters)
                a = method.setAccessible(1)
                jar_a = self.jarray.array([u], self.java.lang.Object) 
                b = method.invoke(sysloader, jar_a)
                return b



