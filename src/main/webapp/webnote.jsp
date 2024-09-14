<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.nio.charset.StandardCharsets"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>webnote</title>
<link rel="icon" href="https://cdn-icons-png.flaticon.com/512/1686/1686886.png" type="image/x-icon">
<link href="https://fonts.googleapis.com/css2?family=Roboto+Mono:ital,wght@1,500&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Secular+One&display=swap" rel="stylesheet">
<link rel="stylesheet" href="webnote.css">
<style>
	#notes-container {
	    display: none;
	    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
	    gap: 20px;
	    margin: 20px auto;
	    padding: 0 10px;
	    box-sizing: border-box;
	    max-width: 1200px;
	    justify-content: center;
	    
	}
	@media (min-width: 768px) {
	    #notes-container {
	        grid-template-columns: repeat(auto-fit, minmax(250px, 300px));
	    }
	}
	
	@media (max-width: 1200px) {
	    #notes-container { grid-template-columns: repeat(3, 1fr); }
	}
	
	@media (max-width: 900px) {
	    #notes-container { grid-template-columns: repeat(2, 1fr); }
	}
	
	@media (max-width: 600px) {
	    #notes-container { grid-template-columns: 1fr; }
	}
	

	
	.card {
    position: relative;
    overflow: hidden;
    transition: transform 0.3s ease;
    background-color: white;
	    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
	    padding: 20px;
	    text-align: center;
	    font-family: 'Roboto Mono', monospace;
	    color: black;
	    font-size: 18px;
	    transition: transform 0.2s ease;
	    overflow: hidden;
	    position: relative;
        border: 1px solid black;
        background-color: #fff;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        cursor: pointer;
     
    max-width: 300px;
    
	}

	 .card::before {
	        content: "";
	        position: absolute;
	        top: 0;
	        left: 0;
	        width: 30px;
	        height: 50px;
	        background-color: black;
	        border-left: 2px solid black;
	        clip-path: polygon(0 0, 100% 0, 0 100%);
	        box-shadow: -3px 3px 5px rgba(0, 0, 0, 0.1);
	    }

	.card::after {
	    content: "Click to edit";
	    position: absolute;
	    top: 0;
	    left: 0;
	    right: 0;
	    bottom: 0;
	    background-color: rgba(0, 0, 0, 0.9);
	    color: white;
	    display: flex;
	    justify-content: center;
	    align-items: center;
	    font-family: 'Roboto Mono', monospace;
	    font-size: 1.2em;
	    opacity: 0;
	    transition: opacity 0.3s ease;
	
	}
	
	.card:hover::after {
	    opacity: 1;
	}
	
	.card:hover {
	    transform: scale(1.05);
	}

    .note-preview {
        font-size: 14px;
        color: #555;
        margin-top: 10px;
    }
    #back{
		position: fixed;
		top: 15px;
		width: 10%;
		height: 30px;
		font-family: 'Roboto Mono', monospace;
		font-size: small;
		border: 0px;
		border-radius: 5px;
		border: 0px;
		left: 15px;
	
	}
	#history {
		top: 50px;
	}
	#profile div{
		width: max-content;
		height: max-content;
		margin-top: 190px;
		margin-right: auto;
		margin-left: auto;
		display:flex;
		flex-direction:row;
		gap:30px;
	}
</style>
</head>
<body>

<%
    Cookie[] cookies = request.getCookies();
    String name = "";
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("username")) {
                name = cookie.getValue();
                break;
            }
        }
    }

    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project?characterEncoding=utf8", "anil", "anil");
    

    HashMap<String, String> tableNotesMap = new HashMap<>();
    
    Statement statement = con.createStatement();
    ResultSet resultSet = statement.executeQuery("SELECT TABLE_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'connectto' AND TABLE_SCHEMA = 'project'");

    while (resultSet.next()) {
        String tableName = resultSet.getString("TABLE_NAME");
        
        Statement innerStatement = con.createStatement();
        String query = String.format("SELECT filename, note FROM %s WHERE connectto=?", tableName);
        PreparedStatement pstmt = con.prepareStatement(query);
        pstmt.setString(1, name);
        ResultSet innerResult = pstmt.executeQuery();
        
        while (innerResult.next()) {
            String noteContent = innerResult.getString("note");
            String filenameprev = innerResult.getString("filename");
            tableNotesMap.put(filenameprev, noteContent);
        }
        
        innerResult.close();
        pstmt.close();
        innerStatement.close();
    }
    


	Statement st1 = con.createStatement();
	String p = String.format("select * from formdetails where username='%s';", name);
	ResultSet rs2 = st1.executeQuery(p);
	
	Statement st3 = con.createStatement();
	String s = String.format("select image from formdetails where username='%s';", name);
	ResultSet rs4 = st3.executeQuery(s);
    
   
%>

<div id="head">Web-NOTE <img src="https://cdn-icons-png.flaticon.com/512/1686/1686886.png" height="35px" width="40px" style="transform: translate(7px, 7px);"> </div>

<input type="button" id="logout" value="Logout" onclick="location.replace('/kb_project_2/main.html');">
<input type="button" id="back" value="Home" style="display: none">


<h2 style="color: white;" id="welcome">
    WELCOME <a id="welcomename"><%= name %></a>
</h2>

<h2 style="color: white;" id="mynotes">
    <a id="mynoteslink">my notes</a>
</h2>

<div id="notes-container">
    <% 
    for (String filenameprev : tableNotesMap.keySet()) { 
        String noteContent = tableNotesMap.get(filenameprev);
        String notePreview = noteContent.length() > 50 ? noteContent.substring(0, 50) + "..." : noteContent;
        String encodedContent = URLEncoder.encode(noteContent, StandardCharsets.UTF_8.toString());
    %>
        <div class="card" onclick="editNote('<%= filenameprev %>', '<%= encodedContent %>')" data-filename="<%= filenameprev %>">
		    <strong><%= filenameprev %></strong>
		    <div class="note-preview"><%= notePreview %></div>
		</div>
        
    <% } %>
</div>

<div id="button-container">
    <button id="plus-button">+</button>
</div>

<form id="newform" action="addnote.jsp" method="post">

	<div id="historypage" style="display: none; color: white;">
	    <!-- This will be populated with history from history.jsp -->
	</div>
	
	
		
    <div id="newmain" style="display:none">
    	<input type="button" id="history" value="History">
    	<input type="button" id="delete" value="delete note" style="display: none;" onclick="deleteNote()">
    	
        <input type='text' id="name" name="filename" placeholder="name" onclick="edit()" disabled="disabled">
        <textarea id="note" placeholder="your note" name="note" disabled="disabled"></textarea>
        <input type='button' id="edit" value="edit"> 
        <input type='button' id="download" value="download"> 
        <input type="submit" value="save" id="save" onclick="save()" style="display: none;">
    </div>
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
				</table>
				<%
				}
				%>
			</div>
		</div>
    	
    </form>

<script>
var notesVisible = false;

document.getElementById("mynoteslink").addEventListener("click", function() {
    var notesContainer = document.getElementById("notes-container");
    if (notesVisible) {
        notesContainer.style.display = "none";
        notesVisible = false;
        document.getElementById("history").style.display = "flex";
        document.getElementById("logout").style.display = "flex";
        document.getElementById("button-container").style.display = "flex";
        document.getElementById("welcome").style.display = "block";
        document.getElementById("mynotes").style.display = "block";
        document.getElementById("head").style.display = "flex";
        document.getElementById("back").style.display = "none";
        document.getElementById("newmain").style.display = "none";
    } else {
        notesContainer.style.display = "grid";
        notesVisible = true;
        document.getElementById("newmain").style.display = "none";
        document.getElementById("history").style.display = "none";
        document.getElementById("logout").style.display = "none";
        document.getElementById("button-container").style.display = "none";
        document.getElementById("welcome").style.display = "none";
        document.getElementById("mynotes").style.display = "block";
        document.getElementById("head").style.display = "none";
        document.getElementById("back").style.display = "block";
    }
});

document.getElementById("plus-button").addEventListener("click", function() {
    document.getElementById("newmain").style.display = "flex";
    document.getElementById("button-container").style.display = "none";
    document.getElementById("back").style.display = "block";  
    document.getElementById("logout").style.display = "none";
    document.getElementById("name").disabled = false;
    document.getElementById("note").disabled = false;
    document.getElementById("edit").style.display = "none";
    document.getElementById("history").style.display = "none";
    document.getElementById("save").style.display = "block";
    document.getElementById("name").value = "";
    document.getElementById("note").value = "";

    document.getElementById("welcome").style.display = "none";
    document.getElementById("mynotes").style.display = "block";
    document.getElementById("head").style.display = "none";
});


function save() {
    document.getElementById("note").style.display = "block";
    document.getElementById("save").style.display = "none";
    document.getElementById("edit").style.display = "block";
    document.getElementById("download").style.display = "block";
    document.getElementById("name").disabled = true;
    document.getElementById("note").disabled = true;

    var filename = document.getElementById("name").value;
    var noteContent = document.getElementById("note").value;
    
    fetch('updateNote.jsp', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: 'filename=' + encodeURIComponent(filename) + '&note=' + encodeURIComponent(noteContent)
    })
    .then(response => response.text())
    .then(data => {
        if(data === 'success') {
            alert('Note saved successfully');
            updateNotesContainer(filename, noteContent);
        } else {
            alert('Failed to save note');
        }
    });
}

function updateNotesContainer(filename, noteContent) {
    var notesContainer = document.getElementById("notes-container");
    var existingCard = document.querySelector(`.card[data-filename="${filename}"]`);
    var notePreview = noteContent.length > 50 ? noteContent.substring(0, 50) + "..." : noteContent;
    var encodedContent = encodeURIComponent(noteContent);

    if (existingCard) {
        existingCard.querySelector('strong').textContent = filename;
        existingCard.querySelector('.note-preview').textContent = notePreview;
        existingCard.onclick = function() { editNote(filename, encodedContent); };
    } else {
        var newCard = document.createElement('div');
        newCard.className = 'card';
        newCard.setAttribute('data-filename', filename);
        newCard.onclick = function() { editNote(filename, encodedContent); };
        newCard.innerHTML = `<strong>${filename}</strong><div class="note-preview">${notePreview}</div>`;
        notesContainer.appendChild(newCard);
    }
}

function editNote(filename, encodedContent) {
    document.getElementById("newmain").style.display = "flex";
    document.getElementById("button-container").style.display = "none";
    document.getElementById("back").style.display = "block";
    
    document.getElementById("logout").style.display = "none";
    document.getElementById("notes-container").style.display = "none";
    document.getElementById("mynotes").style.display = "none";
    
    document.getElementById("name").value = filename;
    document.getElementById("note").value = decodeURIComponent(encodedContent.replace(/\+/g, ' '));

    document.getElementById("name").disabled = true;
    document.getElementById("note").disabled = true;
    document.getElementById("edit").style.display = "block";
    document.getElementById("save").style.display = "none";
    document.getElementById("download").style.display = "block";
    
    document.getElementById("history").style.display = "flex";
    document.getElementById("delete").style.display = "flex";
    
    // Set the current filename as a data attribute on the delete button
    document.getElementById("delete").setAttribute('data-filename', filename);
}


document.getElementById("edit").addEventListener("click", function() {
    document.getElementById("save").style.display = "block";
    document.getElementById("edit").style.display = "none";
    document.getElementById("download").style.display = "none";
    document.getElementById("name").disabled = false;
    document.getElementById("note").disabled = false;
});

document.getElementById("download").addEventListener("click", function() {
    var content = document.getElementById("note").value;
    var filename = document.getElementById("name").value;
    var blob = new Blob([content], { type: "text/plain" });
    var a = document.createElement("a");

    if (filename === "") {
        filename = "note";
    }

    a.download = filename + ".txt";
    a.href = URL.createObjectURL(blob);
    a.click();
});


document.getElementById("welcomename").addEventListener("click", function() {
    document.getElementById("history").style.display = "none";
    document.getElementById("logout").style.display = "flex";
    document.getElementById("button-container").style.display = "none";
    document.getElementById("welcome").style.display = "none";
    document.getElementById("mynotes").style.display = "none";
    document.getElementById("head").style.display = "none";
    document.getElementById("back").style.display = "block";        
    document.getElementById("notes-container").style.display = "none";
    document.getElementById("newmain").style.display = "none";
    document.getElementById("history").style.display = "none";
    document.getElementById("historypage").style.display = "none";
    document.getElementById("delete").style.display = "none";
    document.getElementById("profile").style.display = "flex";

});

document.getElementById("back").addEventListener("click", function() {
    document.getElementById("history").style.display = "none";
    document.getElementById("logout").style.display = "flex";
    document.getElementById("button-container").style.display = "flex";
    document.getElementById("welcome").style.display = "block";
    document.getElementById("mynotes").style.display = "block";
    document.getElementById("head").style.display = "flex";
    document.getElementById("back").style.display = "none";        
    document.getElementById("notes-container").style.display = "none";
    document.getElementById("newmain").style.display = "none";
    document.getElementById("history").style.display = "none";
    document.getElementById("historypage").style.display = "none";
    document.getElementById("delete").style.display = "none";
    document.getElementById("profile").style.display = "none";


});

document.addEventListener("DOMContentLoaded", function() {
    document.getElementById("history").addEventListener("click", function() {
        var filename = document.getElementById("name").value;

        if (filename === "") {
            alert("Please enter a filename to view history.");
            return;
        }

        // Send request to JSP page with filename
        fetch('history.jsp?filename=' + encodeURIComponent(filename), {
            method: 'GET',
        })
        .then(response => response.text())
        .then(data => {
            var historyPage = document.getElementById("historypage");
            if (historyPage) {
                historyPage.innerHTML = data; // Set the returned HTML from history.jsp
                historyPage.style.display = "block"; // Show the history page
                document.getElementById("newmain").style.display = "none";
                document.getElementById("logout").style.display = "none";
                document.getElementById("history").style.display = "none";
                document.getElementById("back").style.display = "block";
                document.getElementById("head").style.display = "none";
                document.getElementById("welcome").style.display = "none";
                document.getElementById("delete").style.display = "none";

            } else {
                console.error('History page element not found.');
            }
        })
        .catch(error => {
            console.error('Error fetching history:', error);
        });
    });
});


function deleteNote() {
    var filename = document.getElementById("name").value;
    if (confirm("Are you sure you want to delete this note?")) {
        fetch('delete.jsp?filename=' + encodeURIComponent(filename), {
            method: 'GET',
        })
        .then(response => response.text())
        .then(data => {
            if (data.trim() === 'success') {
                alert('Note deleted successfully');
                // Refresh the page
                window.location.reload();
            } else {
                alert('Failed to delete note: ' + data);
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('An error occurred while deleting the note');
        });
    }
}

</script>

</body>
</html>