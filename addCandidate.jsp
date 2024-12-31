<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Add Candidate</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        form {
            margin: 20px;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            width: 300px;
        }
        input, select {
            display: block;
            width: 100%;
            margin: 10px 0;
            padding: 8px;
            box-sizing: border-box;
        }
        button {
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <h1>Add Candidate</h1>

    <!-- Form for adding a candidate -->
    <form method="post" action="addCandidate.jsp">
        <label for="candidateId">Candidate ID:</label>
        <input type="text" id="candidateId" name="candidate_id" required>

        <label for="firstName">First Name:</label>
        <input type="text" id="firstName" name="first_name" required>

        <label for="lastName">Last Name:</label>
        <input type="text" id="lastName" name="last_name" required>

        <label for="dob">Date of Birth:</label>
        <input type="date" id="dob" name="dob" required>

        <label for="gender">Gender:</label>
        <select id="gender" name="gender" required>
            <option value="Male">Male</option>
            <option value="Female">Female</option>
            <option value="Other">Other</option>
        </select>

        <label for="phoneNo">Phone Number:</label>
        <input type="text" id="phoneNo" name="phone_no" required>

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required>

        <label for="district">District:</label>
        <input type="text" id="district" name="district" required>

          <label for="symbol">Symbol:</label>
        <input type="number" id="symbol" name="symbol" required>

        <label for="party">Party:</label>
        <input type="text" id="party" name="party">

      

        <button type="submit">Add Candidate</button>
    </form>

    <!-- Logic for inserting data -->
    <%
        if (request.getMethod().equalsIgnoreCase("POST")) {
            String url = "jdbc:mysql://localhost:3306/ElectionPollingSystem";
            String user = "root"; // Update if needed
            String password = ""; // Update if needed

            String candidateId = request.getParameter("candidate_id");
            String firstName = request.getParameter("first_name");
            String lastName = request.getParameter("last_name");
            String dob = request.getParameter("dob");
            String gender = request.getParameter("gender");
            String phoneNo = request.getParameter("phone_no");
            String email = request.getParameter("email");
            String district = request.getParameter("district");
            String symbol = request.getParameter("symbol");
            String party = request.getParameter("party");
            String count = "0";

            String query = "INSERT INTO candidate (Candidate_id, first_name, last_name, dob, gender, phone_no, email, district, symbol, party, count) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                try (Connection conn = DriverManager.getConnection(url, user, password);
                     PreparedStatement ps = conn.prepareStatement(query)) {

                    ps.setInt(1, Integer.parseInt(candidateId));
                    ps.setString(2, firstName);
                    ps.setString(3, lastName);
                    ps.setString(4, dob);
                    ps.setString(5, gender);
                    ps.setString(6, phoneNo);
                    ps.setString(7, email);
                    ps.setString(8, district);
                    ps.setLong(9, Long.parseLong(symbol));
                    ps.setString(10, party);
                    ps.setInt(11, Integer.parseInt(count));

                    int rowsInserted = ps.executeUpdate();
                    if (rowsInserted > 0) {
                        out.println("<p>Candidate added successfully!</p>");
                    } else {
                        out.println("<p>Error adding candidate. Please try again.</p>");
                    }
                }
            } catch (Exception e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            }
        }
    %>
</body>
</html>
