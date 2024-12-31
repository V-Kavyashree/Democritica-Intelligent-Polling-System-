<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Elections</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .container {
            margin: 20px;
        }
        .hidden {
            display: none;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table, th, td {
            border: 1px solid #ccc;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        form, button {
            margin: 10px 0;
        }
        input, select, textarea, button {
            padding: 8px;
            margin: 10px 0;
            display: block;
            width: 100%;
            box-sizing: border-box;
        }
        button {
            background-color: #007bff;
            color: white;
            border: none;
            cursor: pointer;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
    <script>
        function toggleSection(sectionId) {
            document.getElementById("addSection").classList.add("hidden");
            document.getElementById("editSection").classList.add("hidden");
            document.getElementById("viewSection").classList.add("hidden");
            document.getElementById(sectionId).classList.remove("hidden");
        }
    </script>
</head>
<body>
<div class="container">
    <h1>Manage Elections</h1>

    <!-- Buttons to toggle sections -->
    <button onclick="toggleSection('addSection')">Add Election</button>
    <button onclick="toggleSection('editSection')">Edit Election</button>
    <button onclick="toggleSection('viewSection')">View Elections</button>

    <!-- Add Election Section -->
    <div id="addSection" class="hidden">
        <form method="post" action="manageElection.jsp?action=add">
            <h2>Add Election</h2>
            <label for="electionId">Election ID:</label>
            <input type="text" id="electionId" name="election_id" required>

            <label for="electionName">Election Name:</label>
            <input type="text" id="electionName" name="election_name" required>

            <label for="startDate">Start Date:</label>
            <input type="date" id="startDate" name="start_date" required>

            <label for="endDate">End Date:</label>
            <input type="date" id="endDate" name="end_date" required>

            <label for="location">Location:</label>
            <input type="text" id="location" name="location" required>

            <label for="electionType">Election Type:</label>
            <select id="electionType" name="election_type" required>
                <option value="General">General</option>
                <option value="Primary">Primary</option>
                <option value="Local">Local</option>
            </select>

            <label for="status">Status:</label>
            <select id="status" name="status" required>
                <option value="Scheduled">Scheduled</option>
                <option value="Ongoing">Ongoing</option>
                <option value="Completed">Completed</option>
            </select>

            <label for="description">Description:</label>
            <textarea id="description" name="description"></textarea>

            <input type="hidden" name="created_at" value="<%= new java.sql.Timestamp(System.currentTimeMillis()) %>">
            <button type="submit">Add Election</button>
        </form>
    </div>

    <!-- Edit Election Section -->
    <div id="editSection" class="hidden">
        <form method="post" action="manageElection.jsp?action=edit">
            <h2>Edit Election</h2>
            <label for="electionId">Election ID:</label>
            <input type="text" id="electionId" name="election_id" required>

            <label for="electionName">Election Name:</label>
            <input type="text" id="electionName" name="election_name">

            <label for="startDate">Start Date:</label>
            <input type="date" id="startDate" name="start_date">

            <label for="endDate">End Date:</label>
            <input type="date" id="endDate" name="end_date">

            <label for="location">Location:</label>
            <input type="text" id="location" name="location">

            <label for="electionType">Election Type:</label>
            <select id="electionType" name="election_type">
                <option value="General">General</option>
                <option value="Primary">Primary</option>
                <option value="Local">Local</option>
            </select>

            <label for="status">Status:</label>
            <select id="status" name="status">
                <option value="Scheduled">Scheduled</option>
                <option value="Ongoing">Ongoing</option>
                <option value="Completed">Completed</option>
            </select>

            <label for="description">Description:</label>
            <textarea id="description" name="description"></textarea>

            <input type="hidden" name="updated_at" value="<%= new java.sql.Timestamp(System.currentTimeMillis()) %>">
            <button type="submit">Edit Election</button>
        </form>
    </div>

    <!-- View Election Section -->
    <div id="viewSection" class="hidden">
        <h2>Election List</h2>
        <%
            String url = "jdbc:mysql://localhost:3306/ElectionPollingSystem";
            String user = "root"; // Update with your username
            String password = ""; // Update with your password
            String query = "SELECT * FROM election";
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                try (Connection conn = DriverManager.getConnection(url, user, password);
                     Statement stmt = conn.createStatement();
                     ResultSet rs = stmt.executeQuery(query)) {
        %>
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Start Date</th>
                <th>End Date</th>
                <th>Location</th>
                <th>Type</th>
                <th>Status</th>
                <th>Description</th>
            </tr>
            </thead>
            <tbody>
            <%
                while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getInt("election_id") %></td>
                <td><%= rs.getString("election_name") %></td>
                <td><%= rs.getDate("start_date") %></td>
                <td><%= rs.getDate("end_date") %></td>
                <td><%= rs.getString("location") %></td>
                <td><%= rs.getString("election_type") %></td>
                <td><%= rs.getString("status") %></td>
                <td><%= rs.getString("description") %></td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
        <%
                }
            } catch (Exception e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
            }
        %>
    </div>
</div>

<!-- Server-side Logic for Adding or Editing Elections -->
<%
    String action = request.getParameter("action");
    if ("add".equals(action) || "edit".equals(action)) {
        String electionId = request.getParameter("election_id");
        String electionName = request.getParameter("election_name");
        String startDate = request.getParameter("start_date");
        String endDate = request.getParameter("end_date");
        String location = request.getParameter("location");
        String electionType = request.getParameter("election_type");
        String status = request.getParameter("status");
        String description = request.getParameter("description");

        String queryToExecute = "";
        if ("add".equals(action)) {
            queryToExecute = "INSERT INTO election (election_id, election_name, start_date, end_date, location, election_type, status, description, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        } else if ("edit".equals(action)) {
            queryToExecute = "UPDATE election SET election_name = ?, start_date = ?, end_date = ?, location = ?, election_type = ?, status = ?, description = ?, updated_at = ? WHERE election_id = ?";
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(url, user, password);
                 PreparedStatement pstmt = conn.prepareStatement(queryToExecute)) {

                if ("add".equals(action)) {
                    pstmt.setString(1, electionId);
                    pstmt.setString(2, electionName);
                    pstmt.setString(3, startDate);
                    pstmt.setString(4, endDate);
                    pstmt.setString(5, location);
                    pstmt.setString(6, electionType);
                    pstmt.setString(7, status);
                    pstmt.setString(8, description);
                    pstmt.setTimestamp(9, new Timestamp(System.currentTimeMillis()));
                } else if ("edit".equals(action)) {
                    pstmt.setString(1, electionName);
                    pstmt.setString(2, startDate);
                    pstmt.setString(3, endDate);
                    pstmt.setString(4, location);
                    pstmt.setString(5, electionType);
                    pstmt.setString(6, status);
                    pstmt.setString(7, description);
                    pstmt.setTimestamp(8, new Timestamp(System.currentTimeMillis()));
                    pstmt.setString(9, electionId);
                }

                pstmt.executeUpdate();
                out.println("<p>Election successfully " + ("add".equals(action) ? "added" : "updated") + ".</p>");
            }
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        }
    }
%>
</body>
</html>
