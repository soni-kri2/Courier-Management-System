package com.courier.servlet;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.courier.dao.CourierDAO;
import com.courier.model.Courier;

@WebServlet("/trackCourier")
public class TrackCourierServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String tracking = request.getParameter("tracking");

        CourierDAO dao = new CourierDAO();
        Courier c = dao.getCourierByTracking(tracking);

        request.setAttribute("courier", c);

        RequestDispatcher rd = request.getRequestDispatcher("trackResult.jsp");
        rd.forward(request, response);
    }
}
