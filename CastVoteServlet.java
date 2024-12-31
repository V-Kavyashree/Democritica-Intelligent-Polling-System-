package abipack;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/CastVoteServlet")

public class CastVoteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        String username = (String) session.getAttribute("username");

        // Redirect to login page if username is not present in session
        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get the candidate ID from the request parameter
        String candidateId = request.getParameter("candidate_id");

        // Database connection variables
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        String JDBC_URL = "jdbc:mysql://localhost:3306/ElectionPollingSystem";
        String JDBC_USER = "root"; // Update with your DB username
        String JDBC_PASSWORD = ""; // Update with your DB password

        try {
            // Load the JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish the connection
            conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);

            // Check if the voter has already voted
            String checkVoteQuery = "SELECT isvoted FROM voters WHERE username = ?";
            ps = conn.prepareStatement(checkVoteQuery);
            ps.setString(1, username);
            rs = ps.executeQuery();
            rs.next();

            if (rs.getInt("isvoted") == 1) {
                // If the user has already voted, redirect to a page or display a message
                response.getWriter().println("You have already voted.");
                return;
            }

            // Insert the vote into the votes table
            String insertVoteQuery = "INSERT INTO votes (username, candidate_id) VALUES (?, ?)";
            ps = conn.prepareStatement(insertVoteQuery);
            ps.setString(1, username);
            ps.setString(2, candidateId);
            ps.executeUpdate();

            // Update the vote count for the candidate
            String updateVoteCountQuery = "UPDATE Candidate SET count = IFNULL(count, 0) + 1 WHERE Candidate_id = ?";
            ps = conn.prepareStatement(updateVoteCountQuery);
            ps.setString(1, candidateId);
            ps.executeUpdate();

            // Update the voters table to set isvoted to 1
            String updateVoterQuery = "UPDATE voters SET isvoted = 1 WHERE username = ?";
            ps = conn.prepareStatement(updateVoterQuery);
            ps.setString(1, username);
            ps.executeUpdate();

            // Redirect the user to a confirmation page
            response.sendRedirect("voteSuccessful.jsp");

        } catch (SQLException e) {
            // Handle SQL errors
            e.printStackTrace();
            response.getWriter().println("Database error: " + e.getMessage());
        } catch (Exception e) {
            // Handle other errors
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            // Ensure all resources are closed
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException ignored) {
                // Handle any exception while closing resources
                ignored.printStackTrace();
            }
        }
    }
}
