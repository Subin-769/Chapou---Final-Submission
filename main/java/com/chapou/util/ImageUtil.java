package com.chapou.util;

import java.io.File;
import java.io.IOException;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.Part;

/**
 * Utility class for image upload.
 */
public class ImageUtil {

    public String getImageNameFromPart(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        String imageName = null;

        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                imageName = s.substring(s.indexOf('=') + 2, s.length() - 1);
            }
        }

        return (imageName == null || imageName.isEmpty()) ? "default.png" : imageName;
    }

    public String getSavePath(String rootPath, String folder) {
        return rootPath + File.separator + "Resources" + File.separator + folder;
    }

    public boolean uploadImage(Part part, String savePath) {
        try {
            String imageName = getImageNameFromPart(part);
            File fileSaveDir = new File(savePath);
            if (!fileSaveDir.exists()) fileSaveDir.mkdirs();

            part.write(savePath + File.separator + imageName);
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    

    public static boolean isValidImage(Part part) {
        String name = part.getSubmittedFileName().toLowerCase();
        return name.endsWith(".jpg") || name.endsWith(".jpeg") || name.endsWith(".png") || name.endsWith(".gif");
    }

    public static String getImageName(Part part) {
        String[] segments = part.getSubmittedFileName().split("[" + File.separator + "/]");
        return segments[segments.length - 1];
    }
}
