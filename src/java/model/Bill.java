package model;

public class Bill {
    private String billId;
    private String studentId;
    private String date;
    private double amount;
    private String status;

    public Bill() {}

    public String getBillId() { return billId; }
    public void setBillId(String billId) { this.billId = billId; }

    public String getStudentId() { return studentId; }
    public void setStudentId(String studentId) { this.studentId = studentId; }

    public String getDate() { return date; }
    public void setDate(String date) { this.date = date; }

    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
