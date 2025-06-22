package com.CartAndPayment.service;

import com.CartAndPayment.model.product;
import com.CartAndPayment.model.shopingcart;
import javax.servlet.http.HttpSession;

public class cartservice {
    private static final String CART_SESSION_ATTRIBUTE = "shoppingCart";

    public shopingcart getCart(HttpSession session) {
        shopingcart cart = (shopingcart) session.getAttribute(CART_SESSION_ATTRIBUTE);
        if (cart == null) {
            cart = new shopingcart();
            session.setAttribute(CART_SESSION_ATTRIBUTE, cart);
        }
        return cart;
    }

    public void addToCart(HttpSession session, product product) {
        shopingcart cart = getCart(session);
        cart.addItem(product);
    }

    public void updateCart(HttpSession session, String itemName, int change) {
        shopingcart cart = getCart(session);
        cart.updateItemQuantity(itemName, change);
    }

    public void clearCart(HttpSession session) {
        shopingcart cart = getCart(session);
        cart.clear();
    }
}
