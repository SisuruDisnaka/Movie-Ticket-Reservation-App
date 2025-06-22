package com.theaterManagement.model;

import java.io.Serializable;
import java.time.LocalDateTime;

public class Showtime implements Serializable  {
    private String id;
    private String movieId;
    private String cinemaName;
    private String screenType;
    private LocalDateTime datetime;
    private double[] prices; // [CLASSIC, PRIME, SUPERIOR]

    public Showtime() {}

    public Showtime(String id, String movieId, String cinemaName, String screenType,
                    LocalDateTime datetime, double[] prices) {
        this.id = id;
        this.movieId = movieId;
        this.cinemaName = cinemaName;
        this.screenType = screenType;
        this.datetime = datetime;
        this.prices = prices;
    }

    // Getters and Setters
    public double[] getPrices() { return prices; }
    public void setPrices(double[] prices) { this.prices = prices; }
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    public String getMovieId() { return movieId; }
    public void setMovieId(String movieId) { this.movieId = movieId; }
    public String getCinemaName() { return cinemaName; }
    public void setCinemaName(String cinemaName) { this.cinemaName = cinemaName; }
    public String getScreenType() { return screenType; }
    public void setScreenType(String screenType) { this.screenType = screenType; }
    public LocalDateTime getDatetime() { return datetime; }
    public void setDatetime(LocalDateTime datetime) { this.datetime = datetime; }

}