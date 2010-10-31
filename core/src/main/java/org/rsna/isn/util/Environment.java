/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.rsna.isn.util;

import java.io.File;
import org.apache.commons.lang.StringUtils;
import org.rsna.isn.dao.ConfigurationDao;

/**
 *
 * @author wtellis
 */
public class Environment
{
	private static final File dcmDir;

	private static final File tmpDir;

	static
	{
		try
		{
			ConfigurationDao dao = new ConfigurationDao();
			String path = dao.getConfiguration("dcm-dir-path");
			if (StringUtils.isBlank(path))
				throw new ExceptionInInitializerError("dcm-dir-path is not defined");

			dcmDir = new File(path);
			dcmDir.mkdir();
			if (!dcmDir.isDirectory())
				throw new ExceptionInInitializerError(dcmDir + " is not a directory");


			
			path = dao.getConfiguration("tmp-dir-path");
			if (StringUtils.isBlank(path))
				throw new ExceptionInInitializerError("tmp-dir-path is not defined");
			tmpDir = new File(path);
			tmpDir.mkdir();
			if (!tmpDir.isDirectory())
				throw new ExceptionInInitializerError(tmpDir + " is not a directory");
		}
		catch (Exception ex)
		{
			throw new ExceptionInInitializerError(ex);
		}

	}

	private Environment()
	{
	}

	public static File getDcmDir()
	{
		return dcmDir;
	}

	public static File getTmpDir()
	{
		return tmpDir;
	}

}
