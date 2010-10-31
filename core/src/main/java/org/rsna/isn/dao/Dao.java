/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.rsna.isn.dao;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
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
	    if(StringUtils.isBlank(url))
		throw new ExceptionInInitializerError("rsnadb.url is not defined");

	    user = props.getProperty("rsnadb.user");
	    if(StringUtils.isBlank(user))
		throw new ExceptionInInitializerError("rsnadb.user is not defined");

	    pw = props.getProperty("rsnadb.password");
	    if(StringUtils.isBlank(pw))
		throw new ExceptionInInitializerError("rsnadb.pw is not defined");

	    logger.info("Loaded database properties from " + file.getPath());
	}
	catch (IOException ex)
	{
	    throw new ExceptionInInitializerError(ex);
	}

    }

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
