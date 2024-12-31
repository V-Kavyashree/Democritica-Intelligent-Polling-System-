<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Voter Registration</title>
     <!-- Optional: Link to your CSS -->
</head>
<style>/* General Page Layout */
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f7f7f7;
    color: #333;
}

.container {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    height: 100vh;
    padding: 20px;
}

h1 {
    font-size: 32px;
    margin-bottom: 20px;
}

h2 {
    font-size: 24px;
    margin-bottom: 10px;
}

/* Register Form */
form {
    max-width: 400px;
    width: 100%;
    padding: 20px;
    background-color: #ffffff;
    border: 1px solid #ddd;
    border-radius: 8px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

form label {
    font-size: 14px;
    margin-bottom: 5px;
    display: block;
    color: #333;
}

form input[type="text"],
form input[type="email"],
form input[type="password"] {
    width: 100%;
    padding: 10px;
    margin-bottom: 15px;
    border: 1px solid #ccc;
    border-radius: 5px;
    font-size: 14px;
}

form input[type="submit"] {
    width: 100%;
    padding: 10px;
    background-color: #28a745; /* Submit button color */
    color: white;
    border: none;
    border-radius: 5px;
    font-weight: bold;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

form input[type="submit"]:hover {
    background-color: #218838;
}

/* Buttons */
button {
    background-color: #007bff; /* Primary button color */
    color: white;
    border: none;
    border-radius: 5px;
    padding: 10px 20px;
    font-size: 16px;
    cursor: pointer;
    transition: background-color 0.3s ease, transform 0.2s ease;
}

button:hover {
    background-color: #0056b3; /* Darker shade on hover */
    transform: scale(1.05); /* Slight enlargement */
}

button:disabled {
    background-color: #cccccc;
    cursor: not-allowed;
}

/* Responsive Design */
@media (max-width: 768px) {
    form {
        padding: 15px;
    }

    h1 {
        font-size: 28px;
    }

    h2 {
        font-size: 20px;
    }

    button, form input[type="submit"] {
        font-size: 14px;
        padding: 8px 15px;
    }
}
</style>
<body  style="align: center;">
    <h2>Voter Registration Form</h2>

    <!-- Form to capture user input for voter registration -->
    <form action="RegisterVoterServlet" method="POST" enctype="multipart/form-data">
    	<label for="voterid">Voter Id:</label><br>
    	<input type="text" id="voterId" name="voter_id" placeholder="Enter Voter ID" required><br>
    	
    	<label for="username">Username:</label><br>
        <input type="text" id="username" name="username" required><br>
        
   
        <label for="firstname">First Name:</label><br>
        <input type="text" id="firstname" name="firstname" required><br>

        <label for="lastname">Last Name:</label><br>
        <input type="text" id="lastname" name="lastname" required><br>

        <label for="dateofbirth">Date of Birth:</label><br>
        <input type="date" id="dateofbirth" name="dateofbirth" required><br>

        <label for="age">Age:</label><br>
        <input type="number" id="age" name="age" required><br>

        <label>Gender:</label><br>
        <input type="radio" id="male" name="gender" value="Male" required> Male
        <input type="radio" id="female" name="gender" value="Female" required> Female
        <input type="radio" id="other" name="gender" value="Other" required> Other<br>

        <label for="emailid">Email:</label><br>
        <input type="email" id="emailid" name="emailid" required><br>

        <label for="phoneno">Phone Number:</label><br>
        <input type="text" id="phoneno" name="phoneno" required><br>

        <label for="district">District:</label><br>
        <input type="text" id="district" name="district" required><br>

        <label for="address">Address:</label><br>
        <textarea id="address" name="address" required></textarea><br>

        <label for="password">Password:</label><br>
        <input type="password" id="password" name="password" required><br>

        <label>Status:</label><br>
        <input type="radio" id="active" name="voterstatus" value="Active" checked> Active
        <input type="radio" id="inactive" name="voterstatus" value="Inactive"> Inactive<br><br>

        <input type="submit" value="Submit">
    </form>
    
</body>
</html>