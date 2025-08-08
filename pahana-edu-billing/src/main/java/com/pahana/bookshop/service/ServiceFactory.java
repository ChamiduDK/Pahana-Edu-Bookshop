package com.pahana.bookshop.service;

import com.pahana.bookshop.dao.CustomerDAO;

public class ServiceFactory {
    private static ServiceFactory instance;

    private ServiceFactory() {}

    public static ServiceFactory getInstance() {
        if (instance == null) {
            instance = new ServiceFactory();
        }
        return instance;
    }

    public UserService createUserService() {
        return new UserService();
    }

    public CustomerService createCustomerService() {
        return new CustomerService(new CustomerDAO());
    }

    public BookService createBookService() {
        return new BookService();
    }

    public OrderService createOrderService() {
        return new OrderService();
    }
}