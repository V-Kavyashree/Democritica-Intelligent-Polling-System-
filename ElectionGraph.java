package abipack;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartPanel;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.renderer.category.BarRenderer;
import org.jfree.data.category.DefaultCategoryDataset;

import javax.swing.*;
import java.awt.*;
import java.sql.*;

public class ElectionGraph extends JFrame {

    private JPanel chartPanel;

    public ElectionGraph() {
        setTitle("Election Results");
        setSize(800, 600);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null);

        // Main layout with refresh button
        JPanel mainPanel = new JPanel();
        mainPanel.setLayout(new BorderLayout());

        // Create a panel to hold the district charts
        chartPanel = new JPanel();
        chartPanel.setLayout(new BoxLayout(chartPanel, BoxLayout.Y_AXIS)); // Stack charts vertically
        JScrollPane scrollPane = new JScrollPane(chartPanel);

        // Add a "Refresh" button
        JButton refreshButton = new JButton("Refresh Data");
        refreshButton.setFont(new Font("Arial", Font.BOLD, 14));
        refreshButton.addActionListener(e -> loadData()); // Reload charts on button click

        // Add the scroll panel and button to the main panel
        mainPanel.add(scrollPane, BorderLayout.CENTER);
        mainPanel.add(refreshButton, BorderLayout.NORTH);

        // Set the content pane
        setContentPane(mainPanel);

        // Load and display data initially
        loadData();
    }

    private void loadData() {
        String query = "SELECT first_name, last_name, count, district, party FROM Candidate";
        try {
            // JDBC operations
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection connection = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/ElectionPollingSystem?serverTimezone=UTC", 
                    "root", 
                    "")) {
                PreparedStatement preparedStatement = connection.prepareStatement(query);
                ResultSet resultSet = preparedStatement.executeQuery();

                // Clear the chart panel before adding new data
                chartPanel.removeAll();

                // Group data by district
                DefaultCategoryDataset datasetByDistrict = new DefaultCategoryDataset();
                String currentDistrict = null;
                while (resultSet.next()) {
                    String fullName = resultSet.getString("first_name") + " " + resultSet.getString("last_name");
                    int count = resultSet.getInt("count");
                    String district = resultSet.getString("district");

                    // Only add a new chart for a new district
                    if (currentDistrict == null || !currentDistrict.equals(district)) {
                        if (currentDistrict != null) {
                            // Create and add the previous district chart to the panel
                            JFreeChart chart = createChart(datasetByDistrict, currentDistrict);
                            chartPanel.add(new ChartPanel(chart));
                            chartPanel.add(Box.createVerticalStrut(20)); // Add some space between charts
                        }

                        // Reset the dataset for the new district
                        datasetByDistrict = new DefaultCategoryDataset();
                        currentDistrict = district;
                    }

                    // Add data to the current district dataset
                    datasetByDistrict.addValue(count, fullName, district);
                }

                // Add the last district chart
                if (currentDistrict != null) {
                    JFreeChart chart = createChart(datasetByDistrict, currentDistrict);
                    chartPanel.add(new ChartPanel(chart));
                }

                chartPanel.revalidate(); // Revalidate the layout after adding all charts
                chartPanel.repaint(); // Repaint to update the display
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    private JFreeChart createChart(DefaultCategoryDataset dataset, String district) {
        JFreeChart chart = ChartFactory.createBarChart(
                "Vote Count for District: " + district,  // Chart title
                "Candidates",                          // X-axis label
                "Vote Count",                          // Y-axis label
                dataset                                // Dataset
        );

        // Set chart background color
        chart.setBackgroundPaint(new Color(240, 248, 255)); // Light blue background

        // Get the plot
        CategoryPlot plot = chart.getCategoryPlot();
        
        // Set plot background color
        plot.setBackgroundPaint(new Color(230, 230, 250)); // Lavender background
        plot.setRangeGridlinePaint(Color.BLACK); // Set gridline color to black

        // Get the renderer
        BarRenderer renderer = (BarRenderer) plot.getRenderer();

        // Enable tooltips for each bar
        renderer.setBaseToolTipGenerator((dataset1, row, column) -> {
            Number value = dataset1.getValue(row, column); // Get the count value
            String candidate = dataset1.getRowKey(row).toString(); // Candidate name
            String districtName = dataset1.getColumnKey(column).toString(); // District name
            return String.format("%s (%s): %d votes", candidate, districtName, value.intValue());
        });

        // Set the maximum bar width (adjust as needed)
        renderer.setMaximumBarWidth(0.15); // Adjust this value to control bar width
        renderer.setDrawBarOutline(true);
        renderer.setSeriesOutlineStroke(0, new BasicStroke(2.0f)); // Thicken the outline
        renderer.setSeriesVisibleInLegend(false); // Hide legend for each candidate

        return chart;
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> {
            ElectionGraph graph = new ElectionGraph();
            graph.setVisible(true);
        });
    }
}
