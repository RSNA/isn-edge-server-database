/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.rsna.isn.domain;

import java.util.Date;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 *
 * @author wtellis
 */
public class DicomStudy
{
	public DicomStudy()
	{
	}

	private String patientName;

	/**
	 * Get the value of patientName
	 *
	 * @return the value of patientName
	 */
	public String getPatientName()
	{
		return patientName;
	}

	/**
	 * Set the value of patientName
	 *
	 * @param patientName new value of patientName
	 */
	public void setPatientName(String patientName)
	{
		this.patientName = patientName;
	}

	private String patientId;

	/**
	 * Get the value of patientId
	 *
	 * @return the value of patientId
	 */
	public String getPatientId()
	{
		return patientId;
	}

	/**
	 * Set the value of patientId
	 *
	 * @param patientId new value of patientId
	 */
	public void setPatientId(String patientId)
	{
		this.patientId = patientId;
	}

	private String sex;

	/**
	 * Get the value of sex
	 *
	 * @return the value of sex
	 */
	public String getSex()
	{
		return sex;
	}

	/**
	 * Set the value of sex
	 *
	 * @param sex new value of sex
	 */
	public void setSex(String sex)
	{
		this.sex = sex;
	}

	private Date birthdate;

	/**
	 * Get the value of birthdate
	 *
	 * @return the value of birthdate
	 */
	public Date getBirthdate()
	{
		return birthdate;
	}

	/**
	 * Set the value of birthdate
	 *
	 * @param birthdate new value of birthdate
	 */
	public void setBirthdate(Date birthdate)
	{
		this.birthdate = birthdate;
	}

	private String accessionNumber;

	/**
	 * Get the value of accessionNumber
	 *
	 * @return the value of accessionNumber
	 */
	public String getAccessionNumber()
	{
		return accessionNumber;
	}

	/**
	 * Set the value of accessionNumber
	 *
	 * @param accessionNumber new value of accessionNumber
	 */
	public void setAccessionNumber(String accessionNumber)
	{
		this.accessionNumber = accessionNumber;
	}

	private Date studyDateTime;

	/**
	 * Get the value of studyDateTime
	 *
	 * @return the value of studyDateTime
	 */
	public Date getStudyDateTime()
	{
		return studyDateTime;
	}

	/**
	 * Set the value of studyDateTime
	 *
	 * @param studyDateTime new value of studyDateTime
	 */
	public void setStudyDateTime(Date studyDateTime)
	{
		this.studyDateTime = studyDateTime;
	}

	private String studyDescription;

	/**
	 * Get the value of studyDescription
	 *
	 * @return the value of studyDescription
	 */
	public String getStudyDescription()
	{
		return studyDescription;
	}

	/**
	 * Set the value of studyDescription
	 *
	 * @param studyDescription new value of studyDescription
	 */
	public void setStudyDescription(String studyDescription)
	{
		this.studyDescription = studyDescription;
	}

	private String studyUid;

	/**
	 * Get the value of studyUid
	 *
	 * @return the value of studyUid
	 */
	public String getStudyUid()
	{
		return studyUid;
	}

	/**
	 * Set the value of studyUid
	 *
	 * @param studyUid new value of studyUid
	 */
	public void setStudyUid(String studyUid)
	{
		this.studyUid = studyUid;
	}

	private String studyId;

	/**
	 * Get the value of studyId
	 *
	 * @return the value of studyId
	 */
	public String getStudyId()
	{
		return studyId;
	}

	/**
	 * Set the value of studyId
	 *
	 * @param studyId new value of studyId
	 */
	public void setStudyId(String studyId)
	{
		this.studyId = studyId;
	}

	private String referringPhysician;

	/**
	 * Get the value of referringPhysician
	 *
	 * @return the value of referringPhysician
	 */
	public String getReferringPhysician()
	{
		return referringPhysician;
	}

	/**
	 * Set the value of referringPhysician
	 *
	 * @param referringPhysician new value of referringPhysician
	 */
	public void setReferringPhysician(String referringPhysician)
	{
		this.referringPhysician = referringPhysician;
	}

	private Exam exam;

	/**
	 * Get the value of exam
	 *
	 * @return the value of exam
	 */
	public Exam getExam()
	{
		return exam;
	}

	/**
	 * Set the value of exam
	 *
	 * @param exam new value of exam
	 */
	public void setExam(Exam exam)
	{
		this.exam = exam;
	}

	private DicomKos kos;

	/**
	 * Get the value of kos
	 *
	 * @return the value of kos
	 */
	public DicomKos getKos()
	{
		return kos;
	}

	/**
	 * Set the value of kos
	 *
	 * @param kos new value of kos
	 */
	public void setKos(DicomKos kos)
	{
		this.kos = kos;
	}

	private Map<String, DicomSeries> series = new LinkedHashMap();

	public Map<String, DicomSeries> getSeries()
	{
		return series;
	}

}
