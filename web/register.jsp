<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%-- ADD THIS LINE for JSTL --%>
<html>
<head>
    <title>Student Registration</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0; /* Reset default margin */
            background-color: #f4f4f4; /* Light background color */
            display: flex;
            justify-content: center; /* Center horizontally */
            align-items: center;   /* Center vertically */
            min-height: 100vh;     /* Full viewport height */
        }
        .container {
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1); /* Subtle shadow */
            width: 100%;
            max-width: 550px; /* Adjusted max-width for more fields */
            box-sizing: border-box; /* Include padding and border in the element's total width and height */
        }
        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 25px;
        }
        .form-group {
            margin-bottom: 15px;
            display: flex; /* Use flex for alignment */
            align-items: center; /* Vertically align label and input */
        }
        label {
            flex: 0 0 180px; /* Fixed width for labels */
            padding-right: 15px; /* Space between label and input */
            font-weight: bold;
            color: #555;
            text-align: right; /* Align label text to the right */
        }
        input[type="text"],
        input[type="password"],
        input[type="number"],
        select {
            flex: 1; /* Input takes remaining space */
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
            box-sizing: border-box; /* Include padding and border in the element's total width and height */
        }
        .button-group {
            text-align: center;
            margin-top: 25px;
        }
        button[type="submit"] {
            padding: 10px 25px;
            background-color: #007bff; /* Primary blue button */
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 17px;
            transition: background-color 0.3s ease;
        }
        button[type="submit"]:hover {
            background-color: #0056b3; /* Darker blue on hover */
        }
        .error-message {
            color: #d8000c; /* Dark red text */
            background-color: #ffbaba; /* Light red background */
            border: 1px solid #d8000c;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 4px;
            text-align: center;
        }
        .success-message {
            color: #155724; /* Dark green text */
            background-color: #d4edda; /* Light green background */
            border: 1px solid #c3e6cb;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 4px;
            text-align: center;
        }
        p.login-link {
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Student Registration</h2>

    <%-- Show error message if set --%>
    <c:if test="${not empty requestScope.error}">
        <div class="error-message">${requestScope.error}</div>
    </c:if>
    <%-- Show success message if set --%>
    <c:if test="${not empty requestScope.message}">
        <div class="success-message">${requestScope.message}</div>
    </c:if>

    <form action="RegisterServlet" method="post"> <%-- Ensure action matches your servlet mapping --%>
        <div class="form-group">
            <label for="studentId">Student ID:</label>
            <input type="text" name="studentId" id="studentId" required />
        </div>
        <div class="form-group">
            <label for="password">Password:</label>
            <input type="password" name="password" id="password" required />
        </div>
        <div class="form-group">
            <label for="name">Full Name:</label>
            <input type="text" name="name" id="name" required />
        </div>
        <div class="form-group">
            <label for="phone">Phone:</label>
            <input type="text" name="phone" id="phone" required />
        </div>
        <div class="form-group">
            <label for="emergencyContact">Emergency Contact:</label>
            <input type="text" name="emergencyContact" id="emergencyContact" required />
        </div>
        <div class="form-group">
            <label for="semester">Semester:</label>
            <input type="number" name="semester" id="semester" required min="1" /> <%-- Added min attribute --%>
        </div>
        <div class="form-group">
            <label for="cgpa">CGPA:</label>
            <input type="text" name="cgpa" id="cgpa" required pattern="[0-4](\.\d{1,2})?" title="Please enter a valid CGPA (e.g., 3.50)" /> <%-- Added pattern for CGPA --%>
        </div>
        <div class="form-group">
            <label for="houseIncome">Household Income (RM):</label>
            <input type="text" name="houseIncome" id="houseIncome" required pattern="[0-9]+" title="Please enter a numeric value" /> <%-- Added pattern for numeric income --%>
        </div>
        <div class="form-group">
            <label for="gender">Gender:</label>
            <select name="gender" id="gender" required>
                <option value="">--Select Gender--</option> <%-- Added default option --%>
                <option value="Male">Male</option>
                <option value="Female">Female</option>
            </select>
        </div>

        <div class="button-group">
            <button type="submit">Register</button>
        </div>
    </form>
    <p class="login-link"><a href="login.jsp">Already have an account? Login here.</a></p>
</div>

</body>
</html>