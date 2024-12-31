package abipack;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Invalidate the session to log out the user
        HttpSession session = request.getSession();
        session.invalidate();
        response.sendRedirect("login.jsp"); // Redirect to login page after logout
    }
}
