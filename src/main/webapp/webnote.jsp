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

<link
	href="https://fonts.googleapis.com/css2?family=Roboto+Mono:ital,wght@1,500&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Secular+One&display=swap"
	rel="stylesheet">

<style>
html {
	font-family: 'Roboto Mono', monospace;
	background-color: black;
}

#head {
	position: relative;
	top: 10px;
	font-size: 230%;
	color: white;
	margin-left: auto;
	margin-right: auto;
	margin-bottom: 0px;
	width: fit-content;
	background-color: black;
	font-family: 'Poppins', monospace;
	font-weight: bold;
}

#main {
	display: flex;
	flex-direction: column;
	margin-top: 100px;
	position: relative;
	width: 100%;
	font-family: 'Roboto Mono', monospace;
	background-color: black;
}

#welcome {
	font-family: 'Poppins', monospace;
	padding-left: 20px;
	margin-top: -30px;
	margin-bottom: 30px;
}

#welcomename {
	text-decoration: underline solid skyblue 2px;
	text-underline-offset: 7px;
	cursor: pointer;
}

#welcomename:hover {
	color: skyblue;
}

#name {
	min-width: 5%;
	border: 0px;
	border-radius: 5px;
	width: 15%;
	height: 30px;
	margin-left: auto;
	margin-right: auto;
	margin-bottom: 20px;
	font-family: 'Roboto Mono', monospace;
	text-align: center;
}

#logout, #delete, #history, #back ,#clearhistory,#editdetails,#savedetails{
	position: fixed;
	right: 10px;
	top: 15px;
	width: 10%;
	height: 30px;
	font-family: 'Roboto Mono', monospace;
	font-size: small;
	border: 0px;
	border-radius: 5px;
	border: 0px;
}

#delete,#history ,#clearhistory{
	top: 50px;
}
#editdetails,#savedetails{
	top:85px;
}



#note {
	resize: none;
	height: 200px;
	width: 50%;
	margin-left: auto;
	margin-right: auto;
	margin-bottom: 20px;
	font-family: 'Roboto Mono', monospace;
	text-align: center;
	justify-content: center;
	border: 0px;
	border-radius: 5px;
}

#note::placeholder, #name::placeholder {
	text-align: center;
	justify-content: center;
	margin-top: auto;
	margin-bottom: auto;
	color: black;
}

#note::placeholder {
	padding: 80px;
}

#note:disabled, #name:disabled {
	color: black;
	background-color: rgb(148, 145, 145);
}

#save, #edit, #download {
	width: 15%;
	height: 30px;
	margin-left: 60%;
	margin-right: auto;
	margin-bottom: 10px;
	font-family: 'Roboto Mono', monospace;
	border: 0px;
	border-radius: 5px;
}

#edit:hover, #save:hover, #logout:hover, #history:hover, #back:hover,#editdetails:hover,#savedetails:hover {
	background-color: rgb(0, 0, 0);
	color: white;
	border: 1px solid white;
	transition-duration: 0.5s;
}

#delete:hover {
	background-color: rgb(0, 0, 0);
	color: rgb(240, 98, 98);
	border: 1px solid rgb(240, 98, 98);
	transition-duration: 0.5s;
}

#download:hover,#clearhistory:hover {
	background-color: rgb(0, 0, 0);
	color: lightgreen;
	border: 1px solid lightgreen;
	transition-duration: 0.5s;
}

#historypage {
	width: max-content;
	height: fit-content;
	margin-top: 70px;
	margin-right: auto;
	margin-left: auto;
}

#profile div{
	width: max-content;
	height: max-content;
	margin-top: 150px;
	margin-right: auto;
	margin-left: auto;
	display:flex;
	flex-direction:row;
	gap:30px;
}

table,td, th {
	border:2px 2px 2px 0px solid white;
	border-collapse: collapse;
	padding: 5px;
	padding-left: 40px;
}
#profileimg img{
    position:absolute;
    left:30%;
    top:200px;
	justify-content:center;
	border-radius:50%;
	object-fit:cover;
}

#profiledetails{
	width:fit-content;
	
	position:absolute;
	right:20%;
	
}
td input{
	background-color:black;
	border:0px;
	color:white;
	font-family: 'Roboto Mono', monospace;
	font-size:large;
	width:max-content;
}

</style>
</head>
<body>
	

	<%
	
	Connection connection = null;
	Statement statement = null;
	ResultSet resultSet = null;
	//Reading cookies
	Cookie c[] = request.getCookies();
	String name = c[1].getValue();

	//Displaying User name value from cookie

	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project?characterEncoding=latin1", "anil",
	"anil");

	statement = con.createStatement();
	String sql = "select filename,note from formdetails where username='" + name + "';";
	ResultSet rs = statement.executeQuery(sql);

	Statement st = con.createStatement();
	String r = String.format("select * from %s order by id desc;", name);
	ResultSet rs1 = st.executeQuery(r);

	Statement st2 = con.createStatement();
	String q = String.format("select count(*) from %s;", name);
	ResultSet rs3 = st2.executeQuery(q);

	Statement st1 = con.createStatement();
	String p = String.format("select * from formdetails where username='%s';", name);
	ResultSet rs2 = st1.executeQuery(p);
	
	Statement st3 = con.createStatement();
	String s = String.format("select image from formdetails where username='%s';", name);
	ResultSet rs4 = st3.executeQuery(s);
	try {

		
		
		
	%>

	<div id="head">Web-NOTE<img src="https://cdn-icons-png.flaticon.com/512/1686/1686886.png" height="35px" width="40px" style="transform: translate(7px, 7px);"> </div>

	<input type="button" id="logout" value="Logout" onclick="location.replace('/kb_project_2/main.html');">
		
	

	<input type="button" id="history" value="History">
	<input type="button" id="back" value="Back" style="display: none">

	<form id="deleteform" method="post">
				<input type="submit" value="Delete Account" id="delete" onclick="deletee()" style="display: none;">
	</form>
	
	<h2 style="color: white;" id="welcome">
		WELCOME <a id="welcomename"><%=name%></a>
	</h2>

	

	<form id="saveform" action="save.jsp" method="post">
		

		
		<div id="historypage" style="display: none; color: white;">
			<h2 style="text-align: center; margin-top: -30px;text-decoration: underline solid skyblue 2px;text-underline-offset: 7px;">History</h2>
			<br><br>
			
			<table border=1 style="text-align: center">
				<thead>
					<tr>
						<th width="200px"
							style="color: black; font-size: large; background-color: white; padding: 2px;">Filename</th>
						<th width="400px"
							style="color: black; font-size: large; background-color: white; padding: 2px;">Note</th>
					</tr>
				</thead>
				<tbody>
					<%
					while (rs1.next()) {
					%>
					<tr>
						<td style="border: 1px solid white;"><%=rs1.getString("filename")%></td>
						<td style="border: 1px solid white;"><%=rs1.getString("note")%></td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
		</div>
	
		
		<div id="main">

			<%
			while (rs.next()) {
				if (rs.getString(1) != null && rs.getString(2) != null) {
			%>

			<input type='text' id="name" placeholder="name" name="filename"
				disabled="disabled" value="<%=rs.getString(1)%>" onclick="edit()">
			<textarea id="note" placeholder="your note" name="note"
				disabled="disabled"><%=rs.getString(2)%></textarea>
			<%
			} else {
			%>
			<input type='text' id="name" name="filename" placeholder="name"
				onclick="edit()" disabled="disabled">
			<textarea id="note" placeholder="your note" name="note"
				disabled="disabled"></textarea>
			<%
			}
			}

			}

			catch (Exception exp) {
			System.out.println(exp);
			}
			%>

			<input type='button' id="edit" value="edit"> 
			<input type='button' id="download" value="download"> 
			<input type="submit" value="save" id="save" onclick="save()" style="display: none;">

		</div>
	</form>
    <form action="clearhistory.jsp" method="post">
    	<input type="submit" id="clearhistory" value="Clear History" style="display:none;">
    </form>
    
    <form action="editprofilesave.jsp" method="post">
    <div id="profile" style="display: none; color: white; font-size: large;text-align: start;">
			<h2 style="position:absolute;text-align: center;height:fit-content;width:fit-content;transform: translateX(45vw);text-decoration: underline solid skyblue 2px;text-underline-offset: 7px;">Profile</h2>
			<div id="profileimg">
				<%
				while(rs4.next()){%>
				<img src="<%=rs4.getString(1)%>" onerror="if (this.src!='data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5OjcBCgoKDQwNGg8PGjclHyU3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3N//AABEIAIIAggMBIgACEQEDEQH/xAAbAAEAAgMBAQAAAAAAAAAAAAAABAUBBgcDAv/EADcQAAICAQIDBQYEBAcAAAAAAAABAgMEBRESQVEGEyEiMUJhcYGhsTJSkcEUI0PRBzRTYnLh8f/EABYBAQEBAAAAAAAAAAAAAAAAAAABAv/EABYRAQEBAAAAAAAAAAAAAAAAAAABEf/aAAwDAQACEQMRAD8A7iAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHnbdCqO85Je4i5Wbw7wpa35y6FfJuTcm22+bLIJ9mobPauHzkeLz73+VfBEUFxNSVnXrnF/FHrDUZe3BP4PYggYLinJqt8IvaXRntuUJLxs2VbUbG5Q680TDVoD5hJSinFpp+jPoigAAAAAAABA1DI4f5UH5mvM1yJd9iqqlN8ilk3Jtt7t+pYMAArIB6I13Uu1uJjWOvEreTJes0+GP/AGBsQNUxe2dcppZeJKEfzVz32+TRs+PkVZVMbseyNlcl5ZRA9AAUScPI7qajJ+R/QtigLTT7u8q4JPzQ+xmrqWACKAAAAAK/U57cEF8WQCTqL3ydukURjUQAARrHbXUp0UV4NMtncnKxr14Onz8f095pZe9tN3rkt/TuYbFEUC97IajPE1GONKX8jIfC03+GfJ/t/wCFEeuHv/GUcP4u9jtt13QR1YB+r26gihIwbODIS5S8GRz6re1kH0kgq9QCBlQAAAABU6h/mX/xRGJupw88JrmtiEaiAACNR7dYU26M6EW4pd3Z4enj5X9zUjrNtcLapV2wU65LaUWt00azmdjceyblh5M6U/YnHjS+qYGmFv2XwZZur0vhfdUvvLH029P1Zb09i9p75GdxR6V17fdmyafgY2n4/cYtfDH1bb3cn1bAk77+IAAGYeM4r3owe2JDjyILo9wq5QCBlQAAAAB4ZdXe0NL8S8UU5flXn4/dz7yC8kvX3MsSoh82WQqrlZbJQhFbuUnskjLaS3fovV9Dn/aPW56ne6qZNYkH5Uvbf5n+xpFtqna+MZOvTalPb+rYvD5L+5Q369qt78+bbFdIbRX0K0AT69Z1OqW8M69P3y4vuW+n9r8mpqOfVG6HOcFwy/s/oayAOp4Obj59HfYtinDnycX0a5Eg5fpmoX6blRvx5NfmhymujOkafmVZ+JXk0PyTXo/ZfNP3oCQWOmVeWVr9rwRDx6ZXWKK8FzfRFxCKhFRitkvRGar6ABFAAAAAA+ZxjKLUlun6o+gBqHbevIxNHteLCcoWPhnKP9OHNv7b+85od5kt1satrPYjAz3K3Fl/CXPxbgt4Sfvjy+WxqVLHLwbBndjdZxJPgojkQXtUy3+j8SotwM2l7XYWTW/91Ml+xdZxGB7QxMqyXDDFvk+kapP9iyw+y+tZbXBg2VxftXeRL9fH6DRTm4f4e/xN1+RjxhJ478zsf4YT8PD5r7FlpHYCmpqzVL++f+jVuo/N+r+huWLjVYtMKceuNdcFtGEVskS1ZGaKYUw4Yr4vqeoBloAAAAAAAAAAAAAY2Q2MgAY2RkAY2MgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAf//Z') this.src='data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5OjcBCgoKDQwNGg8PGjclHyU3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3N//AABEIAIIAggMBIgACEQEDEQH/xAAbAAEAAgMBAQAAAAAAAAAAAAAABAUBBgcDAv/EADcQAAICAQIDBQYEBAcAAAAAAAABAgMEBRESQVEGEyEiMUJhcYGhsTJSkcEUI0PRBzRTYnLh8f/EABYBAQEBAAAAAAAAAAAAAAAAAAABAv/EABYRAQEBAAAAAAAAAAAAAAAAAAABEf/aAAwDAQACEQMRAD8A7iAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHnbdCqO85Je4i5Wbw7wpa35y6FfJuTcm22+bLIJ9mobPauHzkeLz73+VfBEUFxNSVnXrnF/FHrDUZe3BP4PYggYLinJqt8IvaXRntuUJLxs2VbUbG5Q680TDVoD5hJSinFpp+jPoigAAAAAAABA1DI4f5UH5mvM1yJd9iqqlN8ilk3Jtt7t+pYMAArIB6I13Uu1uJjWOvEreTJes0+GP/AGBsQNUxe2dcppZeJKEfzVz32+TRs+PkVZVMbseyNlcl5ZRA9AAUScPI7qajJ+R/QtigLTT7u8q4JPzQ+xmrqWACKAAAAAK/U57cEF8WQCTqL3ydukURjUQAARrHbXUp0UV4NMtncnKxr14Onz8f095pZe9tN3rkt/TuYbFEUC97IajPE1GONKX8jIfC03+GfJ/t/wCFEeuHv/GUcP4u9jtt13QR1YB+r26gihIwbODIS5S8GRz6re1kH0kgq9QCBlQAAAABU6h/mX/xRGJupw88JrmtiEaiAACNR7dYU26M6EW4pd3Z4enj5X9zUjrNtcLapV2wU65LaUWt00azmdjceyblh5M6U/YnHjS+qYGmFv2XwZZur0vhfdUvvLH029P1Zb09i9p75GdxR6V17fdmyafgY2n4/cYtfDH1bb3cn1bAk77+IAAGYeM4r3owe2JDjyILo9wq5QCBlQAAAAB4ZdXe0NL8S8UU5flXn4/dz7yC8kvX3MsSoh82WQqrlZbJQhFbuUnskjLaS3fovV9Dn/aPW56ne6qZNYkH5Uvbf5n+xpFtqna+MZOvTalPb+rYvD5L+5Q369qt78+bbFdIbRX0K0AT69Z1OqW8M69P3y4vuW+n9r8mpqOfVG6HOcFwy/s/oayAOp4Obj59HfYtinDnycX0a5Eg5fpmoX6blRvx5NfmhymujOkafmVZ+JXk0PyTXo/ZfNP3oCQWOmVeWVr9rwRDx6ZXWKK8FzfRFxCKhFRitkvRGar6ABFAAAAAA+ZxjKLUlun6o+gBqHbevIxNHteLCcoWPhnKP9OHNv7b+85od5kt1satrPYjAz3K3Fl/CXPxbgt4Sfvjy+WxqVLHLwbBndjdZxJPgojkQXtUy3+j8SotwM2l7XYWTW/91Ml+xdZxGB7QxMqyXDDFvk+kapP9iyw+y+tZbXBg2VxftXeRL9fH6DRTm4f4e/xN1+RjxhJ478zsf4YT8PD5r7FlpHYCmpqzVL++f+jVuo/N+r+huWLjVYtMKceuNdcFtGEVskS1ZGaKYUw4Yr4vqeoBloAAAAAAAAAAAAAY2Q2MgAY2RkAY2MgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAf//Z';" 
				height="200px" width="200px">
			</div>
			<% }%>
			
			<div id="profiledetails">
			<% while (rs2.next()) {	
				%>
				<table >
					<tr>
						<th>Name:</th>
						<td><input type="text" name="username" id="caneditusername" disabled value="<%=rs2.getString("username")%>"></td>
					</tr>
					<tr>
						<th>Password:</th>
						<td><input type="text" name="passwordd" id="caneditpassword" disabled value="<%=rs2.getString("password")%>"></td>
					</tr>
					<tr>
						<th>Phone:</th>
						<td><%=rs2.getString("phone")%></td>
					</tr>
					<tr>
						<th>Mail ID:</th>
						<td><%=rs2.getString("email")%></td>
					</tr>
					<tr>
						<th>DOB:</th>
						<td><%=rs2.getString("dob")%></td>
					</tr>
					<tr>
						<th>Gender:</th>
						<td><%=rs2.getString("gender")%></td>
					</tr>
					<tr>
					<th>edits done:</th>
						<td>
							<%
							while (rs3.next())
							%><%=rs3.getString(1)%> times
						</td>
					</tr>
				</table>
				<%
				}
				%>
			</div>
			<input type="button" value="edit details" id="editdetails">
			<input type="submit" value="save" id="savedetails" style="display:none">
		</div>
    	
    </form>
    

	<script>
		function deletee() {
			let foo = prompt('enter YES to delete account !?');
			if (foo == 'YES') {
				alert('nooooooo')
				document.getElementById("deleteform").action = "delete.jsp";
			} else {
				alert("incorrect match")
			}
		}

		function save() {
			
			document.getElementById("note").style.display = "block";
			document.getElementById("save").style.display = "none";
			document.getElementById("edit").style.display = "block";
			document.getElementById("download").style.display = "block";
			document.getElementById("name").disabled = false;
			document.getElementById("note").disabled = false;
			document.getElementById('download').style.backgroundColor = "white";

		}
		
		document.getElementById("editdetails").addEventListener("click",function(){
			alert('Tap on username and password to edit')
			document.getElementById("savedetails").style.display = "block";
			document.getElementById("editdetails").style.display = "none";
			document.querySelector("#caneditusername").disabled=false;
			document.querySelector("#caneditpassword").disabled=false;
		})
		document.getElementById("savedetails").addEventListener("click",function(){
			
		})
		
		document
				.getElementById("history")
				.addEventListener(
						"click",
						function() {
							document.getElementById("historypage").style.display = "block";
							document.getElementById("main").style.display = "none";
							document.getElementById("logout").style.display = "none";
							document.getElementById("delete").style.display = "none";
							document.getElementById("history").style.display = "none";
							document.getElementById("clearhistory").style.display = "block";
							document.getElementById("back").style.display = "block";
							document.getElementById("profile").style.display = "none";
							document.getElementById("head").style.display = "none";
							document.getElementById("welcomename").style.display = "none";
						})
		document
				.getElementById("welcomename")
				.addEventListener(
						"click",
						function() {
							document.getElementById("historypage").style.display = "none";
							document.getElementById("main").style.display = "none";
							document.getElementById("logout").style.display = "none";
							document.getElementById("delete").style.display = "block";
							document.getElementById("history").style.display = "none";
							document.getElementById("clearhistory").style.display = "none";
							document.getElementById("back").style.display = "block";
							document.getElementById("profile").style.display = "flex";
							document.getElementById("head").style.display = "none";
							document.getElementById("welcomename").style.display = "none";
						})
		document
				.getElementById("back")
				.addEventListener(
						"click",
						function() {
							document.getElementById("historypage").style.display = "none";
							document.getElementById("main").style.display = "flex";
							document.getElementById("logout").style.display = "block";
							document.getElementById("delete").style.display = "none";
							document.getElementById("history").style.display = "block";
							document.getElementById("clearhistory").style.display = "none";
							document.getElementById("back").style.display = "none";
							document.getElementById("profile").style.display = "none";
							document.getElementById("head").style.display = "block";
							document.getElementById("welcomename").style.display = "inline-block";
							document.getElementById("savedetails").style.display = "none";
							document.getElementById("editdetails").style.display = "block";
							document.querySelector("#caneditusername").disabled=true;
							document.querySelector("#caneditpassword").disabled=true;
						})

		document
				.getElementById("edit")
				.addEventListener(
						"click",
						function() {
							document.getElementById("save").style.display = "block";
							document.getElementById("edit").style.display = "none";
							document.getElementById("download").style.display = "none";
							document.getElementById("name").disabled = false;
							document.getElementById("note").disabled = false;
							document.getElementById('download').style.backgroundColor = "white";

						})

		document
				.getElementById("download")
				.addEventListener(
						"click",
						function() {
							var content = document.getElementById("note").value;
							var filename = document.getElementById("name").value;
							var t = new Blob([ content ], {
								type : "text/plain"
							});
							var c = document.createElement("a");
							if (filename.length == 0) {
								c.download = "note.txt";
							} else {
								c.download = filename + ".txt";
							}
							c.href = URL.createObjectURL(t);
							c.click();
							document.getElementById('download').style.backgroundColor = "lightgreen";
						})
	</script>
</body>
</html>