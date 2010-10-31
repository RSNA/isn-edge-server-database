/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.rsna.isn.domain;

import java.io.File;

/**
 *
 * @author wtellis
 */
public class DicomKos
{
	private File file;

	/**
	 * Get the value of file
	 *
	 * @return the value of file
	 */
	public File getFile()
	{
		return file;
	}

	/**
	 * Set the value of file
	 *
	 * @param file new value of file
	 */
	public void setFile(File file)
	{
		this.file = file;
	}

	private String sopInstanceUid;

	/**
	 * Get the value of sopInstanceUid
	 *
	 * @return the value of sopInstanceUid
	 */
	public String getSopInstanceUid()
	{
		return sopInstanceUid;
	}

	/**
	 * Set the value of sopInstanceUid
	 *
	 * @param sopInstanceUid new value of sopInstanceUid
	 */
	public void setSopInstanceUid(String sopInstanceUid)
	{
		this.sopInstanceUid = sopInstanceUid;
	}

}
