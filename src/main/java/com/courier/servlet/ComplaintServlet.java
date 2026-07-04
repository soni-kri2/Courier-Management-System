package com.courier.servlet;

import java.io.IOException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.courier.dao.ComplaintDAO;
import com.courier.model.Complaint;

@WebServlet("/submitComplaint")
public class ComplaintServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        HttpSession session = req.getSession();
        String email = (String) session.getAttribute("userEmail");

        String subject = req.getParameter("subject");
        String desc = req.getParameter("description");

        Complaint c = new Complaint();
        c.setUserEmail(email);
        c.setSubject(subject);
        c.setDescription(desc);

        ComplaintDAO dao = new ComplaintDAO();

        if (dao.addComplaint(c)) {
            res.sendRedirect("dashboard.jsp");
        } else {
            res.sendRedirect("complaint.jsp");
        }
    }
}
