package com.pahana.bookshop.model;

import java.sql.Timestamp;

public class Customer {
    private int id;
    private String accountNumber;
    private String name;
    private String address;
    private String telephone;
    private String email;
    private int unitsConsumed;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    
    // Constructors
    public Customer() {
        this.unitsConsumed = 0;
    }
    
    public Customer(String accountNumber, String name, String address, String telephone, String email) {
        this();
        this.accountNumber = accountNumber;
        this.name = name;
        this.address = address;
        this.telephone = telephone;
        this.email = email;
    }
    
    public Customer(int id, String accountNumber, String name, String address, String telephone, String email) {
        this(accountNumber, name, address, telephone, email);
        this.id = id;
    }
    
    // Getters and Setters
    public int getId() { 
        return id; 
    }
    
    public void setId(int id) { 
        this.id = id; 
    }
    
    public String getAccountNumber() { 
        return accountNumber; 
    }
    
    public void setAccountNumber(String accountNumber) { 
        this.accountNumber = accountNumber; 
    }
    
    public String getName() { 
        return name; 
    }
    
    public void setName(String name) { 
        this.name = name; 
    }
    
    public String getAddress() { 
        return address; 
    }
    
    public void setAddress(String address) { 
        this.address = address; 
    }
    
    public String getTelephone() { 
        return telephone; 
    }
    
    public void setTelephone(String telephone) { 
        this.telephone = telephone; 
    }
    
    public String getEmail() { 
        return email; 
    }
    
    public void setEmail(String email) { 
        this.email = email; 
    }
    
    public int getUnitsConsumed() { 
        return unitsConsumed; 
    }
    
    public void setUnitsConsumed(int unitsConsumed) { 
        this.unitsConsumed = unitsConsumed; 
    }
    
    public Timestamp getCreatedAt() { 
        return createdAt; 
    }
    
    public void setCreatedAt(Timestamp createdAt) { 
        this.createdAt = createdAt; 
    }
    
    public Timestamp getUpdatedAt() { 
        return updatedAt; 
    }
    
    public void setUpdatedAt(Timestamp updatedAt) { 
        this.updatedAt = updatedAt; 
    }
    
    // Utility methods
    public boolean isValid() {
        return id > 0 && accountNumber != null && !accountNumber.trim().isEmpty() 
               && name != null && !name.trim().isEmpty();
    }
    
    public String getDisplayName() {
        return name != null ? name : "Unknown Customer";
    }
    
    @Override
    public String toString() {
        return "Customer{" +
                "id=" + id +
                ", accountNumber='" + accountNumber + '\'' +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                '}';
    }
    
    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        Customer customer = (Customer) obj;
        return id == customer.id;
    }
    
    @Override
    public int hashCode() {
        return Integer.hashCode(id);
    }
}