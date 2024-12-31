<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>
<%@ page import="java.sql.*, jakarta.servlet.http.*, jakarta.servlet.*"%>
<%
    // Retrieve voter details from session
    String username = (String) session.getAttribute("username");

    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String JDBC_URL = "jdbc:mysql://localhost:3306/ElectionPollingSystem";
    String JDBC_USER = "root"; // Update with your DB username
    String JDBC_PASSWORD = ""; // Update with your DB password

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);

        // Fetch details for the dashboard
        String voterQuery = "SELECT * FROM voters WHERE username = ?";
        ps = conn.prepareStatement(voterQuery);
        ps.setString(1, username);
        rs = ps.executeQuery();

        if (rs.next()) {
            String fullName = rs.getString("firstname") + " " + rs.getString("lastname");
            String district = rs.getString("district");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
    <link rel="stylesheet" href="professional.css">
</head>
<body>
    <h2>Welcome, <%= fullName %></h2>
    <p>Your district: <%= district %></p>

    <!-- Buttons for Logout, View Results, and Vote -->
    <form action="logout.jsp" method="POST" style="display: inline;">
        <button type="submit">Logout</button>
    </form>
    <form action="ViewResultsServlet" method="GET" style="display: inline;">
        <button type="submit">View Results</button>
    </form>
    <form action="vote.jsp" method="GET" style="display: inline;">
        <button type="submit">Vote</button>
    </form>
</body>
</html>
<%
        } else {
            out.println("<p>Error: Voter details not found.</p>");
        }
    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    }
%>
