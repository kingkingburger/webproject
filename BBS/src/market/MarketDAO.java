package market;

import java.sql.Connection; //�����ͺ��̽� ���ٰ�ü
import java.sql.DriverManager;
import java.sql.PreparedStatement; 
import java.sql.ResultSet; ////���� ��� ��ü

public class MarketDAO {
	
	 private Connection conn;
	 private PreparedStatement pstmt;
	 //private ResultSet rs;

public MarketDAO() {
	  try {
	   String dbURL = "jdbc:mysql://localhost:3306/BBS?serverTimezone=Asia/Seoul";

	   Class.forName("com.mysql.jdbc.Driver");
	   conn = DriverManager.getConnection(dbURL, "root", "1234"); //�����ͺ��̽� ���� ����

	  } catch (Exception e) {
	   e.printStackTrace();
	  }
	 } 


}