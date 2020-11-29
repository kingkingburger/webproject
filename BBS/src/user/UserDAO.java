package user;

import java.sql.Connection; //데이터베이스 접근객체
import java.sql.DriverManager;
import java.sql.PreparedStatement; 
import java.sql.ResultSet; ////정보 담는 객체

public class UserDAO {

 private Connection conn;
 private PreparedStatement pstmt;
 private ResultSet rs;

 public UserDAO() {
  try {
   String dbURL = "jdbc:mysql://localhost:3306/BBS?serverTimezone=Asia/Seoul";

   Class.forName("com.mysql.jdbc.Driver");
   conn = DriverManager.getConnection(dbURL, "root", "kang0320"); //데이터베이스 서버 접근

  } catch (Exception e) {
   e.printStackTrace();
  }
 }

 public int login(String userID, String userPassword) {
  String SQL = "SELECT userPassword FROM USER WHERE userID=?"; //?는 id가 들어가는 곳
  try {
   pstmt = conn.prepareStatement(SQL); //SQL문을 가진채 데이터베이스에 접속하여 객체 반환
   pstmt.setString(1, userID); // pstmt 객체에 ? 부분을 채워 넣는다.
   rs = pstmt.executeQuery(); //아이디가 존재할시 리턴 값 존재
   if(rs.next()) {
    if(rs.getString(1).equals(userPassword)) //비밀번호 검사
     return 1;  // 로그인 성공
    else
     return 0;  // 비밀번호 불일치
   }
   return -1;  // 아이디가 없음
  } catch(Exception e) {
   e.printStackTrace();
  }
  return -2; // 데이터 베이스 오류
 }
 public int join(User user) {
		String SQL = "INSERT INTO USER VALUES (?,?,?,?,?)"; //값 삽입
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserType());
			pstmt.setString(5, user.getUserAddress());
			return pstmt.executeUpdate(); //업데이트 결과 반환
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB 오류
	}
}