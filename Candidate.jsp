<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title> Candidates</title>
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
    <h1> Candidates</h1>
    
    <!-- Button to manage candidates -->
 

   

    <div>
        <% 
           
                // Database connection details
                String url = "jdbc:mysql://localhost:3306/ElectionPollingSystem";
                String user = "root";
                String password = "";
                String query = "SELECT * FROM candidate"; // Query to get all candidates

                try {
                    // Load MySQL JDBC driver
                    Class.forName("com.mysql.cj.jdbc.Driver");

                    try (Connection conn = DriverManager.getConnection(url, user, password);
                         Statement stmt = conn.createStatement();
                         ResultSet rs = stmt.executeQuery(query)) {

                        out.println("<table>");
                        out.println("<tr><th>Candidate ID</th><th>First Name</th><th>Last Name</th><th>DOB</th><th>Gender</th><th>Phone No</th><th>Email</th><th>District</th><th>Symbol</th><th>Count</th><th>Party</th></tr>");

                        // Loop through the result set and print candidate details in table
                        while (rs.next()) {
                            int candidateId = rs.getInt("candidate_id");
                            String firstName = rs.getString("first_name");
                            String lastName = rs.getString("last_name");
                            Date dob = rs.getDate("dob");
                            String gender = rs.getString("gender");
                            long phoneNo = rs.getLong("phone_no");
                            String email = rs.getString("email");
                            String district = rs.getString("district");
                            long symbol = rs.getLong("symbol");
                            int count = rs.getInt("count");
                            String party = rs.getString("party");

                            out.println("<tr>");
                            out.println("<td>" + candidateId + "</td>");
                            out.println("<td>" + firstName + "</td>");
                            out.println("<td>" + lastName + "</td>");
                            out.println("<td>" + dob + "</td>");
                            out.println("<td>" + gender + "</td>");
                            out.println("<td>" + phoneNo + "</td>");
                            out.println("<td>" + email + "</td>");
                            out.println("<td>" + district + "</td>");
                            out.println("<td>" + symbol + "</td>");
                            out.println("<td>" + count + "</td>");
                            out.println("<td>" + party + "</td>");
                            out.println("</tr>");
                        }

                        out.println("</table>");
                    } catch (SQLException e) {
                        out.println("<p>Error fetching data: " + e.getMessage() + "</p>");
                    }

                } catch (ClassNotFoundException e) {
                    out.println("<p>Error loading MySQL driver: " + e.getMessage() + "</p>");
                }
            
        %>
    </div>
</body>
</html>
