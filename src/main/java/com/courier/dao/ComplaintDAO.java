package com.courier.dao;
import java.util.List;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.sql.Connection;
import java.sql.PreparedStatement;
import com.courier.model.Complaint;

public class ComplaintDAO {

    public boolean addComplaint(Complaint c) {
        boolean status = false;

        try {
            Connection con = DBConnection.getConnection();

            String sql = "INSERT INTO complaints(user_email, subject, description, status) VALUES (?, ?, ?, 'Open')";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, c.getUserEmail());
            ps.setString(2, c.getSubject());
            ps.setString(3, c.getDescription());

            status = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }
    
    public List<Complaint> getAllComplaints(){

        List<Complaint> list = new ArrayList<>();

        try{
            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM complaints";
            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                Complaint c = new Complaint();

                c.setUserEmail(rs.getString("user_email"));
                c.setSubject(rs.getString("subject"));
                c.setDescription(rs.getString("description"));
                c.setStatus(rs.getString("status"));

                list.add(c);
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return list;
    }
}
