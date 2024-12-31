package abipack;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class PollingDatabaseExample {
    public static void main(String[] args) {
        // Database connection details
        String URL = "jdbc:mysql://localhost:3306/Polling"; // Replace 'Polling' with your database name
        String USER = "root"; // Replace with your username
        String PASSWORD = ""; // Replace with your password

        Connection connection = null;
        Statement statement = null;

        try {
            // Load the JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish the connection
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("Connection successful!");

            // Create a statement
            statement = connection.createStatement();

            // Execute a query to fetch data from the 'register' table
            String query = "SELECT * FROM register";
            ResultSet resultSet = statement.executeQuery(query);

            // Process and display the result set
            while (resultSet.next()) {
                int voterId = resultSet.getInt("voter_id");
                String firstName = resultSet.getString("first_name");
                String lastName = resultSet.getString("last_name");
                String dob = resultSet.getString("Dob");
                String gender = resultSet.getString("gender");
                long phoneNo = resultSet.getLong("phone_no");
                String email = resultSet.getString("email");
                int salt = resultSet.getInt("salt");
                String password = resultSet.getString("password");
                String district = resultSet.getString("district");

                System.out.println("Voter ID: " + voterId +
                        ", Name: " + firstName + " " + lastName +
                        ", DOB: " + dob +
                        ", Gender: " + gender +
                        ", Phone: " + phoneNo +
                        ", Email: " + email +
                        ", Salt: " + salt +
                        ", Password: " + password +
                        ", District: " + (district != null ? district : "N/A"));
            }

            // Close the result set
            resultSet.close();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                // Close resources
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
