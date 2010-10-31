/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.rsna.isn.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author wtellis
 */
public abstract class Dao
{
	protected Connection getConnection() throws ClassNotFoundException, SQLException
	{
		//
		// Need to switch to using a connection pool
		//
		Class.forName("org.postgresql.Driver");

		return DriverManager.getConnection("jdbc:postgresql://localhost:5432/rsnadb",
				"edge", "edge01");
	}

}
