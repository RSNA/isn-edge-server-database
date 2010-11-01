/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package org.rsna.isn.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashSet;
import java.util.Set;
import org.rsna.isn.domain.Device;

/**
 *
 * @author wtellis
 */
public class DeviceDao extends Dao
{

	public Set<Device> getDevices() throws SQLException
	{
		Set<Device> devices = new LinkedHashSet<Device>();

		Connection con = getConnection();
		try
		{
			ResultSet rs = con.createStatement().
					executeQuery("SELECT * FROM devices ORDER BY ae_title");
			while(rs.next())
			{
				Device device = new Device();

				device.setHost(rs.getString("host"));
				device.setPort(rs.getInt("port_number"));
				device.setAeTitle(rs.getString("ae_title"));

				devices.add(device);
			}

		}
		finally
		{
			con.close();
		}

		return devices;
	}
}
