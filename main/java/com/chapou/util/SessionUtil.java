package com.chapou.util;

import com.chapou.model.ProfileModel;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

/**
 * Utility class for managing HTTP sessions in the Chapou web application.
 */
public class SessionUtil {

    private static final String USER_SESSION_KEY = "currentUser";

    /**
     * Stores a generic attribute in the session.
     */
    public static void setAttribute(HttpServletRequest request, String key, Object value) {
        HttpSession session = request.getSession();
        session.setAttribute(key, value);
    }

    /**
     * Retrieves a generic attribute from the session.
     */
    public static Object getAttribute(HttpServletRequest request, String key) {
        HttpSession session = request.getSession(false);
        return (session != null) ? session.getAttribute(key) : null;
    }

    /**
     * Removes a generic attribute from the session.
     */
    public static void removeAttribute(HttpServletRequest request, String key) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.removeAttribute(key);
        }
    }

    /**
     * Invalidates the current session.
     */
    public static void invalidateSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
    }

    public static void storeLoggedInUser(HttpServletRequest request, ProfileModel user) {
        HttpSession session = request.getSession();
        session.setAttribute(USER_SESSION_KEY, user);
    }

    /**
     * Retrieves the logged-in user from the session.
     */
    public static ProfileModel getLoggedInUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return (session != null) ? (ProfileModel) session.getAttribute(USER_SESSION_KEY) : null;
    }

    /**
     * Removes the logged-in user from session.
     */
    public static void removeLoggedInUser(HttpServletRequest request) {
        removeAttribute(request, USER_SESSION_KEY);
    }
}
