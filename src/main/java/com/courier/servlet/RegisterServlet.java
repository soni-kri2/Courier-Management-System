package com.courier.servlet;

import java.io.IOException;

import com.courier.dao.UserDAO;
import com.courier.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        User user = new User();

        user.setFullName(name);
        user.setEmail(email);
        user.setPassword(password);
        user.setPhone(phone);
        user.setAddress(address);

        UserDAO dao = new UserDAO();

        boolean status = dao.registerUser(user);

        if (status) {
        	HttpSession session = request.getSession();
        	session.setAttribute("userEmail", email);

        	response.sendRedirect("dashboard.jsp");
        } else {
            response.sendRedirect("register.jsp");
        }
    }
}