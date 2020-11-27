package product;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class ProductDAO {
	
	private Connection conn;
	
	public ProductDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS?serverTimezone=Asia/Seoul";
			String dbID = "root";			
			String dbPassword = "1234";
			Class.forName("com.mysql.jdbc.Driver"); //
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);	
		} catch (Exception e) {
			e.printStackTrace(); //
		}
	}
	public int upload(int p_num, String p_name, int p_value, String p_image, int p_amount, String p_categoly) {
		String SQL = "INSERT INTO PRODUCT VALUES (?, ?, ?, ? ,? ,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, p_num);
			pstmt.setString(2, p_name);
			pstmt.setInt(3, p_value);
			pstmt.setString(4, p_image);
			pstmt.setInt(5, p_amount);
			pstmt.setString(6, p_categoly);
			return pstmt.executeUpdate(); 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
		
}
