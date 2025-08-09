package com.pahana.bookshop.model;

import java.util.ArrayList;
import java.util.List;

public class Cart {
    private List<CartItem> items = new ArrayList<>();

    public void addItem(CartItem item) {
        for (CartItem existing : items) {
            if (existing.getBook().getId() == item.getBook().getId()) {
                existing.setQuantity(existing.getQuantity() + item.getQuantity());
                return;
            }
        }
        items.add(item);
    }

    public List<CartItem> getItems() {
        return items;
    }
}
