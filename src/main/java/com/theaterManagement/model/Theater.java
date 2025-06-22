package com.theaterManagement.model;

import java.time.LocalDate;

public class Theater {
    private String id;
    private String title;
    private String rating;
    private int duration;
    private String language;
    private String genre;
    private String cast;
    private LocalDate releaseDate;
    private boolean nowShowing;
    private String imageUrl;
    private double ratingScore;

    public Theater() {}

    public Theater(String id, String title, String rating, int duration, LocalDate releaseDate,
                 String language, String genre, String cast, boolean nowShowing,
                 String imageUrl, double ratingScore) {
        this.id = id;
        this.title = title;
        this.rating = rating;
        this.duration = duration;
        this.releaseDate = releaseDate;
        this.language = language;
        this.genre = genre;
        this.cast = cast;
        this.nowShowing = nowShowing;
        this.imageUrl = imageUrl;
        this.ratingScore = ratingScore;
    }

    // Getters and setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getRating() { return rating; }
    public void setRating(String rating) { this.rating = rating; }
    public int getDuration() { return duration; }
    public void setDuration(int duration) { this.duration = duration; }
    public LocalDate getReleaseDate() { return releaseDate; }
    public void setReleaseDate(LocalDate releaseDate) { this.releaseDate = releaseDate; }
    public String getLanguage() { return language; }
    public void setLanguage(String language) { this.language = language; }
    public String getGenre() { return genre; }
    public void setGenre(String genre) { this.genre = genre; }
    public String getCast() { return cast; }
    public void setCast(String cast) { this.cast = cast; }
    public boolean isNowShowing() { return nowShowing; }
    public void setNowShowing(boolean nowShowing) { this.nowShowing = nowShowing; }
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    public double getRatingScore() { return ratingScore; }
    public void setRatingScore(double ratingScore) { this.ratingScore = ratingScore; }
}