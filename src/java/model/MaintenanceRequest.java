package model;

// import java.time.LocalDate; // REMOVE THIS IMPORT
import java.util.Date; // ADD THIS IMPORT

public class MaintenanceRequest {
    private String mainID; // Will be formatted as MATxxx
    private String mainCat;
    private String mainDescription;
    private Date mainDate; // CHANGE TYPE HERE!
    private String mainStatus;

    // Default constructor
    public MaintenanceRequest() {
    }

    // Getters and Setters
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

    public Date getMainDate() { // CHANGE RETURN TYPE HERE!
        return mainDate;
    }

    public void setMainDate(Date mainDate) { // CHANGE PARAMETER TYPE HERE!
        this.mainDate = mainDate;
    }

    public String getMainStatus() {
        return mainStatus;
    }

    public void setMainStatus(String mainStatus) {
        this.mainStatus = mainStatus;
    }
}