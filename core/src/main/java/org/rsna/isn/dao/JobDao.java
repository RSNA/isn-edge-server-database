/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.rsna.isn.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashSet;
import java.util.Set;
import org.apache.commons.lang.exception.ExceptionUtils;
import org.rsna.isn.domain.Exam;
import org.rsna.isn.domain.Job;

/**
 *
 * @author wtellis
 */
public class JobDao extends Dao
{
	public Set<Job> getJobsByStatus(int status) throws SQLException
	{
		Connection con = getConnection();
		try
		{
			Set<Job> jobs = new LinkedHashSet<Job>();

			String select = "SELECT * FROM v_job_status WHERE status =  " + status
					+ " ORDER BY last_transaction_timestamp";

			ResultSet rs = con.createStatement().executeQuery(select);
			while (rs.next())
			{
				Job job = buildEntity(rs);

				jobs.add(job);
			}

			return jobs;
		}
		finally
		{
			con.close();
		}

	}

	public Job getJobById(int id) throws SQLException
	{
		Connection con = getConnection();
		try
		{
			Job job = null;

			String select = "SELECT * FROM v_job_status WHERE job_id =  " + id;

			ResultSet rs = con.createStatement().executeQuery(select);
			if (rs.next())
				job = buildEntity(rs);
			rs.close();

			return job;
		}
		finally
		{
			con.close();
		}
	}

	public void updateStatus(Job job, int status, Throwable ex) throws SQLException
	{
		String msg = ExceptionUtils.getStackTrace(ex);

		updateStatus(job, status, msg);
	}

	public void updateStatus(Job job, int status) throws SQLException
	{
		updateStatus(job, status, "");
	}

	public void updateStatus(Job job, int status, String message) throws SQLException
	{
		Connection con = getConnection();

		try
		{
			String insert = "INSERT INTO transactions"
					+ "(job_id, status_code, comments) VALUES (?, ?, ?)";

			PreparedStatement stmt = con.prepareStatement(insert);
			stmt.setInt(1, job.getJobId());
			stmt.setInt(2, status);
			stmt.setString(3, message);

			stmt.execute();
		}
		finally
		{
			con.close();
		}
	}

	private Job buildEntity(ResultSet rs) throws SQLException
	{
		Job job = new Job();

		job.setJobId(rs.getInt("job_id"));
		job.setStatus(rs.getInt("status"));
		job.setStatusMessage(rs.getString("status_message"));
		job.setDelay(rs.getInt("delay_in_hrs"));

		int examId = rs.getInt("exam_id");

		Exam exam = new ExamDao().getExam(examId);
		job.setExam(exam);

		return job;
	}

}
