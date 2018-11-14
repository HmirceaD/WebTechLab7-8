<%@ page import="java.sql.*" %><%--
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
    Search name:<br>
    <input type="text" name="search"><br>

    <input type="radio" name="sr" value="exact"> Exact search<br>
    <input type="radio" name="sr" value="cont"> Containing <br>

    <button type="submit" value="sub">Submit</button>

    <%try {

        String search_val = request.getParameter("search");
        String exact_val = request.getParameter("sr");

        final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
        final String DB_URL="jdbc:mysql://localhost/TEST";

        final String USER = "root";
        final String PASS = "password";

        Class.forName("com.mysql.jdbc.Driver").newInstance();

        Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);

        Statement stmt = conn.createStatement() ;
        String query;
        if(exact_val.equals("exact")){
          query = String.format("select * from people WHERE lastname = %s", search_val);

        }else{
          query = "select * from people WHERE lastname LIKE %" + search_val+"%";
        }

        ResultSet rs = stmt.executeQuery(query) ;

        String name;
        while(rs.next()){
            name = rs.getString("firstname");
          out.println(String.format("<h1>THIS IS THE NAME %s</h1>", name));
        }





    } catch (ClassNotFoundException e) {
      e.printStackTrace();
    } catch (SQLException e) {
      e.printStackTrace();
    } catch (IllegalAccessException e) {
      e.printStackTrace();
    } catch (InstantiationException e) {
      e.printStackTrace();
    }%>
  </form>
</body>
</html>
