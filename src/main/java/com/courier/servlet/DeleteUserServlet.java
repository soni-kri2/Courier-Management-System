package com.courier.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.courier.dao.DBConnection;

@WebServlet("/deleteUser")
public class DeleteUserServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        String email = req.getParameter("email");

        try {
            Connection con = DBConnection.getConnection();

            String sql = "DELETE FROM users WHERE email=?";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, email);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }

        res.sendRedirect("adminDashboard"); // back to dashboard
    }
}