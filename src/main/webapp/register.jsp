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
		String namee = request.getParameter("namee");
		String password = request.getParameter("password");
		String phone = request.getParameter("phone");
		String mail = request.getParameter("mail");
		String dob = request.getParameter("dob");
		String gender = request.getParameter("gender");
		String address = request.getParameter("address");
		String image = request.getParameter("photodata");
		

		Class.forName("com.mysql.jdbc.Driver");

		Connection con = DriverManager.getConnection(

		"jdbc:mysql://localhost:3306/project?characterEncoding=latin1", "anil", "anil");

		//here project is database name, root is anil and anil

		Statement stmt = con.createStatement();
		

		String r1 = String.format("select count(*) from formdetails where username='%s'", namee);
		PreparedStatement pst = con.prepareStatement(r1);
		ResultSet rs = pst.executeQuery();
		
		rs.next();
		String Countrow = rs.getString(1);
		System.out.println(Countrow);
		
		if(Countrow.equals("0")){
			int i = stmt.executeUpdate("insert into formdetails(username,password,phone,email,dob,gender,address,image) values('"+namee+"','"+password+"','"+phone+"','"+mail+"','"+dob+"','"+gender+"','"+address+"','"+image+"');");
			out.println("data inserted successfully");
			
			String r2 = String.format("create table %s(id int not null auto_increment,filename varchar(255),note text,primary key (id));",namee);
			stmt.executeUpdate(r2);
			%>
			<script>
		
			a=confirm("now login and continue")
			if(a==true) location.replace('/kb_project_2/main.html');
		
			</script>
			<%
		}
		else{%>
			<script>
			alert("username already exists");
			location.replace('/kb_project_2/main.html');
			</script>
			
		 <% }
		

		con.close();

	} catch (Exception e) {
		System.out.println(e);
	}
	%>
</body>
</html>