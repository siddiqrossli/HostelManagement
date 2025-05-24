<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Register</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .container {
            width: 500px;
            margin: 50px auto;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: inline-block;
            width: 180px;
        }
        input, select {
            width: 250px;
            padding: 5px;
        }
        .submit-button {
            margin-left: 180px;
            padding: 8px 16px;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Student Registration</h2>
    <form action="RegisterServlet" method="post">
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
            <input type="number" name="semester" id="semester" required />
        </div>
        <div class="form-group">
            <label for="cgpa">CGPA:</label>
            <input type="text" name="cgpa" id="cgpa" required />
        </div>
        <div class="form-group">
            <label for="houseIncome">Household Income:</label>
            <input type="text" name="houseIncome" id="houseIncome" required />
        </div>
        <div class="form-group">
            <label for="gender">Gender:</label>
            <select name="gender" id="gender">
                <option value="Male">Male</option>
                <option value="Female">Female</option>
            </select>
        </div>
        <!-- Uncomment the line below if needed -->
        <!-- <div class="form-group">
            <label for="roomId">Room ID:</label>
            <input type="text" name="roomId" id="roomId" />
        </div> -->
        <div class="form-group">
            <button type="submit" class="submit-button">Register</button>
        </div>
    </form>
</div>

</body>
</html>
