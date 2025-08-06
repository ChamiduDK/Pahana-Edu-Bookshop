package com.pahana.bookshop.util;

import com.pahana.bookshop.model.Order;
import com.pahana.bookshop.model.OrderItem;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;
import java.time.format.DateTimeFormatter;
import java.time.LocalDateTime;

public class EmailUtil {
    // SMTP configuration for Gmail
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String EMAIL_USERNAME = System.getenv("EMAIL_USERNAME") != null 
        ? System.getenv("EMAIL_USERNAME") : "chamidudhilshan@gmail.com";
    private static final String EMAIL_PASSWORD = System.getenv("EMAIL_PASSWORD") != null 
        ? System.getenv("EMAIL_PASSWORD") : "bass lkdn lblg abwj"; // Replace with Gmail App Password
    private static final String COMPANY_NAME = "Pahana Edu Bookshop";

    /**
     * Sends an order confirmation email to the customer.
     * @param order The order object containing customer and order details.
     */
    public void sendOrderConfirmation(Order order) {
        // Validate order and customer email
        if (order == null || order.getCustomer() == null || 
            order.getCustomer().getEmail() == null || order.getCustomer().getEmail().trim().isEmpty()) {
            System.err.println("Cannot send order confirmation: Invalid order or customer email");
            return;
        }

        try {
            Properties props = getEmailProperties();
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(EMAIL_USERNAME, EMAIL_PASSWORD);
                }
            });
            session.setDebug(true); // Enable debug logging for JavaMail

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EMAIL_USERNAME));
            message.setRecipients(Message.RecipientType.TO, 
                InternetAddress.parse(order.getCustomer().getEmail()));
            message.setSubject("Order Confirmation - " + COMPANY_NAME);

            String emailBody = buildOrderConfirmationEmail(order);
            System.out.println("Order confirmation email body: " + emailBody);
            message.setText(emailBody);

            Transport.send(message);
            System.out.println("Order confirmation sent to: " + order.getCustomer().getEmail());
        } catch (MessagingException e) {
            System.err.println("Failed to send order confirmation to: " + order.getCustomer().getEmail());
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("Unexpected error while sending order confirmation to: " + 
                order.getCustomer().getEmail());
            e.printStackTrace();
        }
    }

    /**
     * Sends a bill/invoice email to the customer.
     * @param order The order object containing customer and order details.
     */
    public void sendBillEmail(Order order) {
        // Validate order and customer email
        if (order == null || order.getCustomer() == null || 
            order.getCustomer().getEmail() == null || order.getCustomer().getEmail().trim().isEmpty()) {
            System.err.println("Cannot send bill: Invalid order or customer email");
            return;
        }

        try {
            Properties props = getEmailProperties();
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(EMAIL_USERNAME, EMAIL_PASSWORD);
                }
            });
            session.setDebug(true); // Enable debug logging for JavaMail

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(EMAIL_USERNAME));
            message.setRecipients(Message.RecipientType.TO, 
                InternetAddress.parse(order.getCustomer().getEmail()));
            message.setSubject("Invoice/Bill - Order #" + order.getId() + " - " + COMPANY_NAME);

            String emailBody = buildBillEmail(order);
            System.out.println("Bill email body: " + emailBody);
            message.setText(emailBody);

            Transport.send(message);
            System.out.println("Bill sent to: " + order.getCustomer().getEmail());
        } catch (MessagingException e) {
            System.err.println("Failed to send bill to: " + order.getCustomer().getEmail());
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("Unexpected error while sending bill to: " + 
                order.getCustomer().getEmail());
            e.printStackTrace();
        }
    }

    /**
     * Configures SMTP properties for Gmail.
     * @return Properties object with SMTP settings.
     */
    private Properties getEmailProperties() {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);
        return props;
    }

    /**
     * Builds the email body for the order confirmation email.
     * @param order The order object.
     * @return The formatted email body as a string.
     */
    private String buildOrderConfirmationEmail(Order order) {
        StringBuilder emailBody = new StringBuilder();
        emailBody.append("Dear ").append(order.getCustomer().getName()).append(",\n\n");
        emailBody.append("Thank you for your order with ").append(COMPANY_NAME).append("!\n\n");
        emailBody.append("ORDER CONFIRMATION\n");
        emailBody.append("==================\n\n");
        emailBody.append("Customer Details:\n");
        emailBody.append("Account Number: ").append(order.getCustomer().getAccountNumber()).append("\n");
        emailBody.append("Name: ").append(order.getCustomer().getName()).append("\n");
        emailBody.append("Address: ").append(order.getCustomer().getAddress()).append("\n");
        emailBody.append("Telephone: ").append(order.getCustomer().getTelephone()).append("\n\n");
        emailBody.append("Order Details:\n");
        emailBody.append("Order ID: #").append(order.getId()).append("\n");
        emailBody.append("Order Date: ").append(order.getOrderDate()).append("\n");
        emailBody.append("Status: ").append(order.getStatus()).append("\n");
        emailBody.append("Processed by: ").append(order.getPlacedByUser().getUsername()).append("\n\n");
        emailBody.append("Items Ordered:\n");
        emailBody.append("-".repeat(50)).append("\n");

        for (OrderItem item : order.getOrderItems()) {
            emailBody.append(String.format("%-30s x %d @ $%.2f = $%.2f\n",
                item.getBook().getTitle(),
                item.getQuantity(),
                item.getUnitPrice(),
                item.getSubtotal()));
        }

        emailBody.append("-".repeat(50)).append("\n");
        emailBody.append(String.format("TOTAL AMOUNT: $%.2f\n\n", order.getTotalAmount()));
        emailBody.append("Your order is being processed and you will receive updates via email.\n\n");
        emailBody.append("Thank you for choosing ").append(COMPANY_NAME).append("!\n\n");
        emailBody.append("Best regards,\n");
        emailBody.append("The ").append(COMPANY_NAME).append(" Team\n");
        emailBody.append("Email: ").append(EMAIL_USERNAME).append("\n");

        return emailBody.toString();
    }

    /**
     * Builds the email body for the bill/invoice email.
     * @param order The order object.
     * @return The formatted email body as a string.
     */
    private String buildBillEmail(Order order) {
        StringBuilder emailBody = new StringBuilder();
        emailBody.append("Dear ").append(order.getCustomer().getName()).append(",\n\n");
        emailBody.append("Your order has been delivered successfully!\n");
        emailBody.append("Please find your invoice/bill details below:\n\n");
        emailBody.append("INVOICE/BILL\n");
        emailBody.append("============\n\n");

        // Company Header
        emailBody.append(COMPANY_NAME.toUpperCase()).append("\n");
        emailBody.append("Educational Books & Supplies\n");
        emailBody.append("Email: ").append(EMAIL_USERNAME).append("\n");
        emailBody.append("Date: ").append(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"))).append("\n\n");

        // Customer Details
        emailBody.append("BILL TO:\n");
        emailBody.append("Account: ").append(order.getCustomer().getAccountNumber()).append("\n");
        emailBody.append("Name: ").append(order.getCustomer().getName()).append("\n");
        emailBody.append("Address: ").append(order.getCustomer().getAddress()).append("\n");
        emailBody.append("Telephone: ").append(order.getCustomer().getTelephone()).append("\n\n");

        // Order Information
        emailBody.append("ORDER INFORMATION:\n");
        emailBody.append("Order #: ").append(order.getId()).append("\n");
        emailBody.append("Order Date: ").append(order.getOrderDate()).append("\n");
        emailBody.append("Delivery Date: ").append(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"))).append("\n");
        emailBody.append("Processed by: ").append(order.getPlacedByUser().getUsername()).append("\n\n");

        // Itemized Bill
        emailBody.append("ITEMIZED BILL:\n");
        emailBody.append("=".repeat(70)).append("\n");
        emailBody.append(String.format("%-35s %5s %10s %15s\n", "DESCRIPTION", "QTY", "UNIT PRICE", "TOTAL"));
        emailBody.append("=".repeat(70)).append("\n");

        for (OrderItem item : order.getOrderItems()) {
            emailBody.append(String.format("%-35s %5d $%9.2f $%14.2f\n",
                item.getBook().getTitle().length() > 35 ? 
                    item.getBook().getTitle().substring(0, 32) + "..." : 
                    item.getBook().getTitle(),
                item.getQuantity(),
                item.getUnitPrice(),
                item.getSubtotal()));
        }

        emailBody.append("=".repeat(70)).append("\n");
        emailBody.append(String.format("%51s $%14.2f\n", "TOTAL AMOUNT:", order.getTotalAmount()));
        emailBody.append("=".repeat(70)).append("\n\n");

        // Payment Information
        emailBody.append("PAYMENT INFORMATION:\n");
        emailBody.append("Status: Delivered - Payment Due\n");
        emailBody.append("Payment Terms: Net 30 days\n\n");

        // Footer
        emailBody.append("Thank you for your business!\n");
        emailBody.append("If you have any questions about this bill, please contact us.\n\n");
        emailBody.append("Best regards,\n");
        emailBody.append("The ").append(COMPANY_NAME).append(" Team\n");

        return emailBody.toString();
    }
}