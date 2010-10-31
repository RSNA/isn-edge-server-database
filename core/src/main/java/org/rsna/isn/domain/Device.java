/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package org.rsna.isn.domain;

/**
 *
 * @author wtellis
 */
public class Device
{
	private String host;

	/**
	 * Get the value of host
	 *
	 * @return the value of host
	 */
	public String getHost()
	{
		return host;
	}

	/**
	 * Set the value of host
	 *
	 * @param host new value of host
	 */
	public void setHost(String host)
	{
		this.host = host;
	}

	private int port;

	/**
	 * Get the value of port
	 *
	 * @return the value of port
	 */
	public int getPort()
	{
		return port;
	}

	/**
	 * Set the value of port
	 *
	 * @param port new value of port
	 */
	public void setPort(int port)
	{
		this.port = port;
	}

	private String aeTitle;

	/**
	 * Get the value of aeTitle
	 *
	 * @return the value of aeTitle
	 */
	public String getAeTitle()
	{
		return aeTitle;
	}

	/**
	 * Set the value of aeTitle
	 *
	 * @param aeTitle new value of aeTitle
	 */
	public void setAeTitle(String aeTitle)
	{
		this.aeTitle = aeTitle;
	}

}
