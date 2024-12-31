package abipack;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import jakarta.servlet.annotation.WebServlet;

@WebServlet("/ViewResultsServlet")
public class ViewResultsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Path to your JAR file
        	 String jarPath = getServletContext().getRealPath("/WEB-INF/lib/ElectionGraph.jar");

             // Use ProcessBuilder to run the JAR
             ProcessBuilder pb = new ProcessBuilder("java", "-jar", jarPath);
             pb.start(); // Start the JAR
            System.out.println(jarPath);
            System.out.println("File link: file:///" + jarPath.replace("\\", "/"));
            // Inform the user that the graph will display
            response.getWriter().println("<html><body><h3>Election Results graph is opening. Please check your screen.</h3></body></html>");
        } catch (Exception e) {
            response.getWriter().println("<html><body><h3>Error: " + e.getMessage() + "</h3></body></html>");
        }
    }
}