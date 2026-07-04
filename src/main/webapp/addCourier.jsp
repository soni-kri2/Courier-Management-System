<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="AddCourierServlet" method="post">

Sender Name:
<input type="text" name="sender"><br><br>

Receiver Name:
<input type="text" name="receiver"><br><br>

Source:
<input type="text" name="source"><br><br>

Destination:
<input type="text" name="destination"><br><br>

<input type="submit" value="Add Courier">

</form>
</body>
</html>