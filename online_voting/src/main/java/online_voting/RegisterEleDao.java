package online_voting;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class RegisterEleDao {
	Dao dao=new Dao();
	public String insertEle(Election e) {
		dao.loadDriver();
		String  res="data enterd suessfully.";
		Connection con=dao.getConnection();
		String sql = "INSERT INTO elections (title, start_date, end_date,userId) VALUES (?, ?, ?, ?)";
		try {
			PreparedStatement ps=con.prepareStatement(sql);
			ps.setString(1, e.getTitle());
			ps.setString(2, e.getStDate());
			ps.setString(3, e.getEndDate());
			ps.setInt(4, e.getUid());
			ps.executeUpdate();
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
			res="data not entered";
		}
		return res;	
	}
	public String castVote() {
		String res="";
		dao.loadDriver();
		Connection con=dao.getConnection();
		String sql;
		return res;
	}

}
