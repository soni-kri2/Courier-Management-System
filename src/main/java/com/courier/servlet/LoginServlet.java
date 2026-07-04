package com.courier.servlet;

import java.io.IOException;

import com.courier.dao.UserDAO;
import com.courier.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {

            String email = request.getParameter("email");
            String password = request.getParameter("password");

            // 🔐 Basic validation
            if (email == null || password == null || email.isEmpty() || password.isEmpty()) {
                request.setAttribute("errorMessage", "Please enter email and password");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            UserDAO dao = new UserDAO();
            User user = dao.loginUser(email, password);

            if (user != null) {

                HttpSession session = request.getSession();

                session.setAttribute("userEmail", user.getEmail());
                session.setAttribute("userName", user.getFullName());
                session.setAttribute("role", user.getRole());

                // 🔥 ROLE BASED REDIRECT (SAFE)
                String role = user.getRole();

                if ("admin".equalsIgnoreCase(role)) {

                    response.sendRedirect("adminDashboard"); // ✅ servlet recommended

                } else if ("customer".equalsIgnoreCase(role)) {

                    response.sendRedirect("dashboard");

                } else {

                    // fallback safety
                    response.sendRedirect("login.jsp?error=InvalidRole");
                }

            } else {

                request.setAttribute("errorMessage", "Invalid email or password!");
                request.setAttribute("email", email);

                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

        } catch (Exception e) {

            e.printStackTrace();

            request.setAttribute("errorMessage", "Something went wrong. Please try again.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}