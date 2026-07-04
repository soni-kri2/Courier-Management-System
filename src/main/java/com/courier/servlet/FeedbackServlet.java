package com.courier.servlet;

import java.io.IOException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.courier.dao.FeedbackDAO;
import com.courier.model.Feedback;

@WebServlet("/submitFeedback")
public class FeedbackServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        HttpSession session = req.getSession();
        String email = (String) session.getAttribute("userEmail");

        String message = req.getParameter("message");
        int rating = Integer.parseInt(req.getParameter("rating"));

        Feedback f = new Feedback();
        f.setUserEmail(email);
        f.setMessage(message);
        f.setRating(rating);

        FeedbackDAO dao = new FeedbackDAO();

        if (dao.addFeedback(f)) {
            res.sendRedirect("dashboard.jsp");
        } else {
            res.sendRedirect("feedback.jsp");
        }
    }
}