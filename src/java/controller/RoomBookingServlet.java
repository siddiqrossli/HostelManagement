package controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

//@WebServlet("/RoomBookingServlet")
public class RoomBookingServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String roomId = request.getParameter("roomId");
        HttpSession session = request.getSession();
        String studentId = (String) session.getAttribute("studentId");

        // Save booking info to DB (roomId, studentId)
        // Booking status = Pending

        response.sendRedirect("dashboard.jsp");
    }
}
