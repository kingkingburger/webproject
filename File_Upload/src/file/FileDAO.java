package file;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class FileDAO {
	
	private Connection conn;
	
	public FileDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/FILE?serverTimezone=Asia/Seoul";
			String dbID = "root";
			
			
			String dbPassword = "kang0320";
			Class.forName("com.mysql.jdbc.Driver"); //db연동 라이브러리 찾기
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);	
		} catch (Exception e) {
			e.printStackTrace(); //오류처리
		}
	}
	public int upload(String fileName, String fileRealName) {
		String SQL = "INSERT INTO FILE VALUES (?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, fileName);
			pstmt.setString(2, fileRealName);
			return pstmt.executeUpdate(); //실제로 업데이트 정상종료시 1반환
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
		
}
	
