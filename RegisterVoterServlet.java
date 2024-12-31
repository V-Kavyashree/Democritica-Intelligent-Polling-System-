package abipack;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.security.MessageDigest;
import java.security.SecureRandom;

@WebServlet("/RegisterVoterServlet")
@MultipartConfig
public class RegisterVoterServlet extends HttpServlet {
	
	final String JDBC_URL = "jdbc:mysql://localhost:3306/ElectionPollingSystem?connectTimeout=30000&socketTimeout=30000";
     final String JDBC_USER = "root"; // Update with your DB username
     final String JDBC_PASSWORD = ""; // Update with your DB password
     
	 @Override
	    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        // Forward to the registration page
		 System.out.println("hi");
	        request.getRequestDispatcher("register.jsp").forward(request, response);
	    }
	 
	 @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the form data from the request
		 System.out.println("hi");
    	int voter_id= Integer.parseInt(request.getParameter("voter_id"));
    	
    	
    	String username = request.getParameter("username");
    	
    	
        String firstname = request.getParameter("firstname");
        System.out.println(firstname);
        String lastname = request.getParameter("lastname");
        String dateOfBirth = request.getParameter("dateofbirth");
        int age = Integer.parseInt(request.getParameter("age"));
        String gender = request.getParameter("gender");
        String email = request.getParameter("emailid");
        String phoneNo = request.getParameter("phoneno");
        String district = request.getParameter("district");
        String address = request.getParameter("address");
        String password = request.getParameter("password");
        String voterStatus = "ACTIVE";
        System.out.println(voterStatus);
        
       
        
            // Database connection and insertion
                Connection conn = null;
                PreparedStatement ps = null;
                try {
                    // Load and register JDBC driver
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    
                    // Establish connection
                    conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
                    
                    // SQL query to insert the data into the voters table
                    String sql = "INSERT INTO voters (voter_id, username, firstname, lastname, dateofbirth, age, gender, emailid, phoneno, district, address, password,voterstatus) "
                            + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                    
                    // Prepare the statement
                    ps = conn.prepareStatement(sql);
                    ps.setInt(1, voter_id);
                    ps.setString(2, username);
                    ps.setString(3, firstname);
                    ps.setString(4, lastname);
                    ps.setString(5, dateOfBirth);
                    ps.setInt(6, age);
                    ps.setString(7, gender);
                    ps.setString(8, email);
                    ps.setString(9, phoneNo);
                    ps.setString(10, district);
                    ps.setString(11, address);
                    ps.setString(12, password); 
                    ps.setString(13, voterStatus);
        
                    // Execute the insertion
                    int rowsInserted = ps.executeUpdate();
                    
                    if (rowsInserted > 0) {
                        // Redirect to a success page or another JSP (optional)
                        response.sendRedirect("login.jsp");
                    } else {
                        // Show an error message if insertion fails
                        response.getWriter().println("Error: Registration failed.");
                    }
                } catch (SQLException | ClassNotFoundException e) {
                    // Handle any exceptions (e.g., database connection issues)
                    e.printStackTrace();
                    response.getWriter().println("Error: " + e.getMessage());
                } finally {
                    // Close resources
                    try {
                        if (ps != null) ps.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
            }
        
    }
}