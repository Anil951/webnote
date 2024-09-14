<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
    String filename = request.getParameter("filename");
    String username = "";
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("username")) {
                username = cookie.getValue();
                break;
            }
        }
    }

    if (filename != null && !filename.isEmpty() && !username.isEmpty()) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/project?characterEncoding=utf8", "anil", "anil");

            // Drop the table
            String dropTableQuery = "DROP TABLE IF EXISTS " + filename;
            pstmt = conn.prepareStatement(dropTableQuery);
            pstmt.executeUpdate();

            out.println("success");
        } catch (Exception e) {
            out.println("error: " + e.getMessage());
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
            if (conn != null) try { conn.close(); } catch (SQLException e) {}
        }
    } else {
        out.println("error: Invalid parameters");
    }
%>