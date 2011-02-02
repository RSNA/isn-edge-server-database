 /* Copyright (c) <2010>, <Radiological Society of North America>
 * All rights reserved.
 * Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 * Neither the name of the <RSNA> nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND
 * CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
 * THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
 * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
 * USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY
 * OF SUCH DAMAGE.
 */

package org.rsna.isn ;
import org.rsna.isn.GetPath ;
import java.io.* ;
import java.util.* ;

/**
 * @author sglanger
 * @version 1.0
 * @param
 * @return
 * Purpose: Examine the /rsna/logs direc and filter all of them 
 * 	into separate debug, warn and info files
 * External Dependencies: /rsna/logs/*.log
 */

public class LogCat {

    /**
     * @param args the command line arguments
     * Purpose:  filter the WARNING, INFO and DEBUG lines
     *      from each app log file to single large
     *      files for the Web Admin app log viewer
     */
    public static void main(String[] args)
    {

        GetPath path = new GetPath("testlin");
        String info = path.path_logs + "info";
        String warn = path.path_logs + "warn";
        String debug = path.path_logs + "debug";
        String[] files = {info, warn, debug};
        delFiles (files);

        // testing list_cat
        //String[] result = list_cat (files, "booger");
        //System.out.println ("result=" + result[3]);
        
        File dir = new File(path.path_logs);
        String[] logs = dir.list();       
        for (String i : logs)
        {
            if (i.contains(".log") & !i.contains(".log."))
            {
                i = new String (path.path_logs + i);
                System.out.println("string=" + i);
                File f = new File(i);
                try
                {
                    BufferedReader reader = new BufferedReader(new FileReader(f));
                    BufferedWriter info_w = new BufferedWriter(new FileWriter(info, true));
                    BufferedWriter warn_w = new BufferedWriter(new FileWriter(warn, true));
                    BufferedWriter debug_w = new BufferedWriter(new FileWriter(debug,true));

                    String line = null;
                    while ((line=reader.readLine()) != null)
                    {
                        //System.out.println("line=" + line);
                        if (line.contains("INFO"))
                        {
                            //System.out.println("line=" + line);
                            info_w.write(line);
                            info_w.newLine();   // Write system dependent end of line.

                        } else if (line.contains("DEBU"))
                        {
                            //System.out.println("line=" + line);
                            debug_w.write(line);
                            debug_w.newLine();   // Write system dependent end of line.

                        } else if (line.contains("WARN"))
                        {
                            //System.out.println("line=" + line);
                            warn_w.write(line);
                            warn_w.newLine();   // Write system dependent end of line.
                        }
                    }
                    reader.close();
                    info_w.close();
                    warn_w.close();
                    debug_w.close();

                } catch (IOException e)
                {
                    System.err.println(e);
                    System.exit(1);
                }
            }
        }
    }



    /**
     * 
     * @param a is a String array
     * @param B a string to concat to it
     * @return the concatted string array
     *
     * Purpose: oddly, concatting string arrays is very hard
     */
    public static String[] listCat (String[] a, String B)
    {

        //java.util.List mylist = new java.util.List();
        ArrayList<String> mylist = new ArrayList<String>();
        mylist.addAll(Arrays.asList(a));
        mylist.add(B);
        //System.out.println("list=" + mylist);

        // from Tyler Holm
        return mylist.toArray(new String[mylist.size()]);
    }

    
    /**
     *
     * @param 
     * @return
     * Purpose: delete the warn, info and debug files so they
     * 		can be rebuilt from scratch
     */
    public static String delFiles (String[] str)
    {
        //int err = 0;
        
        for (String i : str)
        {
            // del each file i
            File f = new File(i);
           // Make sure the file or directory exists and isn't write protected
            if (!f.exists())
            {
                String err = new String("Delete: no such file or directory: " + f);
                return (err);
            }

            if (!f.canWrite())
            {
                String err = new String("Delete: write protected: "+ f);
                return (err);
            }

            // Attempt to delete it
            boolean success = f.delete();
            if (!success)
            {
                String err = new String("Delete: deletion failed");
                return (err);
            }
        }
        return ("Success");
    }
 }



