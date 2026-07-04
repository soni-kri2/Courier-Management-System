package com.courier.model;

public class Complaint {

    private String userEmail;
    private String subject;
    private String description;
    private String status; // ✅ ADD THIS

    public String getUserEmail() { 
        return userEmail; 
    }
    public void setUserEmail(String userEmail) { 
        this.userEmail = userEmail; 
    }

    public String getSubject() { 
        return subject; 
    }
    public void setSubject(String subject) { 
        this.subject = subject; 
    }

    public String getDescription() { 
        return description; 
    }
    public void setDescription(String description) { 
        this.description = description; 
    }

    // ✅ IMPORTANT FIX
    public String getStatus() { 
        return status; 
    }

    public void setStatus(String status) { 
        this.status = status; 
    }
}