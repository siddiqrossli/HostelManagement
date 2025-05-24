package controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

//@WebServlet("/RequestMaintenanceServlet")
public class RequestMaintenanceServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String desc = request.getParameter("description");
        HttpSession session = request.getSession();
        String studentId = (String) session.getAttribute("studentId");

        // Save maintenance request to DB

        response.sendRedirect("dashboard.jsp");
    }
}
