package com.CartAndPayment.service;

import com.CartAndPayment.dao.paymentdao;
import com.CartAndPayment.model.payment;
import javax.servlet.ServletContext;
import java.io.IOException;

public class paymentservice {
    private paymentdao paymentDAO;

    public paymentservice(ServletContext context) {
        this.paymentDAO = new paymentdao(context);
    }

    public void processPayment(String username, String amount, String bank, String referenceId) throws IOException {
        payment payment = new payment(
                username,
                Double.parseDouble(amount),
                bank,
                referenceId
        );

        paymentDAO.savePayment(payment);
    }
}
