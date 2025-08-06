package com.pahana.bookshop.service;

public class ServiceFactory {
    private static ServiceFactory instance;
    
    private ServiceFactory() {}
    
    public static synchronized ServiceFactory getInstance() {
        if (instance == null) {
            instance = new ServiceFactory();
        }
        return instance;
    }
    
    public UserService createUserService() {
        return new UserService();
    }
    
    public BookService createBookService() {
        return new BookService();
    }
    
    public OrderService createOrderService() {
        return new OrderService();
    }
    
    public CustomerService createCustomerService() {
        return new CustomerService();
    }
}