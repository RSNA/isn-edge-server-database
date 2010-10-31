/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package org.rsna.isn.domain;

/**
 *
 * @author wtellis
 */
public class RsnaDemographics {

	public RsnaDemographics()
	{
	}

	private String id;

	/**
	 * Get the value of id
	 *
	 * @return the value of id
	 */
	public String getId()
	{
		return id;
	}

	/**
	 * Set the value of id
	 *
	 * @param id new value of id
	 */
	public void setId(String id)
	{
		this.id = id;
	}

	private String lastName;

	/**
	 * Get the value of lastName
	 *
	 * @return the value of lastName
	 */
	public String getLastName()
	{
		return lastName;
	}

	/**
	 * Set the value of lastName
	 *
	 * @param lastName new value of lastName
	 */
	public void setLastName(String lastName)
	{
		this.lastName = lastName;
	}

	private String firstName;

	/**
	 * Get the value of firstName
	 *
	 * @return the value of firstName
	 */
	public String getFirstName()
	{
		return firstName;
	}

	/**
	 * Set the value of firstName
	 *
	 * @param firstName new value of firstName
	 */
	public void setFirstName(String firstName)
	{
		this.firstName = firstName;
	}

}
