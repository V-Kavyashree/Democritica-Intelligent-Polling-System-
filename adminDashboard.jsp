<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .menu {
            display: flex;
            flex-direction: column;
            width: 300px;
            gap: 10px;
        }
        .menu button {
            padding: 10px;
            font-size: 16px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <h1>Admin Dashboard</h1>
    <div class="menu">
        <form action="manageVoters.jsp" method="get">
            <button type="submit">Manage Voters</button>
        </form>
        <form action="manageCandidates.jsp" method="get">
            <button type="submit">Manage Candidates</button>
        </form>
        <form action="manageElection.jsp" method="get">
            <button type="submit">Manage Elections</button>
        </form>
        <form action="manageResults.jsp" method="get">
            <button type="submit">Manage Results</button>
        </form>
    </div>
</body>
</html>
