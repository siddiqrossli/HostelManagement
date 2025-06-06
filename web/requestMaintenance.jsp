<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Request Maintenance</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f0f2f5;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-image: url('img/hostel_background.jpg'); /* Use your background image */
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
        }

        .container {
            background-color: rgba(192, 57, 43, 0.9); /* Reddish background with transparency */
            padding: 30px 40px;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.4);
            width: 100%;
            max-width: 800px;
            color: white;
            position: relative;
            box-sizing: border-box;
        }

        h1 {
            text-align: center;
            font-size: 36px;
            margin-bottom: 30px;
            color: white;
        }

        .header-buttons {
            position: absolute;
            top: 20px;
            right: 20px;
        }

        .header-buttons .btn {
            background-color: rgba(255, 255, 255, 0.2);
            color: white;
            border: 1px solid white;
            padding: 8px 15px;
            border-radius: 5px;
            text-decoration: none;
            font-size: 14px;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .header-buttons .btn:hover {
            background-color: white;
            color: #c0392b;
        }

        .info-box, .form-section {
            background-color: rgba(255, 255, 255, 0.15);
            padding: 25px;
            border-radius: 10px;
            margin-bottom: 25px;
            box-shadow: inset 0 0 10px rgba(0,0,0,0.1);
        }

        .info-box h2 {
            font-size: 24px;
            margin-top: 0;
            margin-bottom: 20px;
            text-align: center;
            color: white;
        }

        .info-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            font-size: 18px;
        }

        .info-item span:first-child {
            font-weight: bold;
            flex-basis: 30%;
            text-align: left;
        }

        .info-item span:last-child {
            flex-basis: 65%;
            text-align: right;
        }

        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-size: 18px;
            font-weight: bold;
        }

        .form-group select,
        .form-group textarea {
            width: calc(100% - 20px);
            padding: 10px;
            border: 1px solid rgba(255, 255, 255, 0.3);
            border-radius: 5px;
            background-color: rgba(255, 255, 255, 0.1);
            color: white;
            font-size: 16px;
            box-sizing: border-box;
            resize: vertical;
            min-height: 100px;
        }

        .form-group select option {
            background-color: #c0392b; /* Ensure options are readable */
            color: white;
        }

        .form-group select {
            -webkit-appearance: none;
            -moz-appearance: none;
            appearance: none;
            background-image: url('data:image/svg+xml;utf8,<svg fill="%23FFFFFF" height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg"><path d="M7 10l5 5 5-5z"/><path d="M0 0h24v24H0z" fill="none"/></svg>');
            background-repeat: no-repeat;
            background-position: right 10px center;
            background-size: 20px;
            padding-right: 30px;
        }


        .button-group {
            display: flex;
            justify-content: space-between;
            margin-top: 30px;
        }

        .button-group .btn {
            background-color: rgba(255, 255, 255, 0.1);
            color: white;
            border: 1px solid white;
            padding: 12px 25px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 18px;
            text-decoration: none;
            transition: background-color 0.3s ease, color 0.3s ease;
            flex-grow: 1;
            margin: 0 10px;
            text-align: center;
        }

        .button-group .btn:hover {
            background-color: white;
            color: #c0392b;
        }

        /* Error/Success message styles */
        .message {
            background-color: rgba(255, 255, 255, 0.2);
            color: white;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
            font-weight: bold;
        }
        .error {
            background-color: rgba(255, 0, 0, 0.3);
            border: 1px solid red;
        }
        .success {
            background-color: rgba(0, 255, 0, 0.3);
            border: 1px solid green;
        }

        /* Responsive adjustments */
        @media (max-width: 600px) {
            .container {
                padding: 20px;
                margin: 0 15px;
            }
            h1 {
                font-size: 28px;
            }
            .info-item {
                flex-direction: column;
                align-items: flex-start;
            }
            .info-item span:first-child {
                margin-bottom: 5px;
                flex-basis: auto;
            }
            .info-item span:last-child {
                text-align: left;
                flex-basis: auto;
            }
            .button-group {
                flex-direction: column;
            }
            .button-group .btn {
                margin: 10px 0;
            }
            .header-buttons {
                position: static;
                text-align: right;
                margin-bottom: 20px;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <div class="header-buttons">
        <a href="viewMaintenanceStatus" class="btn">View Status</a>
    </div>

    <h1>Request Maintenance</h1>

    <%-- Display success or error messages --%>
    <c:if test="${not empty requestScope.message}">
        <div class="message ${requestScope.messageType == 'success' ? 'success' : 'error'}">
            ${requestScope.message}
        </div>
    </c:if>

    <div class="info-box">
        <h2>INFO</h2>
        <div class="info-item">
            <span>Name:</span> <span>${requestScope.studentName}</span>
        </div>
        <div class="info-item">
            <span>ID:</span> <span>${requestScope.studentId}</span>
        </div>
        <div class="info-item">
            <span>Phone Number:</span> <span>${requestScope.phoneNumber}</span>
        </div>
        <div class="info-item">
            <span>Room:</span> <span>${requestScope.roomNumber}</span>
        </div>
    </div>

    <form action="requestMaintenance" method="post" class="form-section">
        <div class="form-group">
            <label for="category">Select Issue Category:</label>
            <select id="category" name="category" required>
                <option value="" <c:if test="${empty requestScope.category}">selected</c:if>>-- Select --</option>
                <option value="Plumbing Issue" <c:if test="${requestScope.category eq 'Plumbing Issue'}">selected</c:if>>Plumbing Issue</option>
                <option value="Electrical Issue" <c:if test="${requestScope.category eq 'Electrical Issue'}">selected</c:if>>Electrical Issue</option>
                <option value="Furniture Damage" <c:if test="${requestScope.category eq 'Furniture Damage'}">selected</c:if>>Furniture Damage</option>
                <option value="Air-Conditioning" <c:if test="${requestScope.category eq 'Air-Conditioning'}">selected</c:if>>Air-Conditioning</option>
                <option value="Pest Control" <c:if test="${requestScope.category eq 'Pest Control'}">selected</c:if>>Pest Control</option>
                <option value="Cleaning Services" <c:if test="${requestScope.category eq 'Cleaning Services'}">selected</c:if>>Cleaning Services</option>
                <option value="Other" <c:if test="${requestScope.category eq 'Other'}">selected</c:if>>Other</option>
            </select>
        </div>
        <div class="form-group">
            <label for="details">Maintenance details:</label>
            <textarea id="details" name="details" rows="5" placeholder="Describe the issue in detail..." required>${requestScope.details}</textarea>
        </div>

        <div class="button-group">
            <a href="dashboard.jsp" class="btn">Back</a>
            <button type="submit" class="btn">Submit Report</button>
        </div>
    </form>
</div>

</body>
</html>