<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %><%--
  Created by IntelliJ IDEA.
  User: Mircea
  Date: 13.11.2018
  Time: 10:04
  To change this template use File | Settings | File Templates.
--%>
<%--Lab8--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Title</title>
</head>
<body>
  <form>
    First name:<br>
    <input type="text" name="firstname"><br>
    Last name:<br>
    <input type="text" name="lastname"><br>
    Username:<br>
    <input type="text" name="username"><br>
    Password:<br>
    <input type="password" name="pass"><br>
    Re-Pass:<br>
    <input type="password" name="repass"><br>
    Address:<br>
    <input type="text" name="addr"><br>
    Email:<br>
    <input type="email" name="eml"><br>
    Interests<br>
    <textarea rows="4" cols="50"></textarea><br>

    <br>
    <button type="reset" value="res">Reset</button>
    <button type="submit" value="sub">Submit</button>

    <%
      if((request.getParameter("firstname") != null && !request.getParameter("firstname").equals(""))
              &&(request.getParameter("lastname") != null && !request.getParameter("lastname").equals(""))
              &&(request.getParameter("username") != null && !request.getParameter("username").equals(""))
              &&(request.getParameter("pass") != null && !request.getParameter("pass").equals(""))
              &&(request.getParameter("repass") != null && !request.getParameter("repass").equals(""))
              &&(request.getParameter("addr") != null && !request.getParameter("addr").equals(""))
              &&(request.getParameter("eml") != null && !request.getParameter("eml").equals(""))
              &&(request.getParameter("alea") != null && !request.getParameter("alea").equals(""))
      ){

        String firstName = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");
        String username = request.getParameter("username");
        String pass = request.getParameter("pass");
        String repass = request.getParameter("repass");
        String addr = request.getParameter("addr");
        String eml = request.getParameter("eml");
        String alea = request.getParameter("alea");


        try {
          final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
          final String DB_URL="jdbc:mysql://localhost/TEST";

          final String USER = "root";
          final String PASS = "password";

          Class.forName("com.mysql.jdbc.Driver").newInstance();

          Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);

          String sql = String.format("INSERT INTO " +
                          "people(firstname,lastname,username,pass,addr,eml,alea) " +
                          "VALUES(%s,%s,%s,%s,%s,%s,%s)",
                  firstName, lastname, username,
                  pass, addr, eml, alea);

          PreparedStatement pstmt = conn.prepareStatement(sql);
          pstmt.executeUpdate();

          conn.commit();

        } catch (ClassNotFoundException e) {
          e.printStackTrace();
        } catch (SQLException e) {
          e.printStackTrace();
        } catch (IllegalAccessException e) {
          e.printStackTrace();
        } catch (InstantiationException e) {
          e.printStackTrace();
        }

      }
    %>
  </form>
</body>
</html>
