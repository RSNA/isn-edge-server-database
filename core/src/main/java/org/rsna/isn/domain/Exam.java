/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.rsna.isn.domain;

import java.util.Date;

/**
 *
 * @author wtellis
 */
public class Exam
{
	private String mrn = "";

	/**
	 * Get the value of mrn
	 *
	 * @return the value of mrn
	 */
	public String getMrn()
	{
		return mrn;
	}

	/**
	 * Set the value of mrn
	 *
	 * @param mrn new value of mrn
	 */
	public void setMrn(String mrn)
	{
		this.mrn = mrn;
	}

	protected String accNum = "";

	/**
	 * Get the value of accNum
	 *
	 * @return the value of accNum
	 */
	public String getAccNum()
	{
		return accNum;
	}

	/**
	 * Set the value of accNum
	 *
	 * @param accNum new value of accNum
	 */
	public void setAccNum(String accNum)
	{
		this.accNum = accNum;
	}

	private String status = "";

	/**
	 * Get the value of status
	 *
	 * @return the value of status
	 */
	public String getStatus()
	{
		return status;
	}

	/**
	 * Set the value of status
	 *
	 * @param status new value of status
	 */
	public void setStatus(String status)
	{
		this.status = status;
	}

	private Date statusTimestamp;

	/**
	 * Get the value of statusTimestamp
	 *
	 * @return the value of statusTimestamp
	 */
	public Date getStatusTimestamp()
	{
		return statusTimestamp;
	}

	/**
	 * Set the value of statusTimestamp
	 *
	 * @param statusTimestamp new value of statusTimestamp
	 */
	public void setStatusTimestamp(Date statusTimestamp)
	{
		this.statusTimestamp = statusTimestamp;
	}

	private RsnaDemographics rsnaDemographics;

	/**
	 * Get the value of rsnaDemographics
	 *
	 * @return the value of rsnaDemographics
	 */
	public RsnaDemographics getRsnaDemographics()
	{
		return rsnaDemographics;
	}

	/**
	 * Set the value of rsnaDemographics
	 *
	 * @param rsnaDemographics new value of rsnaDemographics
	 */
	public void setRsnaDemographics(RsnaDemographics rsnaDemographics)
	{
		this.rsnaDemographics = rsnaDemographics;
	}

	private Author signer;

	/**
	 * Get the value of signer
	 *
	 * @return the value of signer
	 */
	public Author getSigner()
	{
		return signer;
	}

	/**
	 * Set the value of signer
	 *
	 * @param signer new value of signer
	 */
	public void setSigner(Author signer)
	{
		this.signer = signer;
	}

	private String report;

	/**
	 * Get the value of report
	 *
	 * @return the value of report
	 */
	public String getReport()
	{
		return report;
	}

	/**
	 * Set the value of report
	 *
	 * @param report new value of report
	 */
	public void setReport(String report)
	{
		this.report = report;
	}

}
