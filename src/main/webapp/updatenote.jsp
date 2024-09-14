<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
    String filename = request.getParameter("filename");
    String noteContent = request.getParameter("note");
    String name = ""; // You'll need to get this from the session or cookie

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project?characterEncoding=latin1", "anil", "anil");
        
        // Find the correct table
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT TABLE_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'connectto' AND TABLE_SCHEMA = 'project'");
        
        while (rs.next()) {
            String tableName = rs.getString("TABLE_NAME");
            PreparedStatement pstmt = con.prepareStatement("UPDATE " + tableName + " SET note = ? WHERE filename = ? AND connectto = ?");
            pstmt.setString(1, noteContent);
            pstmt.setString(2, filename);
            pstmt.setString(3, name);
            int result = pstmt.executeUpdate();
            
            if (result > 0) {
                out.print("success");
                return;
            }
        }
        
        out.print("failure");
    } catch (Exception e) {
        out.print("error: " + e.getMessage());
    }
%>