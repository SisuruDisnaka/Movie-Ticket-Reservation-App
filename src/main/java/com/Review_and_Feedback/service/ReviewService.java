package com.Review_and_Feedback.service;

import com.Review_and_Feedback.model.Review;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class ReviewService {

    private static final String FILE_PATH = "C:\\Users\\rames\\OneDrive\\Desktop\\GitHub\\MovieTicketApp\\src\\main\\webapp\\WEB-INF\\reviews.txt";

    public void saveReview(Review review) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            writer.write(review.toString());
            writer.newLine();
        }
    }

    public boolean deleteReview(Review targetReview) throws IOException {
        File inputFile = new File(FILE_PATH);
        File tempFile = new File(FILE_PATH + ".tmp");
        boolean deleted = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(inputFile));
             BufferedWriter writer = new BufferedWriter(new FileWriter(tempFile))) {

            String line;
            while ((line = reader.readLine()) != null) {
                if (line.trim().equals(targetReview.toString())) {
                    deleted = true;
                    continue;
                }
                writer.write(line);
                writer.newLine();
            }
        }

        if (inputFile.delete()) {
            tempFile.renameTo(inputFile);
        }

        return deleted;
    }

    public boolean updateReview(Review updatedReview) throws IOException {
        File file = new File(FILE_PATH);
        List<String> lines = new ArrayList<>();
        boolean updated = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;

            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",", 3);
                if (parts.length >= 3 && parts[0].equalsIgnoreCase(updatedReview.getMovieName())) {
                    lines.add(updatedReview.toString());
                    updated = true;
                } else {
                    lines.add(line);
                }
            }
        }

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file, false))) {
            for (String l : lines) {
                writer.write(l);
                writer.newLine();
            }
        }

        return updated;
    }

    public List<Review> getReviewsForMovie(String movieName) throws IOException {
        List<Review> reviews = new ArrayList<>();
        File file = new File(FILE_PATH);

        if (file.exists()) {
            try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] parts = line.split(",", 3);
                    if (parts.length >= 3 && parts[0].equalsIgnoreCase(movieName)) {
                        try {
                            int rating = Integer.parseInt(parts[1].trim());
                            reviews.add(new Review(parts[0].trim(), rating, parts[2].trim()));
                        } catch (NumberFormatException ignored) {}
                    }
                }
            }
        }

        return reviews;
    }
}
