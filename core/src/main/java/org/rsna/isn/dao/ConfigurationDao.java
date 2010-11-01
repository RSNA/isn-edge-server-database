/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package org.rsna.isn.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author wtellis
 */
public class ConfigurationDao extends Dao
{
	public String getConfiguration(String key) throws SQLException
	{
		Connection con = getConnection();

		PreparedStatement stmt = con.prepareStatement("SELECT * FROM configurations WHERE \"key\" = ?");
		stmt.setString(1, key);

		String config = null;
		ResultSet rs = stmt.executeQuery();
		if(rs.next())		
			config = rs.getString("value");


		rs.close();
		con.close();

		return config;
	}
}
