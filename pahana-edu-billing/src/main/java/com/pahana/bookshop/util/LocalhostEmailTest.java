package com.pahana.bookshop.util;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

public class LocalhostEmailTest {
    public static void main(String[] args) {
        String smtpHost = "smtp.gmail.com";
        String smtpPort = "587";
        String username = "chamidudhilshan@gmail.com";
        String password = "qazwsx123ED"; // Replace with App Password
        String recipient = "chamidud2003@gmail.com"; // Replace with a valid test email

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", smtpHost);
        props.put("mail.smtp.port", smtpPort);

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });
        session.setDebug(true); // Enable debug output

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipient));
            message.setSubject("Test Email from Localhost");
            message.setText("This is a test email from Pahana Edu Bookshop on localhost.");

            Transport.send(message);
            System.out.println("Test email sent successfully to: " + recipient);
        } catch (MessagingException e) {
            System.err.println("Failed to send test email");
            e.printStackTrace();
        }
    }
}