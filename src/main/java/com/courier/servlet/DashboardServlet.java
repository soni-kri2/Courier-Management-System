package com.courier.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.courier.dao.CourierDAO;
import com.courier.model.Courier;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        if (session.getAttribute("userEmail") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        CourierDAO dao = new CourierDAO();
        List<Courier> list = dao.getAllCouriers();

        request.setAttribute("couriers", list);

        RequestDispatcher rd = request.getRequestDispatcher("dashboard.jsp");
        rd.forward(request, response);
    }
}