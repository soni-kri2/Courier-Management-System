package com.courier.model;

public class Courier {

private String trackingNumber;
private String senderEmail;
private String receiverName;
private String receiverAddress;
private String receiverPhone;
private double weight;
private String status;
private double amount;

public String getTrackingNumber() {
return trackingNumber;
}

public void setTrackingNumber(String trackingNumber) {
this.trackingNumber = trackingNumber;
}

public String getSenderEmail() {
return senderEmail;
}

public void setSenderEmail(String senderEmail) {
this.senderEmail = senderEmail;
}

public String getReceiverName() {
return receiverName;
}

public void setReceiverName(String receiverName) {
this.receiverName = receiverName;
}

public String getReceiverAddress() {
return receiverAddress;
}

public void setReceiverAddress(String receiverAddress) {
this.receiverAddress = receiverAddress;
}

public String getReceiverPhone() {
return receiverPhone;
}

public void setReceiverPhone(String receiverPhone) {
this.receiverPhone = receiverPhone;
}

public double getWeight() {
return weight;
}

public void setWeight(double weight) {
this.weight = weight;
}

public String getStatus() {
return status;
}

public void setStatus(String status) {
this.status = status;
}

public double getAmount() {
return amount;
}

public void setAmount(double amount) {
this.amount = amount;
}
}