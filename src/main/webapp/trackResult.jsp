<%@ page import="com.courier.model.Courier" %>

<%
Courier c = (Courier) request.getAttribute("courier");
%>

<!DOCTYPE html>
<html>
<head>
<title>Tracking Result</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

</head>
<body>

<div class="container mt-5">
    <h2 class="text-center mb-4">Tracking Result</h2>

    <% if(c != null){ %>

    <div class="card shadow p-4">
  <h5 class="text-success">Courier Found</h5>      
        <hr>

        <p><b>Tracking No:</b> <%= c.getTrackingNumber() %></p>
        <p><b>Name:</b> <%= c.getReceiverName() %></p>
        <p><b>Address:</b> <%= c.getReceiverAddress() %></p>
        <p><b>Phone:</b> <%= c.getReceiverPhone() %></p>
        <p><b>Weight:</b> <%= c.getWeight() %> kg</p>
        <p><b>Amount:</b>&#8377; <%= c.getAmount() %> 
        <p><b>Status:</b> <span class="badge bg-success"><%= c.getStatus() %></span></p>
    </div>

    <% } else { %>

    <div class="alert alert-danger">
        ❌ Courier not found!
    </div>

    <% } %>

</div>

</body>
</html>