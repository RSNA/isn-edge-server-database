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
public class DicomObject
{
	public DicomObject()
	{
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

	private String sopClassUid;

	/**
	 * Get the value of sopClassUid
	 *
	 * @return the value of sopClassUid
	 */
	public String getSopClassUid()
	{
		return sopClassUid;
	}

	/**
	 * Set the value of sopClassUid
	 *
	 * @param sopClassUid new value of sopClassUid
	 */
	public void setSopClassUid(String sopClassUid)
	{
		this.sopClassUid = sopClassUid;
	}

	private String transferSyntaxUid;

	/**
	 * Get the value of transferSyntaxUid
	 *
	 * @return the value of transferSyntaxUid
	 */
	public String getTransferSyntaxUid()
	{
		return transferSyntaxUid;
	}

	/**
	 * Set the value of transferSyntaxUid
	 *
	 * @param transferSyntaxUid new value of transferSyntaxUid
	 */
	public void setTransferSyntaxUid(String transferSyntaxUid)
	{
		this.transferSyntaxUid = transferSyntaxUid;
	}


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

}
