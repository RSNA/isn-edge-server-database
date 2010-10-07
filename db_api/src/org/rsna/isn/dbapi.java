import org.python.core.*;

public class dbapi extends java.lang.Object {
    static String[] jpy$mainProperties = new String[] {"python.modules.builtin", "exceptions:org.python.core.exceptions"};
    static String[] jpy$proxyProperties = new String[] {"python.modules.builtin", "exceptions:org.python.core.exceptions", "python.options.showJavaExceptions", "true"};
    static String[] jpy$packages = new String[] {};
    
    public static class _PyInner extends PyFunctionTable implements PyRunnable {
        private static PyObject s$0;
        private static PyObject s$1;
        private static PyObject s$2;
        private static PyObject s$3;
        private static PyObject i$4;
        private static PyObject s$5;
        private static PyObject s$6;
        private static PyObject i$7;
        private static PyObject s$8;
        private static PyObject s$9;
        private static PyObject s$10;
        private static PyObject s$11;
        private static PyObject s$12;
        private static PyObject s$13;
        private static PyObject s$14;
        private static PyObject s$15;
        private static PyObject s$16;
        private static PyObject s$17;
        private static PyObject s$18;
        private static PyObject s$19;
        private static PyObject s$20;
        private static PyObject s$21;
        private static PyFunctionTable funcTable;
        private static PyCode c$0_alertFromJava;
        private static PyCode c$1_init;
        private static PyCode c$2_dbapi;
        private static PyCode c$3_main;
        private static void initConstants() {
            s$0 = Py.newString("@sig public void dbapi()");
            s$1 = Py.newString("@sig public void alertFromJava(java.lang.String mod, java.lang.String msg)");
            s$2 = Py.newString("_rsna_dbapi: alertFromJava");
            s$3 = Py.newString("_rsna_dbapi: init");
            i$4 = Py.newInteger(1);
            s$5 = Py.newString("__main__");
            s$6 = Py.newString("web-handler");
            i$7 = Py.newInteger(0);
            s$8 = Py.newString("");
            s$9 = Py.newString("/");
            s$10 = Py.newString(".log");
            s$11 = Py.newString("starting");
            s$12 = Py.newString("h");
            s$13 = Py.newString("Usage is: jython ./isn-dp-api.py h/w/t ");
            s$14 = Py.newString("h    -- prints this help message");
            s$15 = Py.newString("t    -- runs a test of dbase connection to Actor");
            s$16 = Py.newString("exiting help mode ");
            s$17 = Py.newString("t");
            s$18 = Py.newString("123456");
            s$19 = Py.newString("exiting test mode \012 err= %s \012 res=%s");
            s$20 = Py.newString("Usage is: jython isn-dp-api.py h/w/t ");
            s$21 = Py.newString("/home/sglanger/dev/database/db_api/dbapi.py");
            funcTable = new _PyInner();
            c$0_alertFromJava = Py.newCode(3, new String[] {"self", "mod", "msg", "module"}, "/home/sglanger/dev/database/db_api/dbapi.py", "alertFromJava", false, false, funcTable, 0, null, null, 0, 17);
            c$1_init = Py.newCode(1, new String[] {"self", "module"}, "/home/sglanger/dev/database/db_api/dbapi.py", "init", false, false, funcTable, 1, null, null, 0, 17);
            c$2_dbapi = Py.newCode(0, new String[] {}, "/home/sglanger/dev/database/db_api/dbapi.py", "dbapi", false, false, funcTable, 2, null, null, 0, 16);
            c$3_main = Py.newCode(0, new String[] {}, "/home/sglanger/dev/database/db_api/dbapi.py", "main", false, false, funcTable, 3, null, null, 0, 16);
        }
        
        
        public PyCode getMain() {
            if (c$3_main == null) _PyInner.initConstants();
            return c$3_main;
        }
        
        public PyObject call_function(int index, PyFrame frame) {
            switch (index){
                case 0:
                return _PyInner.alertFromJava$1(frame);
                case 1:
                return _PyInner.init$2(frame);
                case 2:
                return _PyInner.dbapi$3(frame);
                case 3:
                return _PyInner.main$4(frame);
                default:
                return null;
            }
        }
        
        private static PyObject alertFromJava$1(PyFrame frame) {
            /* @sig public void alertFromJava(java.lang.String mod, java.lang.String msg) */
            frame.setlocal(3, s$2);
            frame.getglobal("alert").__call__(new PyObject[] {frame.getlocal(1), frame.getlocal(2), frame.getglobal("alert_lvl"), frame.getglobal("db"), frame.getglobal("cwd")});
            return Py.None;
        }
        
        private static PyObject init$2(PyFrame frame) {
            frame.setlocal(1, s$3);
            return new PyTuple(new PyObject[] {frame.getglobal("os").__getattr__("getcwd").__call__(), frame.getglobal("init_jdbc").__call__()});
        }
        
        private static PyObject dbapi$3(PyFrame frame) {
            /* @sig public void dbapi() */
            org.python.core.imp.importAll("isn_web_forms", frame);
            frame.setlocal("alertFromJava", new PyFunction(frame.f_globals, new PyObject[] {}, c$0_alertFromJava));
            frame.setlocal("init", new PyFunction(frame.f_globals, new PyObject[] {}, c$1_init));
            return frame.getf_locals();
        }
        
        private static PyObject main$4(PyFrame frame) {
            frame.setglobal("__file__", s$21);
            
            // Temporary Variables
            PyObject[] t$0$PyObject__;
            PyException t$0$PyException;
            
            // Code
            frame.setlocal("sys", org.python.core.imp.importOne("sys", frame));
            frame.setlocal("os", org.python.core.imp.importOne("os", frame));
            org.python.core.imp.importAll("isn_utils", frame);
            // global db, alert_lvl, cwd
            frame.setlocal("dbapi", Py.makeClass("dbapi", new PyObject[] {}, c$2_dbapi, null));
            frame.setglobal("alert_lvl", i$4);
            frame.getname("sys").__setattr__("stderr", frame.getname("sys").__getattr__("stdout"));
            if (frame.getname("__name__")._eq(s$5).__nonzero__()) {
                frame.setlocal("module", s$6);
                frame.setlocal("err", i$7);
                frame.setlocal("res", s$8);
                frame.setlocal("api", frame.getname("dbapi").__call__());
                t$0$PyObject__ = org.python.core.Py.unpackSequence(frame.getname("api").invoke("init"), 2);
                frame.setglobal("cwd", t$0$PyObject__[0]);
                frame.setglobal("db", t$0$PyObject__[1]);
                frame.setglobal("cwd", frame.getglobal("cwd")._add(s$9)._add(frame.getname("module"))._add(s$10));
                frame.getname("alert").__call__(new PyObject[] {frame.getname("module"), s$11, frame.getglobal("alert_lvl"), frame.getglobal("db"), frame.getglobal("cwd")});
                try {
                    if (frame.getname("sys").__getattr__("argv").__getitem__(i$4)._eq(s$12).__nonzero__()) {
                        Py.println(Py.None, s$13);
                        Py.println(Py.None, s$14);
                        Py.println(Py.None, s$15);
                        frame.setlocal("msg", s$16);
                    }
                    else {
                        if (frame.getname("sys").__getattr__("argv").__getitem__(i$4)._eq(s$17).__nonzero__()) {
                            frame.setlocal("api", frame.getname("dbapi").invoke("Patient", new PyObject[] {frame.getglobal("alert_lvl"), frame.getglobal("db"), frame.getglobal("cwd")}));
                            frame.setlocal("err", frame.getname("api").invoke("retrieve", new PyObject[] {s$18, s$8, s$8}));
                            if (frame.getname("err")._lt(i$4).__nonzero__()) {
                                frame.setlocal("msg", s$19._mod(new PyTuple(new PyObject[] {frame.getname("err"), frame.getname("api").__getattr__("patName")})));
                            }
                            else {
                                frame.setlocal("msg", frame.getname("api").__getattr__("msg"));
                            }
                        }
                    }
                }
                catch (Throwable x$0) {
                    t$0$PyException = Py.setException(x$0, frame);
                    frame.setlocal("msg", s$20);
                }
                frame.getname("alert").__call__(new PyObject[] {frame.getname("module"), frame.getname("msg"), frame.getglobal("alert_lvl"), frame.getglobal("db"), frame.getglobal("cwd")});
                frame.getglobal("db").invoke("close");
                if (frame.getname("err")._gt(i$7).__nonzero__()) {
                    frame.getname("sys").__getattr__("exit").__call__(frame.getname("err"));
                }
                else {
                    frame.getname("sys").__getattr__("exit").__call__();
                }
            }
            return Py.None;
        }
        
    }
    public static void moduleDictInit(PyObject dict) {
        dict.__setitem__("__name__", new PyString("dbapi"));
        Py.runCode(new _PyInner().getMain(), dict, dict);
    }
    
  
    
}
