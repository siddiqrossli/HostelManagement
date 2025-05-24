package controller;

import model.Student;
import model.StudentDAO;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        // Initialize Student object and get parameters
        Student student = new Student();

        // Retrieve form parameters and set to the student object
        String studentId = request.getParameter("studentId");
        if (studentId == null || studentId.trim().isEmpty()) {
            request.setAttribute("error", "Student ID is required.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        student.setStudentId(studentId);

        String password = request.getParameter("password");
        if (password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Password is required.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        student.setPassword(password);

        String name = request.getParameter("name");
        if (name == null || name.trim().isEmpty()) {
            request.setAttribute("error", "Full Name is required.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        student.setName(name);

        String phone = request.getParameter("phone");
        if (phone == null || phone.trim().isEmpty()) {
            request.setAttribute("error", "Phone number is required.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        student.setPhone(phone);

        String emergencyContact = request.getParameter("emergencyContact");
        if (emergencyContact == null || emergencyContact.trim().isEmpty()) {
            request.setAttribute("error", "Emergency contact is required.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        student.setEmergencyContact(emergencyContact);

        String semesterStr = request.getParameter("semester");
        if (semesterStr == null || semesterStr.trim().isEmpty()) {
            request.setAttribute("error", "Semester is required.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        try {
            student.setSemester(Integer.parseInt(semesterStr));
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid semester value.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        String cgpa = request.getParameter("cgpa");
        if (cgpa == null || cgpa.trim().isEmpty()) {
            request.setAttribute("error", "CGPA is required.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        student.setCgpa(cgpa);

        String houseIncome = request.getParameter("houseIncome");
        if (houseIncome == null || houseIncome.trim().isEmpty()) {
            request.setAttribute("error", "Household income is required.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        student.setHouseIncome(houseIncome);

        String gender = request.getParameter("gender");
        if (gender == null || gender.trim().isEmpty()) {
            request.setAttribute("error", "Gender is required.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        student.setGender(gender);

        // Optional: roomId can be null
        String roomId = request.getParameter("roomId");
        if (roomId != null && !roomId.trim().isEmpty()) {
            student.setRoomId(roomId);
        }

        // Use the StudentDAO to save the student to the database
        StudentDAO dao = new StudentDAO();
        dao.addStudent(student);

        // Redirect to login page after successful registration
        response.sendRedirect("login.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.sendRedirect("register.jsp");
    }
}
