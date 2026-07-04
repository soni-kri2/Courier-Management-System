package com.courier.dao;
import java.util.List;

import java.util.ArrayList;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.courier.model.User;

public class UserDAO {

    // REGISTER USER
    public boolean registerUser(User user) {

        boolean status = false;

        try {

            Connection con = DBConnection.getConnection();

            String sql = "INSERT INTO users(full_name,email,phone,password) VALUES(?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getPassword());

            int row = ps.executeUpdate();

            if (row > 0) {
                status = true;
                System.out.println("✅ User inserted successfully");
            }

        } catch (Exception e) {
            e.printStackTrace(); // VERY IMPORTANT
        }

        return status;
    }

    // LOGIN USER
    public User loginUser(String email, String password) {

        User user = null;

        try {

            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM users WHERE email=? AND password=?";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                user = new User();

                user.setEmail(rs.getString("email"));
                user.setFullName(rs.getString("full_name"));
                user.setPhone(rs.getString("phone"));
                user.setRole(rs.getString("role")); // 🔥 IMPORTANT
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }
    public List<User> getAllUsers() {

        List<User> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM users";
            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                User u = new User();

                u.setFullName(rs.getString("full_name"));
                u.setEmail(rs.getString("email"));
                u.setPhone(rs.getString("phone"));

                list.add(u);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
  }