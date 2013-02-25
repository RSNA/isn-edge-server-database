//import _rsna_dbapi.alertFromJava ;
package org.rsna.isn ;
import org.rsna.isn.test ;
import java.lang.String ;
//import org.rsna.isn.dbapi ;

/**
 *
 * @author sglanger
 * Class: HelloWOrld
 * Purpose: test calling the the jython db-api using jythonc
 *
 */
public class HelloWorld {

    /**
     *
     * @param args
     * Purpose: main
     */
    public static void main(String[] args) {
        java.lang.String s ="hi";

        System.out.println("Goodbye cruel World");
        test obj = new test ();
        obj.bang() ;

    }
}



