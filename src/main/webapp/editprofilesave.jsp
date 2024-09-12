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
	
	Cookie c=null;
	Cookie[] cs=null;
	
	cs = request.getCookies();
	String name = cs[1].getValue();
	try {

		Class.forName("com.mysql.jdbc.Driver");

		Connection con = DriverManager.getConnection(

		"jdbc:mysql://localhost:3306/project?characterEncoding=latin1", "anil", "anil");

		//here project is database name, root is anil and anil

		//PreparedStatement pst = con.prepareStatement("Select username,password from formdetails where username=? and password=?");
		//pst.setString(1, username);
		//pst.setString(2, passwordd);
		//ResultSet rs = pst.executeQuery();
		
		Statement stmt = con.createStatement(); 
		String r1 = String.format("UPDATE formdetails SET username='%s',password = '%s' WHERE username = '%s'",username,passwordd,name);
		stmt.executeUpdate(r1);
		
		Statement st = con.createStatement();
		String s = String.format("Select username,password from formdetails where username='%s' and password='%s'", username,passwordd);
		ResultSet rs = st.executeQuery(s);
		
		String r2 = String.format("alter table %s rename %s",name,username);
		stmt.executeUpdate(r2);
        
		if (rs.next()) {
				c=cs[1];
				c.setMaxAge(0);
				response.addCookie(c);
			
			Cookie c3 = new Cookie("username", username);
			response.addCookie(c3);
	%>
	<script>
		a = alert("details edited")
		location.replace('/kb_project_2/webnote.jsp');
		
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