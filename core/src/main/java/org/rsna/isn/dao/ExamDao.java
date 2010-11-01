/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.rsna.isn.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.apache.commons.lang.StringUtils;
import org.rsna.isn.domain.Author;
import org.rsna.isn.domain.Exam;
import org.rsna.isn.domain.RsnaDemographics;

/**
 *
 * @author wtellis
 */
public class ExamDao extends Dao
{
	public Exam getExam(int examId) throws SQLException
	{
		Connection con = getConnection();
		try
		{
			String examSelect = "SELECT * from v_exam_status WHERE exam_id = " + examId;

			ResultSet rs = con.createStatement().executeQuery(examSelect);
			if (rs.next())
			{
				Exam exam = new Exam();

				exam.setMrn(rs.getString("mrn"));
				exam.setAccNum(rs.getString("accession_number"));
				exam.setStatus(rs.getString("status"));
				exam.setStatusTimestamp(rs.getTimestamp("status_timestamp"));
				exam.setReport(rs.getString("report_text"));
				
				String signer = rs.getString("signer");
				if (StringUtils.isNotBlank(signer))
					exam.setSigner(new Author(signer));


				

				int patId = rs.getInt("patient_id");
				String rsnaSelect = "SELECT * FROM patient_rsna_ids WHERE patient_id = " + patId;
				ResultSet rs2 = con.createStatement().executeQuery(rsnaSelect);
				if (rs2.next())
				{
					RsnaDemographics rsna = new RsnaDemographics();
					rsna.setId(rs2.getString("rsna_id"));
					rsna.setLastName(rs2.getString("patient_alias_lastname"));
					rsna.setFirstName(rs2.getString("patient_alias_firstname"));

					exam.setRsnaDemographics(rsna);
				}

				return exam;
			}

			return null;
		}
		finally
		{
			con.close();
		}
	}

}
