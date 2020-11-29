package user;

import java.sql.Connection; //�����ͺ��̽� ���ٰ�ü
import java.sql.DriverManager;
import java.sql.PreparedStatement; 
import java.sql.ResultSet; ////���� ��� ��ü

public class UserDAO {

 private Connection conn;
 private PreparedStatement pstmt;
 private ResultSet rs;

 public UserDAO() {
  try {
   String dbURL = "jdbc:mysql://localhost:3306/BBS?serverTimezone=Asia/Seoul";

   Class.forName("com.mysql.jdbc.Driver");
   conn = DriverManager.getConnection(dbURL, "root", "kang0320"); //�����ͺ��̽� ���� ����

  } catch (Exception e) {
   e.printStackTrace();
  }
 }

 public int login(String userID, String userPassword) {
  String SQL = "SELECT userPassword FROM USER WHERE userID=?"; //?�� id�� ���� ��
  try {
   pstmt = conn.prepareStatement(SQL); //SQL���� ����ä �����ͺ��̽��� �����Ͽ� ��ü ��ȯ
   pstmt.setString(1, userID); // pstmt ��ü�� ? �κ��� ä�� �ִ´�.
   rs = pstmt.executeQuery(); //���̵� �����ҽ� ���� �� ����
   if(rs.next()) {
    if(rs.getString(1).equals(userPassword)) //��й�ȣ �˻�
     return 1;  // �α��� ����
    else
     return 0;  // ��й�ȣ ����ġ
   }
   return -1;  // ���̵� ����
  } catch(Exception e) {
   e.printStackTrace();
  }
  return -2; // ������ ���̽� ����
 }
 public int join(User user) {
		String SQL = "INSERT INTO USER VALUES (?,?,?,?,?)"; //�� ����
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserType());
			pstmt.setString(5, user.getUserAddress());
			return pstmt.executeUpdate(); //������Ʈ ��� ��ȯ
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // DB ����
	}
}