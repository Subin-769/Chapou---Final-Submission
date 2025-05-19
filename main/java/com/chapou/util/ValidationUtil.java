package com.chapou.util;

import java.time.LocalDate;
import java.time.Period;
import java.util.regex.Pattern;
import jakarta.servlet.http.Part;

/**
 * Utility class for input validations in the Chapou system.
 */
public class ValidationUtil {

    public static boolean isNotEmpty(String value) {
        return value != null && !value.trim().isEmpty();
    }

    public static boolean isAlphabetic(String value) {
        return value != null && value.matches("^[a-zA-Z\s]+$");
    }

    public static boolean isAlphanumericStartingWithLetter(String value) {
        return value != null && value.matches("^[a-zA-Z][a-zA-Z0-9]*$");
    }

    public static boolean isValidGender(String value) {
        return value != null && (
            value.equalsIgnoreCase("male") ||
            value.equalsIgnoreCase("female") ||
            value.equalsIgnoreCase("prefer not to say")
        );
    }

    public static boolean isValidEmail(String email) {
        String emailRegex = "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$";
        return email != null && Pattern.matches(emailRegex, email);
    }

    public static boolean isValidPhone(String number) {
        return number != null && number.matches("^(97|98)\\d{8}$");
    }

    public static boolean isValidPassword(String password) {
        String passwordRegex = "^(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$";
        return password != null && password.matches(passwordRegex);
    }

    public static boolean isValidImage(Part imagePart) {
        if (imagePart == null || imagePart.getSubmittedFileName() == null) {
            return false;
        }
        String fileName = imagePart.getSubmittedFileName().toLowerCase();
        return fileName.endsWith(".jpg") || fileName.endsWith(".jpeg") ||
               fileName.endsWith(".png") || fileName.endsWith(".gif");
    }

    public static boolean doPasswordsMatch(String password, String confirmPassword) {
        return password != null && password.equals(confirmPassword);
    }

    public static boolean isAgeAtLeast16(LocalDate dob) {
        if (dob == null) return false;
        return Period.between(dob, LocalDate.now()).getYears() >= 16;
    }

    public static boolean isValidUsername(String username) {
        return isNotEmpty(username) && isAlphanumericStartingWithLetter(username);
    }

    public static boolean isValidFullName(String fullName) {
        return isNotEmpty(fullName) && isAlphabetic(fullName);
    }

    public static boolean isValidDOB(LocalDate dob) {
        return dob != null && isAgeAtLeast16(dob);
    }
}
