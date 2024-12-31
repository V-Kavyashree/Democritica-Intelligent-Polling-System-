package abipack;

import java.sql.*;

public class VoterDAO {

    // Method to save a new voter
    public void saveVoter(Voter voter) {
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/polling", "root", "vanivenkat")) {
            String sql = "INSERT INTO register (voter_id, first_name, last_name, dob, gender, phone_no, email, password, salt, image, district) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setInt(1, voter.getVoterId());
            statement.setString(2, voter.getFirstName());
            statement.setString(3, voter.getLastName());
            statement.setDate(4, Date.valueOf(voter.getDob()));
            statement.setString(5, voter.getGender());
            statement.setString(6, voter.getPhoneNo());
            statement.setString(7, voter.getEmail());
            statement.setString(8, voter.getPassword());
            statement.setString(9, voter.getSalt());
            statement.setString(10, voter.getImage());
            statement.setString(11, voter.getDistrict());

            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle SQL exceptions
        }
    }

    // Method to get a voter by ID
    public Voter getVoterById(int voterId) {
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/polling","root", "vanivenkat")) {
            String sql = "SELECT * FROM register WHERE voter_id = ?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setInt(1, voterId);

            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                Voter voter = new Voter();
                voter.setVoterId(resultSet.getInt("voter_id"));
                voter.setFirstName(resultSet.getString("first_name"));
                voter.setLastName(resultSet.getString("last_name"));
                voter.setDob(resultSet.getDate("dob").toString());
                voter.setGender(resultSet.getString("gender"));
                voter.setPhoneNo(resultSet.getString("phone_no"));
                voter.setEmail(resultSet.getString("email"));
                voter.setPassword(resultSet.getString("password"));
                voter.setSalt(resultSet.getString("salt"));
                voter.setImage(resultSet.getString("image"));
                voter.setDistrict(resultSet.getString("district"));

                return voter;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle SQL exceptions
        }
        return null;
    }

    // Method to update an existing voter
    public void updateVoter(Voter voter) {
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/polling", "root", "vanivenkat")) {
            String sql = "UPDATE register SET first_name = ?, last_name = ?, dob = ?, gender = ?, phone_no = ?, email = ?, password = ?, salt = ?, image = ?, district = ? WHERE voter_id = ?";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, voter.getFirstName());
            statement.setString(2, voter.getLastName());
            statement.setDate(3, Date.valueOf(voter.getDob()));
            statement.setString(4, voter.getGender());
            statement.setString(5, voter.getPhoneNo());
            statement.setString(6, voter.getEmail());
            statement.setString(7, voter.getPassword());
            statement.setString(8, voter.getSalt());
            statement.setString(9, voter.getImage());
            statement.setString(10, voter.getDistrict());
            statement.setInt(11, voter.getVoterId());

            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle SQL exceptions
        }
    }
}
