package product;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import market.Market;

public class ProductDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	public ProductDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS?serverTimezone=Asia/Seoul";
			String dbID = "root";			
			String dbPassword = "1234";
			Class.forName("com.mysql.jdbc.Driver"); //
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);	
		} catch (Exception e) 
	{
			e.printStackTrace(); //
		}
	}
	public int upload(String  product_name, int product_value, String product_image, int product_amount, String product_categoly, int market_num) {
		String SQL = "INSERT INTO PRODUCT VALUES (?,?, ?, ?, ?, ?,?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  0);
			pstmt.setString(2,  product_name);
			pstmt.setInt(3,  product_value);
			pstmt.setString(4, product_image);
			pstmt.setInt(5, product_amount);
			pstmt.setString(6,  product_categoly);
			pstmt.setInt(7, market_num);
			pstmt.setInt(8, 1);

			
			return pstmt.executeUpdate(); //
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	 public ArrayList<Product> getList_product_categoly(int market_num, String market_categoly)
	    {
	        String SQL = "SELECT * FROM PRODUCT WHERE MARKET_NUM=? AND PRODUCT_CATEGOLY=?"; 
	        ArrayList<Product> list = new ArrayList<Product>();
	        try {
	        	 PreparedStatement pstmt = conn.prepareStatement(SQL); 
	        	pstmt.setInt(1, market_num);
		          pstmt.setString(2, market_categoly);
	 
	            rs = pstmt.executeQuery();
	            while (rs.next()) {
	            	Product product = new Product();
	            	product.setProduct_num(rs.getInt(1));
	            	product.setProduct_name(rs.getString(2));
	            	product.setProduct_value(rs.getInt(3));
	            	product.setProduct_image(rs.getString(4));
	            	product.setProduct_amount(rs.getInt(5));
	            	product.setProduct_categoly(rs.getString(6));
	            	product.setMarket_num(rs.getInt(7));
	            	product.setProduct_available(rs.getInt(8));
	            	list.add(product);
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return list; 
	    }
	 
	 public int Check_market_num( int check_market_num, String userID) {
		 String SQL = "SELECT * FROM MARKET WHERE market_num = ? AND market_userID= ?";
		 try{
			 PreparedStatement pstmt = conn.prepareStatement(SQL); 
			 pstmt.setInt(1, check_market_num);
	          pstmt.setString(2, userID);
			 rs = pstmt.executeQuery();
			 while (rs.next()) {
	            	return 1;
	            }
			 return 0;
			 
			 
		 }catch (Exception e) {
	            e.printStackTrace();
	        }
		
		 return -1; //데이터베이스 오류
	 } 
	 public int getNext()
	 {
	     String SQL =  "SELECT product_num FROM product ORDER BY product_num DESC"; // 내림차순으로 가장 마지막에 쓰인 것을 가져온다
	     try {
	         PreparedStatement pstmt = conn.prepareStatement(SQL);
	         rs = pstmt.executeQuery();
	         if(rs.next()) {
	             return rs.getInt(1) + 1; // 그 다음 게시글의 번호
	         }
	         return 1; // 첫 번째 게시물인 경우
	     } catch (Exception e) {
	         e.printStackTrace();
	     }
	     return -1; // 데이터베이스 오류
	 }
	 
	 public ArrayList<Product> getList_categoly(int last_num, int market_num, int Division)
	   {
		String SQL =null;
		if(Division == 1) {
			SQL = "SELECT *  FROM product WHERE product_num < ? and product_available = 1 AND market_num = ? and  product_num in(select max(product_num) from product group by product_categoly) ORDER BY product_num DESC LIMIT 10"; 
	       }
	       else {
	   		SQL = "SELECT *  FROM product WHERE product_num > ? and product_available = 1 AND market_num = ? and  product_num in(select max(product_num) from product group by product_categoly) ORDER BY product_num LIMIT 10"; // 

	       }
	       ArrayList<Product> list = new ArrayList<Product>();
	       try {
	    	  
	           PreparedStatement pstmt = conn.prepareStatement(SQL);
	           pstmt.setInt(1, last_num);
	           pstmt.setInt(2, market_num);
	           rs = pstmt.executeQuery();
	           while (rs.next()) {
	        	   Product product = new Product();
	        	   product.setProduct_num(rs.getInt(1));
	        	   product.setProduct_name(rs.getString(2));
	        	   product.setProduct_value(rs.getInt(3));
	        	   product.setProduct_image(rs.getString(4));
	        	   product.setProduct_amount(rs.getInt(5));
	        	   product.setProduct_categoly(rs.getString(6));
	        	   product.setMarket_num(rs.getInt(7));
	        	   product.setProduct_available(rs.getInt(8));
	        	   
	        	   list.add(product);
	           }
	       } catch (Exception e) {
	           e.printStackTrace();
	       }
	       return list; 
	   }
	 public boolean nextPage(int last_num, int market_num) {
		    String SQL = "SELECT *  FROM product WHERE product_num < ? and product_available = 1 AND market_num = ? and  product_num in(select max(product_num) from product group by product_categoly) ORDER BY product_num DESC LIMIT 10"; // 내림차순으로 가장 마지막에 쓰인 것을 가져온다
		    try {
		        PreparedStatement pstmt = conn.prepareStatement(SQL);
		        pstmt.setInt(1, last_num);
		        pstmt.setInt(2, market_num);
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

}