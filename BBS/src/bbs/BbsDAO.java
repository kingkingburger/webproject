package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {

	private Connection conn;
	private ResultSet rs;
	
	//�⺻ ������
	public BbsDAO() {
		try {
			 String dbURL = "jdbc:mysql://localhost:3306/BBS?serverTimezone=Asia/Seoul";

			   Class.forName("com.mysql.jdbc.Driver");
			   conn = DriverManager.getConnection(dbURL, "root", "1234");
		}catch (Exception e) {
			e.printStackTrace();
		}
	}

	 public String getDate() // ����ð��� �־��ֱ�����
	    {
	        String SQL = "SELECT NOW()"; // ����ð��� ��Ÿ���� mysql
	        try {
	            PreparedStatement pstmt = conn.prepareStatement(SQL);
	            rs = pstmt.executeQuery();
	            if(rs.next()) {
	                return rs.getString(1);
	            }
	            
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return ""; // �����ͺ��̽� ����
	    }
	
	 public int getNext()
	    {
	        String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC"; // ������������ ���� �������� ���� ���� �����´�
	        try {
	            PreparedStatement pstmt = conn.prepareStatement(SQL);
	            rs = pstmt.executeQuery();
	            if(rs.next()) {
	                return rs.getInt(1) + 1; // �� ���� �Խñ��� ��ȣ
	            }
	            return 1; // ù ��° �Խù��� ���
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return -1; // �����ͺ��̽� ����
	    }
	
	//�۾��� �޼ҵ�
	 public int write(String bbsTitle, String userID, String bbsContent,String bbscategory) {
	        String SQL = "INSERT INTO BBS VALUES (?,?,?,?,?,?,?)";
	        try {
	            PreparedStatement pstmt = conn.prepareStatement(SQL);
	            pstmt.setInt(1, getNext());
	            pstmt.setString(2, bbsTitle);
	            pstmt.setString(3, userID);
	            pstmt.setString(4, getDate());
	            pstmt.setString(5, bbsContent);
	            pstmt.setInt(6, 1);
	            pstmt.setString(7, bbscategory);
	            return pstmt.executeUpdate();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return -1; // �����ͺ��̽� ����
	    }
	 
	 public ArrayList<Bbs> getList(int pageNumber)
	    {
	        String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10"; // ������������ ���� �������� ���� ���� �����´�
	        ArrayList<Bbs> list = new ArrayList<Bbs>();
	        try {
	            PreparedStatement pstmt = conn.prepareStatement(SQL);
	            pstmt.setInt(1, getNext() - (pageNumber - 1 ) * 10);
	            rs = pstmt.executeQuery();
	            while (rs.next()) {
	                Bbs bbs = new Bbs();
	                bbs.setBbsID(rs.getInt(1));
	                bbs.setBbsTitle(rs.getString(2));
	                bbs.setUserID(rs.getString(3));
	                bbs.setBbsDate(rs.getString(4));
	                bbs.setBbsContent(rs.getString(5));
	                bbs.setBbsAvailable(rs.getInt(6));
	                bbs.setBbscategory(rs.getString(7));
	                list.add(bbs);
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return list; 
	    }
	
	 public boolean nextPage(int pageNumber) {
	        String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1"; 
	        try {
	            PreparedStatement pstmt = conn.prepareStatement(SQL);
	            pstmt.setInt(1, getNext() - (pageNumber - 1 ) * 10);
	            rs = pstmt.executeQuery();
	            if (rs.next())
	            {
	                return true;
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return false; 
	    }
	
	public Bbs getBbs(int bbsID) {
		String sql = "select * from bbs where bbsID = ?";

		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				bbs.setBbscategory(rs.getString(7));
				return bbs;
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(int bbsID, String bbsTitle, String bbsContent,String bbscategory) {
		String sql = "update bbs set bbsTitle=? ,bbsContent=?, bbscategory = ? where bbsID =?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,bbsTitle);
			pstmt.setString(2,bbsContent);
			pstmt.setString(3,bbscategory);
			pstmt.setInt(4,bbsID);
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //�����ͺ��̽� ����
	}
	
	public int delete(int bbsID) {
		String sql = "update bbs set bbsAvailable = 0 where  bbsID =?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,bbsID);
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //�����ͺ��̽� ����
	}
    
}