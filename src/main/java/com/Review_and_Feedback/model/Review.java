package com.Review_and_Feedback.model;

public class Review {
    private String movieName;
    private int rating;
    private String comment;

    public Review(String movieName, int rating, String comment) {
        this.movieName = movieName;
        this.rating = rating;
        this.comment = comment;
    }

    public String getMovieName() {
        return movieName;
    }

    public int getRating() {
        return rating;
    }

    public String getComment() {
        return comment;
    }

    @Override
    public String toString() {
        return movieName + "," + rating + "," + comment;
    }
}

