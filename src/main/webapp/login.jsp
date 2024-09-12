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
	String username = request.getParameter("username");
	String passwordd = request.getParameter("passwordd");
	try {

		Class.forName("com.mysql.jdbc.Driver");

		Connection con = DriverManager.getConnection(

		"jdbc:mysql://localhost:3306/project?characterEncoding=latin1", "anil", "anil");

		//here project is database name, root is anil and anil

		//PreparedStatement pst = con.prepareStatement("Select username,password from formdetails where username=? and password=?");
		//pst.setString(1, username);
		//pst.setString(2, passwordd);
		//ResultSet rs = pst.executeQuery();
		
		Statement st = con.createStatement();
		String s = String.format("Select username,password from formdetails where username='%s' and password='%s'", username,passwordd);
		ResultSet rs = st.executeQuery(s);

		if (rs.next()) {
			Cookie c1 = new Cookie("username", username);
			response.addCookie(c1);
	%>
	<script>
		a = confirm("welcome")
		if (a == true)
			location.replace('/kb_project_2/webnote.jsp');
		else
			location.replace('/kb_project_2/main.html');
	</script>
	<%
	} 
		else {
	%>
	<script>
		alert('invalid credentials')
		location.replace('/kb_project_2/main.html');
	
		
	</script>
	<%
	}
	
	con.close();
	}

	catch (Exception e) {
	System.out.println(e);
	}
	%>

</body>
</html>