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
import java.io.File ;

/**
 * @author SG Langer
 * @version V1.2
 * @param
 * @return
 * Package name: org.rsna.isn.xxx
 * Purpose: Provide an OS neutral way to inform the caller the paths to
 *          RSNA folders
 * External Dependencies: environment var RSNA_ROOT
 */
public class GetPath
{
    public String path_root ;
    public String path_logs ;
    public String path_properties ;
    public String path_dcm_in ;
    public String path_dcm_out ;
    
    /**
     *
     * @param mode can be "testlin" or "testwin" anything else is live
     * @return  Constructors are private and cannot have returns
     * Purpose: This constructor version looks for an environment
     *      variable RSNA_ROOT and then computes other paths from that.
     *      If it fails to find the env_var RSNA_ROOT it uses OS detection
     *      to guess the default OS dependant path
     *
     * Example:
     *  http://www.rgagnon.com/javadetails/java-0150.html
     */
    GetPath (String mode)
    {

        if (mode.contains("testlin"))
        {
            path_root = "/rsna/";
        } else if (mode.contains("testwin"))
        {
            path_root = "c:\rsna" + File.pathSeparator ;
        } else
        {
            //this is a live system
            //attempting to find env_var
            path_root = System.getProperty("RSNA_ROOT") ;
        }
        
        if (path_root.isEmpty())
        {
            defaultPaths ();
        }   else
        {
            computePaths () ;
        }      
    }


    /**
     * 
     * Purpose: Based on path_root, build up the proper OS
     *      paths for the RSNA folder
     */
    private void computePaths ()
    {

        if (path_root.contains("/"))
        {
            //this is a Linux box
            //System.out.println ("here");
            path_logs = path_root + "logs/";
            path_properties = path_root + "properties/";
            path_dcm_in = path_root + "dcm/";
            path_dcm_out = path_root + "dcmout/";

        } else
        {
            //this is a Windows box
            path_logs = path_root + "logs"  + File.pathSeparator ;
            path_properties = path_root + "properties"  + File.pathSeparator ;
            path_dcm_in = path_root + "dcm"  + File.pathSeparator ;
            path_dcm_out = path_root + "dcmout"  + File.pathSeparator ;
        }
    }

    /**
     *
     * Purpose: RSNA_ROOT was not found, use OS detection
     *      and guess defaults
     */
    private void defaultPaths ()
    {
        String os = System.getProperty("os.name").toLowerCase() ;
        //System.out.println ("os =" + os);

        if (os.contains("wind"))
        {
            path_root = "c:\rsna"  + File.pathSeparator;
            path_logs = path_root  + "logs" + File.pathSeparator ;
            path_properties = path_root  + "properties"  + File.pathSeparator;
            path_dcm_in = path_root + "dcm"  + File.pathSeparator;
            path_dcm_out = path_root + "dcmout"  + File.pathSeparator;

        } else if (os.contains("lin"))
        {
            path_root = "/rsna/";
            path_logs = path_root + "logs/";
            path_properties = path_root + "properties/";
            path_dcm_in = path_root + "dcm/";
            path_dcm_out = path_root + "dcmout/";
        }
    }
}
