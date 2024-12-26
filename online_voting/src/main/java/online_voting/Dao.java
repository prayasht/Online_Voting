package online_voting;

import java.sql.Connection;
import java.sql.DriverManager;

public class Dao{
	private String dburl="jdbc:mysql://localhost:3306/votingdb";
	private String dbuser="root";
	private String pass="Prayash@443";
	
	public void loadDriver() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	
	public Connection getConnection() {
		Connection  con=null;
		
		try {
		con=DriverManager.getConnection(dburl,dbuser,pass);
		}
		catch(Exception e) {
		e.printStackTrace();	
			
		}
		return con;
	}
}