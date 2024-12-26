package online_voting;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class RegisterCanDao{
	Dao dao=new Dao();
	
	
	public String insertCan(int candidateId,int electionId, String candidateName) {
	    String res = "Data entered successfully.";
	    Connection con = null;
	    PreparedStatement ps = null;
	    
	    try {
	        dao.loadDriver();  
	        con = dao.getConnection();  

	        String sql = "INSERT INTO candidates (ID,NAME, ELECTION_ID, count) VALUES (?, ?, ?,?)";
	        
	        ps = con.prepareStatement(sql);
	        ps.setInt(1, candidateId);
	        ps.setString(2, candidateName);
	        ps.setInt(3, electionId);
	        ps.setInt(4, 0);  // Initializing the count as 0

	        int rowsAffected = ps.executeUpdate();  // Execute the insert operation

	        if (rowsAffected > 0) {
	            res = "Candidate inserted successfully.";
	        } else {
	            res = "No rows affected. Candidate not inserted.";
	        }
	    } catch (Exception e) {
	        e.printStackTrace();  // Log the exception for debugging
	        res = "Data not entered. Error: " + e.getMessage();  // Return specific error message
	    } finally {
	        try {
	            // Close resources in the finally block to ensure they are always closed
	            if (ps != null) ps.close();
	            if (con != null) con.close();
	        } catch (SQLException ex) {
	            ex.printStackTrace();  // Log any exceptions while closing resources
	        }
	    }

	    return res;
	}

	
	public  int getElectionId(String electionName) {
		int electionId=0;
		dao.loadDriver();
		Connection con=dao.getConnection();

		try {
			
			String que="select id from elections where title = ?";
			PreparedStatement ps=con.prepareStatement(que);
			ps.setString(1, electionName);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				electionId=rs.getInt("ID");
			}
			
		}catch(Exception e) {
			e.printStackTrace();
			
		}
		return electionId;
	}
	
	
	public List<String> getELectionName(int uid){

		List<String> electionList = new ArrayList<>();
        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
		dao.loadDriver();
		try {
		 con=dao.getConnection();
         String query = "SELECT title FROM elections where userId= ?";
         stmt = con.prepareStatement(query);
         stmt.setInt(1,uid);
         rs = stmt.executeQuery();

        while (rs.next()) {
            String name = rs.getString("title");
            electionList.add(name);
        }
    } catch (Exception e) {
        e.printStackTrace();
        electionList.add("errror "+e);
    } 
	finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
        if (con != null) try { con.close(); } catch (SQLException ignore) {}
		}

	return electionList;
	}
	
	public List<String> getElectionName(String elePart) { 
	    List<String> electionList = new ArrayList<>();
	    Connection con = null;
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    dao.loadDriver();

	    try {
	        con = dao.getConnection();
	        
	        String query = "SELECT title FROM elections WHERE title LIKE ?";
	        stmt = con.prepareStatement(query);
	        stmt.setString(1, elePart + "%"); // Match titles starting with elePart
	        rs = stmt.executeQuery();

	        while (rs.next()) {
	            String name = rs.getString("title");
	            electionList.add(name);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        electionList.add("error " + e);
	    } finally {
	        // Close resources safely
	        try { if (rs != null) rs.close(); } catch (SQLException ignore) {}
	        try { if (stmt != null) stmt.close(); } catch (SQLException ignore) {}
	        try { if (con != null) con.close(); } catch (SQLException ignore) {}
	    }

	    return electionList;
	}

	
	public List<String> getELectionName(){

		List<String> electionList = new ArrayList<>();
        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
		dao.loadDriver();
		try {
		 con=dao.getConnection();
         String query = "SELECT title FROM elections";
         stmt = con.prepareStatement(query);

         rs = stmt.executeQuery();

        while (rs.next()) {
            String name = rs.getString("title");
            electionList.add(name);
        }
    } catch (Exception e) {
        e.printStackTrace();
        electionList.add("errror "+e);
    } 
	finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
        if (con != null) try { con.close(); } catch (SQLException ignore) {}
		}

	return electionList;
	}
	
	
	
	public List<Candidate> getCandidateName(int id) {
	    List<Candidate> candidateList = new ArrayList<>();
	    Connection con = null;
	    PreparedStatement ps = null;
	    ResultSet rs = null;

	    dao.loadDriver();
	    try {
	        con = dao.getConnection();
	        String query = "SELECT id, name FROM candidates WHERE ELECTION_ID = ?";
	        ps = con.prepareStatement(query);
	        ps.setInt(1, id);
	        rs = ps.executeQuery();
	        while (rs.next()) {
	            int canId = rs.getInt("id");
	            String name = rs.getString("name");
	            candidateList.add(new Candidate(name, canId));
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
	        if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
	        if (con != null) try { con.close(); } catch (SQLException ignore) {}
	    }

	    return candidateList;
	}

	
	

	public boolean deleteCandidate(int id) {
	   Connection conn = null;
	   PreparedStatement stmt = null;
	   boolean isDeleted = false;

	        try {
	            conn = dao.getConnection();
	            String sql = "DELETE FROM candidates WHERE id = ?";
	            stmt = conn.prepareStatement(sql);
	            stmt.setInt(1, id);
	            int rowsAffected = stmt.executeUpdate();
	            isDeleted = rowsAffected > 0;
	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	            if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
	            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
	        }

	        return isDeleted;
	    }
	
	public List<Map<String, Object>> getEleGraphData(int electionId) {
		 Connection conn = null;
		 PreparedStatement ps = null;
		 ResultSet rs=null;
		List<Map<String, Object>> graphData = new ArrayList<>();
		dao.loadDriver();
		String sql ="Select NAME,count from candidates where ELECTION_ID=?";
		try {
			conn=dao.getConnection();
			ps = conn.prepareStatement(sql);
	        ps.setInt(1, electionId);
	        rs = ps.executeQuery();
	        while (rs.next()) {
	        	Map<String, Object> dataPoint = new HashMap<>();
	        	 dataPoint.put("x", rs.getString("NAME"));
	             dataPoint.put("y", rs.getInt("count"));
	             graphData.add(dataPoint);
	        	
	        }
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return graphData;
	}
	
	public String vote(int userId, int cndId, int eleId) {
	    String res = "Voting could not be completed successfully.";
	    Connection conn = null;
	    PreparedStatement ps = null;

	    dao.loadDriver();
	    String insertVoteSQL = "INSERT INTO votes (VOTER_ID, CANDIDATE_ID, ELECTION_ID) VALUES (?, ?, ?)";
	    String updateCandidateSQL = "UPDATE candidates SET count = (SELECT COUNT(*) FROM votes WHERE CANDIDATE_ID = ? AND ELECTION_ID = ?) WHERE ID = ?";

	    try {
	        // Establish a connection
	        conn = dao.getConnection();

	        // Step 1: Insert vote record
	        ps = conn.prepareStatement(insertVoteSQL);
	        ps.setInt(1, userId);
	        ps.setInt(2, cndId);
	        ps.setInt(3, eleId);

	        int rowsAffected = ps.executeUpdate(); // Execute the insert operation

	        if (rowsAffected > 0) {
	            ps.close(); 
	            ps = conn.prepareStatement(updateCandidateSQL);
	            ps.setInt(1, cndId);
	            ps.setInt(2, eleId);
	            ps.setInt(3, cndId);

	            int updateRows = ps.executeUpdate(); // Execute the update operation

	            if (updateRows > 0) {
	                res = "Voting completed successfully.";
	            } else {
	                res = "Vote was recorded, but the candidate's vote count could not be updated.";
	            }
	        } else {
	            res = "Vote could not be recorded. Please try again.";
	        }

	    } catch (Exception e) {
	        e.printStackTrace(); // Log exception for debugging
	        res = "An error occurred: " + e.getMessage();
	    } finally {
	        // Close resources
	        try {
	            if (ps != null) ps.close();
	            if (conn != null) conn.close();
	        } catch (SQLException ex) {
	            ex.printStackTrace(); // Log any exceptions while closing resources
	        }
	    }

	    return res;
	}

	public boolean validVote(int userId,int eleId) {
		boolean isValidVote=false;
		 Connection conn = null;
		    PreparedStatement stmt = null;
		    ResultSet rs = null;
		    try {
		        // Get the connection
		    	dao.loadDriver();
		        conn = dao.getConnection();

		        String sql = "SELECT COUNT(*) FROM votes WHERE VOTER_ID = ? AND ELECTION_ID= ?";
		        stmt = conn.prepareStatement(sql);
		        stmt.setInt(1, userId);
		        stmt.setInt(2, eleId);
		        // Execute the query
		        rs = stmt.executeQuery();


		        if (rs.next() && rs.getInt(1) > 0) {
		        	 isValidVote=true;
		            
		        }

		    } catch (Exception e) {
		        e.printStackTrace();

		    } finally {
		        // Close resources
		        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
		        if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
		        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
		    }

		    
		return isValidVote;
	}
	
	public List<String> getWinners(String  eleName) {
		List<String> winners=new ArrayList<> ();
		 Connection conn = null;
		    PreparedStatement stmt = null;
		    ResultSet rs = null;

		    try {
		        dao.loadDriver();
		        conn = dao.getConnection();

		        String sql = " select name from candidates where count=(select MAX(count) from candidates) AND ELECTION_ID=(select ID from elections where TITLE = ?)";
		        stmt = conn.prepareStatement(sql);
		        stmt.setString(1, eleName);
		        rs = stmt.executeQuery();

		        while (rs.next()) {
		        	winners.add(rs.getString(1));
		         }
		    } catch (Exception e) {
		        e.printStackTrace();
		    } finally {
		        try { if (rs != null) rs.close(); } catch (SQLException ignore) {}
		        try { if (stmt != null) stmt.close(); } catch (SQLException ignore) {}
		        try { if (conn != null) conn.close(); } catch (SQLException ignore) {}
		    }
		return winners;
	}
public Map<String, String> getTime(String eleName) {
	    Map<String, String> time = new HashMap<>();
	    Connection conn = null;
	    PreparedStatement stmt = null;
	    ResultSet rs = null;

	    try {
	        dao.loadDriver();
	        conn = dao.getConnection();

	        String sql = "SELECT START_DATE, END_DATE FROM elections WHERE TITLE = ?";
	        stmt = conn.prepareStatement(sql);
	        stmt.setString(1, eleName);
	        rs = stmt.executeQuery();

	        if (rs.next()) {
	            String sDate = rs.getString("START_DATE");
	            String eDate = rs.getString("END_DATE");
	            
	           time.put("start date", sDate);
	           time.put("end date", eDate);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try { if (rs != null) rs.close(); } catch (SQLException ignore) {}
	        try { if (stmt != null) stmt.close(); } catch (SQLException ignore) {}
	        try { if (conn != null) conn.close(); } catch (SQLException ignore) {}
	    }
	    return time;
	}


}
