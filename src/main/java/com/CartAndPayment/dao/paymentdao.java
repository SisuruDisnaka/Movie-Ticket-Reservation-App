package com.CartAndPayment.dao;

import com.CartAndPayment.model.payment;
import javax.servlet.ServletContext;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;

public class paymentdao {
    private String filePath;

    public paymentdao(ServletContext context) {
        this.filePath = context.getRealPath("/") + "WEB-INF/payment.txt";
    }

    public void savePayment(payment payment) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, true))) {
            writer.write(payment.toString() + "\n");
        }
    }
}

