<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.sql.Timestamp" %>



<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>webnote</title>
<link rel="icon" href="https://cdn-icons-png.flaticon.com/512/1686/1686886.png" type="image/x-icon">
</head>
<body>

<%
String note = request.getParameter("note");
String filename = request.getParameter("filename").trim(); // Trim whitespace
Connection con = null;
Statement stmt = null;

try {
    
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
    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project?characterEncoding=latin1", "anil", "anil");
    stmt = con.createStatement();

    // Validate filename to avoid invalid characters in table names
    if (filename.isEmpty()) {
        throw new Exception("filename cannot be empty");
    }

    String uniqueTableName = filename ;

    // Check if the table exists and create it if not
    String checkTable = String.format("SHOW TABLES LIKE '%s'", uniqueTableName);
    ResultSet rs = stmt.executeQuery(checkTable);

    if (!rs.next()) {
        // Create table with unique name
        String createTable = String.format(
            "CREATE TABLE `%s` (" +
            "filename VARCHAR(255), " +
            "note TEXT, " +
            "connectto VARCHAR(255), " +
            "timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP, " +
            "FOREIGN KEY (connectto) REFERENCES formdetails(username)" +
            ")", uniqueTableName); // Wrap table name with backticks
        stmt.executeUpdate(createTable);
    }

    // Get the current timestamp
    Timestamp currentTimestamp = new Timestamp(System.currentTimeMillis());

    // Insert into the newly created table using backticks
    String insertQuery = String.format(
        "INSERT INTO `%s` (filename, note, connectto, timestamp) VALUES ('%s', '%s', '%s', '%s')",
        uniqueTableName, filename, note, name, currentTimestamp.toString());
    stmt.executeUpdate(insertQuery);

%>
    <script>
        alert("Note added");
        location.replace('/kb_project_2/webnote.jsp');
    </script>

<%
} catch (Exception e) {
    e.printStackTrace(); // Print the exception to the console for debugging
%>
    <script>
        alert("Error: <%= e.getMessage() %>");
        location.replace('/kb_project_2/webnote.jsp');
    </script>
<%
} finally {
    try {
        if (stmt != null) stmt.close();
        if (con != null) con.close();
    } catch (SQLException se) {
        se.printStackTrace();
    }
}
%>

</body>
</html>
