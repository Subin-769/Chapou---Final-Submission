package com.chapou.controller;

import com.chapou.model.ContactModel;
import com.chapou.service.ContactService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/contact")
public class ContactController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final ContactService contactService = new ContactService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/Pages/Contact.jsp").forward(req, resp); 
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String name = req.getParameter("name");
            String email = req.getParameter("email");
            String phone = req.getParameter("phone");
            String message = req.getParameter("message");

            // Basic validation
            if (name == null || email == null || phone == null || message == null ||
                name.isEmpty() || email.isEmpty() || phone.isEmpty() || message.isEmpty()) {
                req.setAttribute("error", "All fields are required.");
                req.getRequestDispatcher("/WEB-INF/Pages/Contact.jsp").forward(req, resp);
                return;
            }

            ContactModel contact = new ContactModel();
            contact.setName(name);
            contact.setEmail(email);
            contact.setPhoneNumber(phone);
            contact.setMessage(message);

            boolean isSaved = contactService.saveContact(contact);

            if (isSaved) {
                req.setAttribute("success", "Message sent successfully!");
            } else {
                req.setAttribute("error", "Failed to send message. Try again later.");
            }

            req.getRequestDispatcher("/WEB-INF/Pages/Contact.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Unexpected error occurred. Please try again.");
            req.getRequestDispatcher("/WEB-INF/Pages/Contact.jsp").forward(req, resp);
        }
    }
}
