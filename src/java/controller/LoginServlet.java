package controller;

import model.Student;
import model.StudentDAO;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String id = request.getParameter("studentId");
        String pass = request.getParameter("password");

        StudentDAO dao = new StudentDAO();
        Student student = dao.getStudentByIdAndPassword(id, pass);

        if (student != null) {
            HttpSession session = request.getSession();
            session.setAttribute("student", student); // or store just ID
            response.sendRedirect("dashboard.jsp");
        } else {
            request.setAttribute("errorMessage", "Invalid credentials");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }
}
