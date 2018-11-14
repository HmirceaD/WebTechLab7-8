package com.mirceadan.serv;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

public class Serv  extends HttpServlet {

    final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    final String DB_URL="jdbc:mysql://localhost/TEST";

    static final String USER = "root";
    static final String PASS = "password";

    public void init(){

    }

    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {

        resp.setContentType("text/html");

        PrintWriter out = resp.getWriter();

        out.print("<!DOCTYPE html>\n" +
                "<html lang=\"en\">\n" +
                "<head>\n" +
                "    <meta charset=\"UTF-8\">\n" +
                "    <title>Title</title>\n" +
                "</head>\n" +
                "<body>\n" +
                "    <form>\n" +
                "        First name:<br>\n" +
                "       <input type=\"text\" name=\"firstname\"><br>\n" +
                "        Last name:<br>\n" +
                "        <input type=\"text\" name=\"lastname\"><br>\n" +
                "        Username:<br>\n" +
                "        <input type=\"text\" name=\"username\"><br>\n" +
                "        Password:<br>\n" +
                "        <input pattern=\".{6,}\" type=\"password\" name=\"pass\" required ><br>\n" +
                "        Re-Pass:<br>\n" +
                "        <input pattern=\".{6,}\" type=\"password\" name=\"repass\" required><br>\n" +
                "        Address:<br>\n" +
                "        <input type=\"text\" name=\"addr\"><br>\n" +
                "        Email:<br>\n" +
                "        <input type=\"email\" name=\"eml\"><br>\n" +
                "        Interests<br>\n" +
                "        <textarea rows=\"4\" cols=\"50\" name =\"alea\"></textarea><br>\n" +
                "\n" +
                "        <br>\n" +
                "        <button type=\"reset\" value=\"res\">Reset</button>\n" +
                "        <button type=\"submit\" value=\"sub\">Submit</button>\n" +
                "    </form>\n" +
                "</body>\n" +
                "</html>");

                getParams(req);

    }

    private void getParams(HttpServletRequest req) {

        if((req.getParameter("firstname") != null && !req.getParameter("firstname").equals(""))
        &&(req.getParameter("lastname") != null && !req.getParameter("lastname").equals(""))
                &&(req.getParameter("username") != null && !req.getParameter("username").equals(""))
                &&(req.getParameter("pass") != null && !req.getParameter("pass").equals(""))
                &&(req.getParameter("repass") != null && !req.getParameter("repass").equals(""))
                &&(req.getParameter("addr") != null && !req.getParameter("addr").equals(""))
                &&(req.getParameter("eml") != null && !req.getParameter("eml").equals(""))
                &&(req.getParameter("alea") != null && !req.getParameter("alea").equals(""))
        ){

            String firstName = req.getParameter("firstname");
            String lastname = req.getParameter("lastname");
            String username = req.getParameter("username");
            String pass = req.getParameter("pass");
            String repass = req.getParameter("repass");
            String addr = req.getParameter("addr");
            String eml = req.getParameter("eml");
            String alea = req.getParameter("alea");


            try {
                addToDatabase(firstName, lastname, username, pass, addr, eml, alea);

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
    }

    public void addToDatabase(String firstName, String lastname,
                              String username, String pass,
                              String addr, String eml, String alea) throws ClassNotFoundException,
            SQLException, IllegalAccessException, InstantiationException {

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
    }

    public void destroy(){

    }
}