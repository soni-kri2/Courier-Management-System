package com.courier.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.courier.dao.CourierDAO;

@WebServlet("/UpdateStatusServlet")
public class UpdateStatusServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String tracking = request.getParameter("tracking");
        String status = request.getParameter("status");

        CourierDAO dao = new CourierDAO();

        boolean updated = dao.updateStatus(tracking, status);

        if(updated){
            System.out.println("✅ Status updated");
        } else {
            System.out.println("❌ Update failed");
        }

        // 🔥 IMPORTANT FIX
        response.sendRedirect("adminDashboard?panel=couriers");
    }
}