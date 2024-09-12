<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>webnote</title>
<link rel="icon"
	href="https://cdn-icons-png.flaticon.com/512/1686/1686886.png"
	type="image/x-icon">
</head>
<body>

	<%
	try {
		Cookie c[] = request.getCookies();
		String name = c[1].getValue();

		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project?characterEncoding=latin1", "anil","anil");
		Statement stmt = con.createStatement(); 

		String r1 = String.format("truncate %s;", name);
		stmt.executeUpdate(r1);
	
	%>
	<script>
	
		location.replace('/kb_project_2/webnote.jsp');
		
	</script>

	<%
	con.close();

	} catch (Exception e) {
	System.out.println(e);
	}
	%>
</body>
</html>