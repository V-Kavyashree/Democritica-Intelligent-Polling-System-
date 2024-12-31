package abipack;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;

import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/LoginServlet")
@MultipartConfig
public class LoginServlet extends HttpServlet {

    // Database connection parameters
    final String JDBC_URL = "jdbc:mysql://localhost:3306/ElectionPollingSystem";
    final String JDBC_USER = "root"; // Update with your DB username
    final String JDBC_PASSWORD = ""; // Update with your DB password
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward to the registration page
	 System.out.println("hi");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form inputs
    	System.out.println("hi");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            // Load the JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish a database connection
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);

            // SQL query to validate credentials
            String sql = "SELECT * FROM voters WHERE username = ? AND password = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);

            // Execute the query
            rs = ps.executeQuery();

            if (rs.next()) {
                // Successful login
                String voterName = rs.getString("firstname") + " " + rs.getString("lastname");
                HttpSession session = request.getSession();
                session.setAttribute("voterName", voterName); // Save voter name in session
                session.setAttribute("username", username);  // Save username in session

                // Redirect to dashboard or home page
                response.sendRedirect("dashboard.jsp");
            } else {
                // Failed login
                request.setAttribute("errorMessage", "Invalid username or password");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            // Close resources
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}