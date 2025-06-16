<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Apply for College</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #fff1f5;
            margin: 0;
            padding: 40px;
        }
        .container {
            max-width: 700px;
            margin: auto;
            background-color: #ffffff;
            border-radius: 16px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            padding: 30px;
        }
        h2, h3 {
            color: #8b0000;
            margin-top: 0;
        }
        p {
            font-size: 16px;
            margin: 10px 0;
        }
        label {
            font-weight: bold;
        }
        textarea {
            width: 100%;
            border: 1px solid #ccc;
            border-radius: 10px;
            padding: 10px;
            resize: vertical;
            font-size: 14px;
        }
        .btn {
            background-color: #8b0000;
            color: white;
            border: none;
            padding: 10px 24px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
        }
        .btn:hover {
            background-color: #600000;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Student Information</h2>
        <p><strong>Name:</strong> ${name}</p>
        <p><strong>ID:</strong> ${studentId}</p>
        <p><strong>Phone Number:</strong> ${phone}</p>
        <p><strong>Merit:</strong> ${merit}</p>
        <hr>
        <c:if test="${merit lt 5.5}">
            <h3>Your merit is below 5.5. Please submit an appeal.</h3>
            <form action="SubmitAppealServlet" method="post">
                <label for="appealReason">Appeal Reason:</label><br>
                <textarea name="appealReason" rows="4" required></textarea><br><br>
                <button type="submit" class="btn">Submit Appeal</button>
            </form>
        </c:if>
    </div>
</body>
</html>
