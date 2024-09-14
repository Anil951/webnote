<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>

<style>
    #historypage {
        width: 100%; /* Ensure the container takes up the available width */
        overflow-x: hidden; /* Prevent horizontal scroll */
    }

    table {
        width: 70%; /* Make the table take up the full width of the container */
        table-layout: fixed; /* Force table columns to a fixed width */
        border-collapse: collapse;
        margin-left:auto;
        margin-right:auto;
    }

    th, td {
        padding: 10px;
        border: 1px solid white;
        text-align: left;
        word-wrap: break-word; /* Ensure long text wraps within the cells */
        overflow-wrap: break-word; /* Break long text if necessary */
    }
    th{
    	background-color:skyblue;
    	color:black;s
    }
   

</style>

<div id="historypage">
<%
	Cookie[] cookies = request.getCookies();
	String name = "";
	if (cookies != null) {
	    for (Cookie cookie : cookies) {
	        if ("username".equals(cookie.getName())) {
	            name = cookie.getValue();
	            break;
	        }
	    }
	}

    String filename = request.getParameter("filename");

    if (filename != null && !filename.isEmpty()) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project?useUnicode=true&characterEncoding=UTF-8", "anil", "anil");

            String query = String.format("SELECT * FROM %s ORDER BY timestamp DESC;", filename);
            Statement st = con.createStatement();
            ResultSet rs1 = st.executeQuery(query);

            // Display the results in a table
            out.println("<table>");
            out.println("<thead>");
            out.println("<tr><th>Filename</th><th>Note</th></tr>");
            out.println("</thead>");
            out.println("<tbody>");
            while (rs1.next()) {
                out.println("<tr>");
                out.println("<td>" + rs1.getString("filename") + "</td>");
                out.println("<td>" + rs1.getString("note") + "</td>");
                out.println("</tr>");
            }
            out.println("</tbody>");
            out.println("</table>");

            rs1.close();
            st.close();
            con.close();
        } catch (Exception e) {
            out.println("Error retrieving history: " + e.getMessage());
        }
    } else {
        out.println("No filename provided.");
    }
%>
</div>
