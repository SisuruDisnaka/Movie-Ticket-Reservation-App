package com.CartAndPayment.model;

import javax.servlet.ServletContext;
import java.util.Date;

public class payment {
    private String username;
    private double amount;
    private String bank;
    private String referenceId;
    private Date paymentDate;

    public payment(String username, double amount, String bank, String referenceId) {
        this.username = username;
        this.amount = amount;
        this.bank = bank;
        this.referenceId = referenceId;
        this.paymentDate = new Date();
    }

    public payment(ServletContext context) {
    }


    public String getUsername() {
        return username;
    }

    public double getAmount() {
        return amount;
    }

    public String getBank() {
        return bank;
    }

    public String getReferenceId() {
        return referenceId;
    }

    public Date getPaymentDate() {
        return paymentDate;
    }

    @Override
    public String toString() {
        return "User: " + username +
                ", Amount: " + amount +
                ", bank: " + bank +
                ", referenceid: " + referenceId +
                ", Date: " + paymentDate;
    }
}