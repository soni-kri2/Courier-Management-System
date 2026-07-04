package com.courier.servlet;

import java.io.IOException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.courier.dao.CourierDAO;
import com.courier.model.Courier;

@WebServlet("/bookCourier")
public class BookCourierServlet extends HttpServlet {

protected void doPost(HttpServletRequest request, HttpServletResponse response)
throws IOException {

HttpSession session = request.getSession();

String email = (String) session.getAttribute("userEmail");

// 🔐 check login
if(email == null){
    response.sendRedirect("login.jsp");
    return;
}

String receiverName = request.getParameter("receiverName");
String receiverAddress = request.getParameter("receiverAddress");
String receiverPhone = request.getParameter("receiverPhone");
double weight = Double.parseDouble(request.getParameter("weight"));

String tracking = "TRK" + System.currentTimeMillis();

Courier c = new Courier();

c.setTrackingNumber(tracking);
c.setSenderEmail(email);
c.setReceiverName(receiverName);
c.setReceiverAddress(receiverAddress);
c.setReceiverPhone(receiverPhone);
c.setWeight(weight);
c.setStatus("Booked");
c.setAmount(weight * 50 + 100);

CourierDAO dao = new CourierDAO();

if(dao.bookCourier(c)){
response.sendRedirect("dashboard.jsp?msg=Booked Successfully");
}else{
response.sendRedirect("bookCourier.jsp?error=Failed");
}

}
}