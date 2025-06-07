// In model/MaintenanceRequest.java
package model;

import java.util.Date; // Assuming you have this already

public class MaintenanceRequest {
    private String mainID;
    private String mainCat;
    private String mainDescription;
    private Date mainDate; // Using java.util.Date
    private String mainStatus;
    private String staffID; // Keep if you still need it, though not directly displayed
    private String studentID;
    private String roomID;

    // New fields for staff details
    private String staffName;
    private String staffNumber; // This will map to staffNumber

    // Constructors (if any) and existing getters/setters

    public String getMainID() {
        return mainID;
    }

    public void setMainID(String mainID) {
        this.mainID = mainID;
    }

    public String getMainCat() {
        return mainCat;
    }

    public void setMainCat(String mainCat) {
        this.mainCat = mainCat;
    }

    public String getMainDescription() {
        return mainDescription;
    }

    public void setMainDescription(String mainDescription) {
        this.mainDescription = mainDescription;
    }

    public Date getMainDate() {
        return mainDate;
    }

    public void setMainDate(Date mainDate) {
        this.mainDate = mainDate;
    }

    public String getMainStatus() {
        return mainStatus;
    }

    public void setMainStatus(String mainStatus) {
        this.mainStatus = mainStatus;
    }

    public String getStaffID() {
        return staffID;
    }

    public void setStaffID(String staffID) {
        this.staffID = staffID;
    }

    public String getStudentID() {
        return studentID;
    }

    public void setStudentID(String studentID) {
        this.studentID = studentID;
    }

    public String getRoomID() {
        return roomID;
    }

    public void setRoomID(String roomID) {
        this.roomID = roomID;
    }

    // New getters and setters for staff details
    public String getStaffName() {
        return staffName;
    }

    public void setStaffName(String staffName) {
        this.staffName = staffName;
    }

    public String getStaffNumber() {
        return staffNumber;
    }

    public void setStaffNumber(String staffNumber) {
        this.staffNumber = staffNumber;
    }
}