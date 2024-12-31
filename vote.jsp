<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>
<%@ page import="java.sql.*, jakarta.servlet.http.*, jakarta.servlet.*"%>
<%@ page session="false" %>

<%
    HttpSession session = request.getSession(false);
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

    String voterDistrict = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);

        // Fetch voter's district
        String districtQuery = "SELECT district FROM voters WHERE username = ?";
        ps = conn.prepareStatement(districtQuery);
        ps.setString(1, username);
        rs = ps.executeQuery();

        if (rs.next()) {
            voterDistrict = rs.getString("district");
        }

        if (voterDistrict == null) {
            out.println("<p>Error: Unable to fetch voter's district.</p>");
            return;
        }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Vote</title>
    <link rel="stylesheet" href="professional.css">
</head>
<body>
    <h2>Vote for a Candidate</h2>
    <%
        // Fetch candidates from the same district
        String candidateQuery = "SELECT Candidate_id, first_name, last_name, Party " +
                                "FROM Candidate " +
                                "WHERE district = ?";
        ps = conn.prepareStatement(candidateQuery);
        ps.setString(1, voterDistrict);
        rs = ps.executeQuery();

        if (!rs.isBeforeFirst()) {
            out.println("<p>No candidates available in your district.</p>");
        } else {
    %>
    <form action="CastVoteServlet" method="POST">
        <table border="1">
            <tr>
                <th>Candidate Name</th>
                <th>Party</th>
                <th>Symbol</th>
                <th>Vote</th>
            </tr>
            <%
                while (rs.next()) {
                    int candidateId = rs.getInt("Candidate_id");
                    String candidateName = rs.getString("first_name") + " " + rs.getString("last_name");
                    String party = rs.getString("Party");

                    // Construct the path to the image based on the party name
                    String symbolPath = "images/" + party + ".png"; // Assuming image names follow the pattern PartyName.png
            %>
            <tr>
                <td><%= candidateName %></td>
                <td><%= party %></td>
                <td><img src="<%= symbolPath %>" alt="<%= party %> symbol" style="width:50px;height:50px;"></td>
                <td><input type="radio" name="candidate_id" value="<%= candidateId %>" required></td>
            </tr>
            <% } %>
        </table>
        <input type="submit" value="Submit Vote">
    </form>
    <%
        }
    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    }
    %>
</body>
</html>
