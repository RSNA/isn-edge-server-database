/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.rsna.isn.dao;

import com.mchange.v2.c3p0.ComboPooledDataSource;
import java.io.File;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import javax.sql.DataSource;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

/**
 *
 * @author wtellis
 */
public abstract class Dao
{
	private static final Logger logger = Logger.getLogger(Dao.class);

	private static final String url;

	private static final String user;

	private static final String pw;

	private static final ComboPooledDataSource ds;

	static
	{
		String path = System.getProperty("database.properties");
		if (StringUtils.isBlank(path))
			throw new ExceptionInInitializerError("database.properties system property is not defined");

		File file = new File(path);
		try
		{
			FileInputStream input = new FileInputStream(file);

			Properties props = new Properties();
			props.load(input);

			url = props.getProperty("rsnadb.url");
			if (StringUtils.isBlank(url))
				throw new ExceptionInInitializerError("rsnadb.url is not defined");

			user = props.getProperty("rsnadb.user");
			if (StringUtils.isBlank(user))
				throw new ExceptionInInitializerError("rsnadb.user is not defined");

			pw = props.getProperty("rsnadb.password");
			if (StringUtils.isBlank(pw))
				throw new ExceptionInInitializerError("rsnadb.pw is not defined");

			logger.info("Loaded database properties from " + file.getPath());

			ds = new ComboPooledDataSource();
			ds.setDriverClass("org.postgresql.Driver"); //loads the jdbc driver
			ds.setJdbcUrl(url);
			ds.setUser(user);
			ds.setPassword(pw);
			ds.setPreferredTestQuery("SELECT 1");
			ds.setTestConnectionOnCheckout(true);
		}
		catch (Exception ex)
		{
			throw new ExceptionInInitializerError(ex);
		}

	}

	protected Connection getConnection() throws SQLException
	{
		return ds.getConnection();
	}

}
