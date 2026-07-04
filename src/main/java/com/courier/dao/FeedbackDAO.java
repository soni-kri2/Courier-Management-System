package com.courier.dao;
import java.util.List;
import java.util.ArrayList;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import com.courier.model.Feedback;

public class FeedbackDAO {

    public boolean addFeedback(Feedback f) {
        boolean status = false;

        try {
            Connection con = DBConnection.getConnection();

            String sql = "INSERT INTO feedback(user_email, message, rating) VALUES (?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, f.getUserEmail());
            ps.setString(2, f.getMessage());
            ps.setInt(3, f.getRating());

            status = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }
    public List<Feedback> getAllFeedback(){

        List<Feedback> list = new ArrayList<>();

        try{
            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM feedback";
            PreparedStatement ps = con.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                Feedback f = new Feedback();

                f.setUserEmail(rs.getString("user_email"));
                f.setMessage(rs.getString("message"));
                f.setRating(rs.getInt("rating"));

                list.add(f);
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return list;
    }
}
