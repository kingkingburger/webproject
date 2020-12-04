package market;

import java.sql.Connection; //�����ͺ��̽� ���ٰ�ü
import java.sql.DriverManager;
import java.sql.PreparedStatement; 
import java.sql.ResultSet; ////���� ��� ��ü
import java.util.ArrayList;

import bbs.Bbs;
import user.User;

public class MarketDAO {
	
	 private Connection conn;
	 private PreparedStatement pstmt;
	 private ResultSet rs;

public MarketDAO() {
	  try {
	   String dbURL = "jdbc:mysql://localhost:3306/BBS?serverTimezone=Asia/Seoul";

	   Class.forName("com.mysql.jdbc.Driver");
	   conn = DriverManager.getConnection(dbURL, "root", "1234"); //�����ͺ��̽� ���� ����

	  } catch (Exception e) {
	   e.printStackTrace();
	  }
	 } 

public int join(Market market, String userID) {
	String SQL = "INSERT INTO Market VALUES (?,?,?,?,?,?,?,?,?)"; //�� ����
	try {
		pstmt = conn.prepareStatement(SQL);
		pstmt.setInt(1, 0);
		pstmt.setString(2, market.getMarket_name());
		pstmt.setString(3, market.getMarket_address1());
		pstmt.setString(4, market.getMarket_address2());
		pstmt.setString(5, market.getMarket_address3());
		pstmt.setString(6, market.getMarket_detailed_address());
		pstmt.setString(7, userID);
		pstmt.setString(8, market.getMarket_categoly());
		pstmt.setInt(9, 1);

		return pstmt.executeUpdate(); //������Ʈ ��� ��ȯ
	} catch (Exception e) {
		e.printStackTrace();
	}
	return -1; // DB ����
	}
public int getNext()
{
    String SQL =  "SELECT market_num FROM market ORDER BY market_num DESC"; // ������������ ���� �������� ���� ���� �����´�
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

public ArrayList<Market> getList(int last_num, String userID, int Division)
   {
	String SQL =null;
	if(Division == 1) {
		SQL = "SELECT * FROM Market WHERE market_num < ? AND market_available = 1 AND market_userid = ?  ORDER BY market_num DESC LIMIT 10"; // ������������ ���� �������� ���� ���� �����´�
       }
       else {
   		SQL = "SELECT * FROM Market WHERE market_num > ? AND market_available = 1 AND market_userid = ?  ORDER BY market_num LIMIT 10"; // ������������ ���� �������� ���� ���� �����´�

       }
       ArrayList<Market> list = new ArrayList<Market>();
       try {
    	  
           PreparedStatement pstmt = conn.prepareStatement(SQL);
           pstmt.setInt(1, last_num);
           pstmt.setString(2, userID);
           rs = pstmt.executeQuery();
           while (rs.next()) {
        	   Market market = new Market();
        	   market.setMarket_num(rs.getInt(1));
        	   market.setMarket_name(rs.getString(2));
        	   market.setMarket_address1(rs.getString(3));
        	   market.setMarket_address2(rs.getString(4));
        	   market.setMarket_address3(rs.getString(5));
        	   market.setMarket_detailed_address(rs.getString(6));
        	   market.setMarket_userid(rs.getString(7));
        	   market.setMarket_categoly(rs.getString(8));
        	   market.setMarket_available(rs.getInt(9));

               list.add(market);
           }
       } catch (Exception e) {
           e.printStackTrace();
       }
       return list; 
   }
public boolean nextPage(int last_num, String userID) {
    String SQL = "SELECT * FROM Market WHERE market_num < ? AND market_available = 1 AND market_userid = ?  ORDER BY market_num DESC LIMIT 10"; // ������������ ���� �������� ���� ���� �����´�
    try {
        PreparedStatement pstmt = conn.prepareStatement(SQL);
        pstmt.setInt(1, last_num);
        pstmt.setString(2, userID);
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

public boolean Search_nextPage(int last_num, String market_address_1, String market_address_2, String market_address_3, int Division) {
    String SQL = "SELECT * FROM market WHERE market_num < ? AND market_Available = 1 AND market_address_1 = ? AND market_address_2= ? AND market_address_3=? ORDER BY market_num DESC LIMIT 10"; // ������������ ���� �������� ���� ���� �����´�
    try {
        PreparedStatement pstmt = conn.prepareStatement(SQL);
        pstmt.setInt(1, last_num);
        pstmt.setString(2, market_address_1);
        pstmt.setString(3, market_address_2);
        pstmt.setString(4, market_address_3);
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
public ArrayList<Market> Search_getList(int last_num,String market_address_1, String market_address_2, String market_address_3, int Division)
{
	String SQL =null;
	if(Division == 1) {
		SQL = "SELECT * FROM market WHERE market_num < ? AND market_Available = 1 AND market_address_1 = ? AND market_address_2= ? AND market_address_3=? ORDER BY market_num DESC LIMIT 10"; // ������������ ���� �������� ���� ���� �����´�
    }
    else {
		SQL = "SELECT * FROM market WHERE market_num > ? AND market_Available = 1 AND market_address_1 = ? AND market_address_2= ? AND market_address_3=? ORDER BY market_num LIMIT 10"; // ������������ ���� �������� ���� ���� �����´�

    }
    ArrayList<Market> list = new ArrayList<Market>();
    try {
 	  
        PreparedStatement pstmt = conn.prepareStatement(SQL);
        pstmt.setInt(1, last_num);
        pstmt.setString(2, market_address_1);
        pstmt.setString(3, market_address_2);
        pstmt.setString(4, market_address_3);
        rs = pstmt.executeQuery();
        while (rs.next()) {
     	   Market market = new Market();
     	   market.setMarket_num(rs.getInt(1));
     	   market.setMarket_name(rs.getString(2));
     	   market.setMarket_address1(rs.getString(3));
     	   market.setMarket_address2(rs.getString(4));
     	   market.setMarket_address3(rs.getString(5));
     	   market.setMarket_detailed_address(rs.getString(6));
     	   market.setMarket_userid(rs.getString(7));
     	   market.setMarket_categoly(rs.getString(8));
     	   market.setMarket_available(rs.getInt(9));

            list.add(market);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return list; 
	}
}