package product;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class productDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	public productDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/prototype?serverTimezone=Asia/Seoul";
			String dbID = "root";			
			String dbPassword = "kang0320";
			Class.forName("com.mysql.jdbc.Driver"); //
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);	
		} catch (Exception e) 
	{
			e.printStackTrace(); //
		}
	}
	public int upload(Integer product_num, String  product_name, Integer product_value, String product_image, Integer product_amount, String product_categoly) {
		String SQL = "INSERT INTO PRODUCT VALUES (?, ?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, product_num);
			pstmt.setString(2,  product_name);
			pstmt.setInt(3, product_value);
			pstmt.setString(4, product_image);
			pstmt.setInt(5, product_amount);
			pstmt.setString(6, product_categoly);

			
			return pstmt.executeUpdate(); //
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	 public ArrayList<Product> getList(int pageNumber)
	    {
	        String SQL = "SELECT * FROM PRODUCT"; 
	        ArrayList<Product> list = new ArrayList<Product>();
	        try {
	            PreparedStatement pstmt = conn.prepareStatement(SQL);
	            rs = pstmt.executeQuery();
	            while (rs.next()) {
	            	Product product = new Product();
	            	product.setProduct_num(rs.getInt(1));
	            	product.setProduct_name(rs.getString(2));
	            	product.setProduct_value(rs.getInt(3));
	            	product.setProduct_image(rs.getString(4));
	            	product.setProduct_amount(rs.getInt(5));
	            	product.setProduct_categoly(rs.getString(6));
	            	
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return list; 
	    }

}

