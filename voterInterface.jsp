<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Voter Dashboard</title>
</head>
<body>
    <h1>Welcome, ${user.firstName} ${user.lastName}!</h1>
    <p>Your Voter ID: ${user.voterId}</p>
    <p>Email: ${user.email}</p>
    <p>District: ${user.district}</p>

    <h2>Options:</h2>
    <ul>
        <li><a href="vote.jsp">Vote Now</a></li>
        <li><a href="viewResults.jsp">View Voting Results</a></li>
        <li><a href="logout.jsp">Logout</a></li>
    </ul>
</body>
</html>
