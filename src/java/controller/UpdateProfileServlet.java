package controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

//@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        // In real case, update DB with provided details
        HttpSession session = request.getSession();
        session.setAttribute("email", request.getParameter("email"));
        session.setAttribute("phone", request.getParameter("phone"));
        session.setAttribute("name", request.getParameter("name"));
        
        response.sendRedirect("dashboard.jsp");
    }
}
