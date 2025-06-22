package com.CartAndPayment.model;
public class product {
    private String itemName;
    private int price;

    public product(String itemName, int price) {
        this.itemName = itemName;
        this.price = price;
    }

    public String getItemName() {
        return itemName;
    }

    public int getPrice() {
        return price;
    }
}


