package controller;

import model.Bill;
import java.io.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

//@WebServlet("/ViewBillServlet")
public class ViewBillServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession();
        String studentId = (String) session.getAttribute("studentId");

        // Normally you'd retrieve this from DB
        List<Bill> bills = new ArrayList<>();
        Bill bill = new Bill();
        bill.setBillId("B1001");
        bill.setStudentId(studentId);
        bill.setDate("2025-05-20");
        bill.setAmount(150.00);
        bill.setStatus("Paid");
        bills.add(bill);

        request.setAttribute("bills", bills);
        RequestDispatcher rd = request.getRequestDispatcher("bill.jsp");
        rd.forward(request, response);
    }
}
