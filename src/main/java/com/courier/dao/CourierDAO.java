package com.courier.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.courier.model.Courier;

public class CourierDAO {

    // 🔹 BOOK COURIER
    public boolean bookCourier(Courier c) {

        boolean status = false;

        try {
            Connection con = DBConnection.getConnection();

            String sql = "INSERT INTO couriers "
                    + "(tracking_number, sender_email, receiver_name, receiver_address, receiver_phone, weight, status, amount) "
                    + "VALUES (?,?,?,?,?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, c.getTrackingNumber());
            ps.setString(2, c.getSenderEmail());
            ps.setString(3, c.getReceiverName());
            ps.setString(4, c.getReceiverAddress());
            ps.setString(5, c.getReceiverPhone());
            ps.setDouble(6, c.getWeight());
            ps.setString(7, c.getStatus());
            ps.setDouble(8, c.getAmount());

            status = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    // 🔹 GET COURIER BY TRACKING
    public Courier getCourierByTracking(String tracking) {

        Courier c = null;

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM couriers WHERE tracking_number=?";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, tracking);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                c = new Courier();

                c.setTrackingNumber(rs.getString("tracking_number"));
                c.setSenderEmail(rs.getString("sender_email"));
                c.setReceiverName(rs.getString("receiver_name"));
                c.setReceiverAddress(rs.getString("receiver_address"));
                c.setReceiverPhone(rs.getString("receiver_phone"));
                c.setWeight(rs.getDouble("weight"));
                c.setStatus(rs.getString("status"));
                c.setAmount(rs.getDouble("amount"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return c;
    }

    // 🔹 UPDATE STATUS
    public boolean updateStatus(String tracking, String status) {

        boolean updated = false;

        try {
            Connection con = DBConnection.getConnection();

            String sql = "UPDATE couriers SET status=? WHERE tracking_number=?";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, status);
            ps.setString(2, tracking);

            updated = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return updated;
    }

    // 🔹 GET ALL COURIERS (FOR DASHBOARD)
    public List<Courier> getAllCouriers() {

        List<Courier> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM couriers ORDER BY booked_at DESC";

            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Courier c = new Courier();

                c.setTrackingNumber(rs.getString("tracking_number"));
                c.setSenderEmail(rs.getString("sender_email"));
                c.setReceiverName(rs.getString("receiver_name"));
                c.setReceiverAddress(rs.getString("receiver_address"));
                c.setReceiverPhone(rs.getString("receiver_phone"));
                c.setWeight(rs.getDouble("weight"));
                c.setStatus(rs.getString("status"));
                c.setAmount(rs.getDouble("amount"));

                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}