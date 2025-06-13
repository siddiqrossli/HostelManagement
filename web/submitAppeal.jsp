<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Submit Appeal</title>
</head>
<body>
    <h2>Merit Not Enough</h2>
    <p><strong>Name:</strong> ${studName}</p>
    <p><strong>ID:</strong> ${studentId}</p>
    <p><strong>Phone Number:</strong> ${studNumber}</p>
    <p><strong>CGPA:</strong> ${studCGPA}</p>
    <p><strong>Total Merit:</strong> ${totalMerit}</p>

    <form action="SubmitAppealServlet" method="post">
        <label for="appealReason">Reason for Appeal:</label><br>
        <textarea name="appealReason" rows="4" cols="50" required></textarea><br><br>
        <input type="submit" value="Submit Appeal">
    </form>
</body>
</html>
