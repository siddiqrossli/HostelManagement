<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="model.Bill" %>

<html>
<head><title>My Bills</title></head>
<body>
    <h2>Billing Information</h2>
    <%
        List<Bill> bills = (List<Bill>) request.getAttribute("bills");
        if (bills != null) {
            for (Bill b : bills) {
                out.println("<p>Bill ID: " + b.getBillId() +
                            ", Date: " + b.getDate() +
                            ", Amount: RM" + b.getAmount() +
                            ", Status: " + b.getStatus() + "</p>");
            }
        } else {
            out.println("<p>No bills found.</p>");
        }
    %>
</body>
</html>
