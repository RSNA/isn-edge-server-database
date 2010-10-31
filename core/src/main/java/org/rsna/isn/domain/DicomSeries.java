/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.rsna.isn.domain;

import java.util.LinkedHashMap;
import java.util.Map;

/**
 *
 * @author wtellis
 */
public class DicomSeries
{
	private String seriesUid;

	/**
	 * Get the value of seriesUid
	 *
	 * @return the value of seriesUid
	 */
	public String getSeriesUid()
	{
		return seriesUid;
	}

	/**
	 * Set the value of seriesUid
	 *
	 * @param seriesUid new value of seriesUid
	 */
	public void setSeriesUid(String seriesUid)
	{
		this.seriesUid = seriesUid;
	}

	private String seriesDescription;

	/**
	 * Get the value of seriesDescription
	 *
	 * @return the value of seriesDescription
	 */
	public String getSeriesDescription()
	{
		return seriesDescription;
	}

	/**
	 * Set the value of seriesDescription
	 *
	 * @param seriesDescription new value of seriesDescription
	 */
	public void setSeriesDescription(String seriesDescription)
	{
		this.seriesDescription = seriesDescription;
	}

	private String modality;

	/**
	 * Get the value of modality
	 *
	 * @return the value of modality
	 */
	public String getModality()
	{
		return modality;
	}

	/**
	 * Set the value of modality
	 *
	 * @param modality new value of modality
	 */
	public void setModality(String modality)
	{
		this.modality = modality;
	}

	private Map<String, DicomObject> objects = new LinkedHashMap();

	public Map<String, DicomObject> getObjects()
	{
		return objects;
	}

}
