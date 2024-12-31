<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Voters</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .button {
            padding: 10px 20px;
            margin: 10px;
            font-size: 16px;
            cursor: pointer;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
        }
        .button:hover {
            background-color: #0056b3;
        }
        table {
            border-collapse: collapse;
            width: 100%;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h1>Manage Voters</h1>
    <div>
        <!-- Button to view voted voters -->
        <form action="manageVoters.jsp" method="get">
            <input type="hidden" name="filter" value="voted">
            <button type="submit" class="button">View Voted Voters</button>
        </form>

        <!-- Button to view non-voted voters -->
        <form action="manageVoters.jsp" method="get">
            <input type="hidden" name="filter" value="non-voted">
            <button type="submit" class="button">View Non-Voted Voters</button>
        </form>
    </div>

    <div>
        <% 
            // Database connection details
            String url = "jdbc:mysql://localhost:3306/ElectionPollingSystem?useSSL=false&serverTimezone=UTC";
            String user = "root";
            String password = "";
            String filter = request.getParameter("filter");

            if (filter != null) {
                String query = "";
                if (filter.equals("voted")) {
                    query = "SELECT * FROM voters WHERE isvoted = 1";  // Query for voted voters
                } else if (filter.equals("non-voted")) {
                    query = "SELECT * FROM voters WHERE isvoted = 0";  // Query for non-voted voters
                }
                
                // Connect to the database and display data
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;

                try {
                    // Load the MySQL JDBC Driver
                    Class.forName("com.mysql.cj.jdbc.Driver");

                    // Establish the connection
                    conn = DriverManager.getConnection(url, user, password);
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery(query);

                    out.println("<table>");
                    out.println("<tr><th>Voter ID</th><th>Username</th><th>First Name</th><th>Last Name</th><th>Date of Birth</th><th>Age</th><th>Gender</th><th>Email ID</th><th>Phone No</th><th>District</th><th>Address</th><th>Password</th><th>Status</th><th>Voted</th></tr>");

                    // Iterate over the results and display them in the table
                    while (rs.next()) {
                        String voterId = rs.getString("voter_id");
                        String username = rs.getString("username");
                        String firstName = rs.getString("firstname");
                        String lastName = rs.getString("lastname");
                        String dateOfBirth = rs.getString("dateofbirth");
                        int age = rs.getInt("age");
                        String gender = rs.getString("gender");
                        String emailId = rs.getString("emailid");
                        String phoneNo = rs.getString("phoneno");
                        String district = rs.getString("district");
                        String address = rs.getString("address");
                        String passwordHash = rs.getString("password");  // Changed variable name
                        String voterStatus = rs.getString("voterstatus");
                        int isVoted = rs.getInt("isvoted");
                        String votedStatus = (isVoted == 1) ? "Voted" : "Not Voted";

                        out.println("<tr>");
                        out.println("<td>" + voterId + "</td>");
                        out.println("<td>" + username + "</td>");
                        out.println("<td>" + firstName + "</td>");
                        out.println("<td>" + lastName + "</td>");
                        out.println("<td>" + dateOfBirth + "</td>");
                        out.println("<td>" + age + "</td>");
                        out.println("<td>" + gender + "</td>");
                        out.println("<td>" + emailId + "</td>");
                        out.println("<td>" + phoneNo + "</td>");
                        out.println("<td>" + district + "</td>");
                        out.println("<td>" + address + "</td>");
                        out.println("<td>" + passwordHash + "</td>");  // Changed variable name
                        out.println("<td>" + voterStatus + "</td>");
                        out.println("<td>" + votedStatus + "</td>");
                        out.println("</tr>");
                    }

                    out.println("</table>");
                } catch (SQLException e) {
                    out.println("<p>Error fetching data: " + e.getMessage() + "</p>");
                } catch (ClassNotFoundException e) {
                    out.println("<p>Error loading MySQL driver: " + e.getMessage() + "</p>");
                } finally {
                    try {
                        // Close the resources
                        if (rs != null) rs.close();
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        out.println("<p>Error closing resources: " + e.getMessage() + "</p>");
                    }
                }
            }
        %>
    </div>
</body>
</html>
