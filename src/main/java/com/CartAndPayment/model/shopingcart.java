package com.CartAndPayment.model;

import java.util.HashMap;
import java.util.Map;
import java.util.Collection;

public class shopingcart {
    private Map<String, cartitem> items;


    public shopingcart() {
        this.items = new HashMap<>();
    }

    public void addItem(product product) {
        String itemName = product.getItemName();

        if (items.containsKey(itemName)) {
            items.get(itemName).incrementQuantity();
        } else {
            items.put(itemName, new cartitem(product, 1));
        }
    }

    public void removeItem(String itemName) {
        items.remove(itemName);
    }

    public void updateItemQuantity(String itemName, int change) {
        if (items.containsKey(itemName)) {
            cartitem item = items.get(itemName);
            if (change > 0) {
                item.incrementQuantity();
            } else {
                item.decrementQuantity();
                if (item.getQuantity() == 0) {
                    removeItem(itemName);
                }
            }
        }
    }

    public Collection<cartitem> getItems() {
        return items.values();
    }

    public cartitem getItem(String itemName) {
        return items.get(itemName);
    }

    public boolean hasItem(String itemName) {
        return items.containsKey(itemName);
    }

    public int getTotalPrice() {
        return items.values().stream()
                .mapToInt(cartitem::getSubtotal)
                .sum();
    }

    public int getItemCount() {
        return items.values().stream()
                .mapToInt(cartitem::getQuantity)
                .sum();
    }

    public void clear() {
        items.clear();
    }

    public boolean isEmpty() {
        return items.isEmpty();
    }
}