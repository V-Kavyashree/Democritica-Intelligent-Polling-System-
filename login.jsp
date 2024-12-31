<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="professional.css"> <!-- Link to your CSS -->
    <style>
        /* Additional styles for this page */
        .login-container {
            background: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            max-width: 400px;
            width: 100%;
            margin: 50px auto;
            text-align: center;
        }

        .login-container h2 {
            font-size: 24px;
            margin-bottom: 20px;
            color: #333;
            font-weight: bold;
        }

        .login-container input[type="submit"] {
            margin-top: 15px;
        }

        .login-options {
            margin-top: 15px;
            font-size: 14px;
        }

        .login-options a {
            color: #4CAF50;
            text-decoration: none;
            font-weight: bold;
        }

        .login-options a:hover {
            text-decoration: underline;
        }

        .remember-me {
            display: flex;
            align-items: center;
            justify-content: start;
            margin-top: 10px;
        }

        .remember-me input[type="checkbox"] {
            margin-right: 5px;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>Login</h2>
        <form action="LoginServlet" method="POST"  enctype="multipart/form-data">
            <label for="username">Username:</label><br>
            <input type="text" id="username" name="username" placeholder="Enter your username" required><br>

            <label for="password">Password:</label><br>
            <input type="password" id="password" name="password" placeholder="Enter your password" required><br>

            <div class="remember-me">
                <input type="checkbox" id="remember" name="remember">
                <label for="remember">Remember Me</label>
            </div>

            <input type="submit" value="Login">
        </form>

        <div class="login-options">
            <a href="forgot_password.jsp">Forgot Password?</a><br>
            <a href="register.jsp">Sign Up</a>
        </div>
    </div>
</body>
</html>