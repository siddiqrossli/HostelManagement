<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Your Bills</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; }
        .container { max-width: 800px; margin: auto; }
        h2 { text-align: center; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 10px; border: 1px solid #ccc; text-align: center; }
        th { background-color: #007bff; color: white; }
        .no-bill { text-align: center; margin-top: 30px; color: #777; font-style: italic; }
        .pay-button {
            background-color: #28a745; /* Green */
            color: white;
            padding: 8px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
        }
        .pay-button:hover {
            background-color: #218838;
        }
        .message { color: green; text-align: center; margin-top: 10px; }
        .error { color: red; text-align: center; margin-top: 10px; }
    </style>
</head>
<body>
<div class="container">
    <h2>Your Bills</h2>

    <%-- Display success or error messages --%>
    <c:if test="${not empty requestScope.message}">
        <p class="message">${requestScope.message}</p>
    </c:if>
    <c:if test="${not empty requestScope.error}">
        <p class="error">${requestScope.error}</p>
    </c:if>

    <c:choose>
        <c:when test="${empty billList}">
            <p class="no-bill">You have no bill yet.</p>
        </c:when>
        <c:otherwise>
            <table>
                <thead>
                    <tr>
                        <th>Bill Number</th>
                        <th>Bill Name</th>
                        <th>Bill Amount (RM)</th>
                        <th>Bill Status</th>
                        <th>Action</th> <%-- <<< NEW COLUMN HEADER --%>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="bill" items="${billList}">
                        <tr>
                            <td>${bill.billSequencePerStudent}</td>
                            <td>${bill.billName}</td>
                            <td>${bill.billAmount}</td>
                            <td>${bill.paymentStatus}</td>
                            <td>
                                <%-- <<< NEW ACTION COLUMN CONTENT --%>
                                <c:if test="${bill.paymentStatus eq 'Unpaid'}">
                                    <form action="ViewBillServlet" method="post">
                                        <input type="hidden" name="action" value="payBill">
                                        <input type="hidden" name="billNo" value="${bill.billNo}"> <%-- Use the actual DB billNo for update --%>
                                        <button type="submit" class="pay-button">Pay Now</button>
                                    </form>
                                </c:if>
                                <c:if test="${bill.paymentStatus eq 'Paid'}">
                                    Paid
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>