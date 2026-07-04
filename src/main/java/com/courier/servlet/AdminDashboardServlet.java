package com.courier.servlet;
import java.io.IOException;
import java.util.List;
 
import java.util.ArrayList;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.courier.dao.UserDAO;
import com.courier.dao.CourierDAO;
import com.courier.dao.ComplaintDAO;
import com.courier.dao.FeedbackDAO;

import com.courier.model.User;
import com.courier.model.Courier;
import com.courier.model.Complaint;
import com.courier.model.Feedback;

@WebServlet("/adminDashboard")
public class AdminDashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession();

        String role = (String) session.getAttribute("role");

        if (role == null || !"admin".equals(role)) {
            res.sendRedirect("login.jsp");
            return;
        }

        try {

            UserDAO userDAO = new UserDAO();
            CourierDAO courierDAO = new CourierDAO();
            ComplaintDAO complaintDAO = new ComplaintDAO();
            FeedbackDAO feedbackDAO = new FeedbackDAO();

            req.setAttribute("users", userDAO.getAllUsers());
            req.setAttribute("couriers", courierDAO.getAllCouriers());
            req.setAttribute("complaints", complaintDAO.getAllComplaints());
            req.setAttribute("feedbacks", feedbackDAO.getAllFeedback());

            req.getRequestDispatcher("adminDashboard.jsp").forward(req, res);

        } catch (Exception e) {
            e.printStackTrace();

            res.getWriter().println("Error occurred: " + e.getMessage());
        }
    }
}