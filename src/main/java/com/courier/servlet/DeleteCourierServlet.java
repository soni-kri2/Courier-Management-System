package com.courier.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.courier.dao.DBConnection;

@WebServlet("/deleteCourier")
public class DeleteCourierServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        String tracking = req.getParameter("tracking");

        try {
            Connection con = DBConnection.getConnection();

            String sql = "DELETE FROM couriers WHERE tracking_number=?";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, tracking);
            ps.executeUpdate();

        } catch(Exception e){
            e.printStackTrace();
        }

        res.sendRedirect("adminDashboard");
    }
}