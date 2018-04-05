<!-Academic year 2014-2015-->
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>
<%
try {
  //Step 1.- Load Driver
  Class.forName("org.gjt.mm.mysql.Driver");
  String urlDB = "jdbc:mysql://localhost:3306/fakebook";
  // Step 2.- Crete connection
  Connection con = DriverManager.getConnection(
    urlDB,"root", "root");

  // Step 3.- Create select
  PreparedStatement s = con.prepareStatement("SELECT id, name FROM users WHERE email=? AND password=MD5(?)");
  s.setString(1,request.getParameter("email"));
  s.setString(2,request.getParameter("password"));
    
   ResultSet result = s.executeQuery();
  //Step 4.- look into the query
   if(result.next()){
        session.setAttribute("id", result.getString("id"));
        session.setAttribute("name", result.getString("name"));
        %>
        <jsp:forward page="wall.jsp"/>
<%
   }else{
   %>
   <jsp:forward page="index.jsp?message=Invalid user or password"/>
<%
   }
  s.close();
  con.close();
}
catch (ClassNotFoundException e1) {
  // JDBC driver class not found, print error message to the console
  out.println("ERROR 1a: "+e1.toString());
  //end catch
}
catch (SQLException e2) {
  // Exception when executing java.sql related commands, print error message to the console
  out.println("ERROR 2a: "+e2.toString());
  //end catch
}
catch (Exception e3) {
  // other unexpected exception, print error message to the console
  out.println("ERROR 3a: "+e3.toString());
  //end catch
}
%>
