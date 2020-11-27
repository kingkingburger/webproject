package market;

import java.sql.Connection; //데이터베이스 접근객체
import java.sql.DriverManager;
import java.sql.PreparedStatement; 
import java.sql.ResultSet; ////정보 담는 객체

public class MarketDAO {
	
	 private Connection conn;
	 private PreparedStatement pstmt;
	 //private ResultSet rs;

public MarketDAO() {
	  try {
	   String dbURL = "jdbc:mysql://localhost:3306/BBS?serverTimezone=Asia/Seoul";

	   Class.forName("com.mysql.jdbc.Driver");
	   conn = DriverManager.getConnection(dbURL, "root", "1234"); //데이터베이스 서버 접근

	  } catch (Exception e) {
	   e.printStackTrace();
	  }
	 } 


}