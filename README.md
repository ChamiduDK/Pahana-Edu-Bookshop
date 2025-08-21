Pahana Edu-Bookshop Web-Based Management System

Overview

Pahana Edu, a renowned bookshop in Colombo City, serves hundreds of customers monthly with a legacy of manual customer account and billing management. To enhance efficiency, accuracy, and user experience, a web-based system has been developed using Java 17, MySQL, and Apache Tomcat v9. Built as a Java Maven Project in the Eclipse IDE, this system leverages Git for version control. This README outlines the development plan, implementation details, and usage instructions, showcasing a system that meets all required functionalities while introducing additional features for improved operational efficiency and customer satisfaction.

System Features





Customer Management: Securely manage customer accounts with user-friendly interfaces.



Billing System: Automate billing processes with accuracy, replacing manual methods.



Data Management: Robust storage and retrieval using MySQL for reliable data handling.



Additional Enhancements: Includes features like order tracking and email notifications for improved customer experience.

Development Details





Technologies: Java 17, MySQL, Apache Tomcat v9.



IDE and Build Tool: Eclipse IDE, Maven Project.



Version Control: Git (hosted on GitHub under ChamiduDK/Pahana-Edu-Bookshop).



Deployment: Deployed using Apache Tomcat, with continuous integration via GitHub Actions.

Installation and Setup





Prerequisites:





Java Development Kit (JDK) 17.



MySQL Server.



Apache Tomcat v9.



Maven.



Git.



Clone the Repository:

git clone https://github.com/ChamiduDK/Pahana-Edu-Bookshop.git
cd Pahana-Edu-Bookshop



Configure Database:





Create a MySQL database named pahana_edu.



Import the schema from src/main/resources/db/schema.sql.



Update src/main/resources/application.properties with your MySQL credentials.



Build the Project:

mvn clean install



Deploy to Tomcat:





Copy the generated WAR file from target/ to the Tomcat webapps directory.



Start Tomcat server.



Access the System:





Open a browser and navigate to http://localhost:8080/Pahana-Edu-Bookshop.

Usage





Admin Login: Use credentials configured in the database to access the admin dashboard.



Customer Interface: Customers can register, view order history, and manage billing through the web interface.



Billing: Generate and download invoices directly from the system.

Version Control and Workflow





Repository: Private GitHub repository with branches for feature development (e.g., Front_End_Update, Unit-Test).



CI/CD: Automated builds and tests via GitHub Actions in .github/workflows.



Releases: Latest version v1.0.1 deployed as "Online Billing System Pahana E...".

Contributing





Report issues or suggest features via GitHub Issues.



Submit pull requests with detailed descriptions and tests.

Contact

For support or inquiries, contact the development team at [chamidudhilsahn@gmail.com]

