package com.movieManage;

public class Movie {
    private String title;
    private String director;
    private String mainCharacter;
    private String imagePath;
    private String[] showingDates;
    private String[] timeSlots;
    private String[] screens;
    private double pricePremium;
    private double priceBoutique;
    private double priceStandard;

    // Constructor with basic fields
    public Movie(String title, String imagePath) {
        this.title = title;
        this.imagePath = imagePath;
    }

    // Full constructor
    public Movie(String title, String director, String mainCharacter, 
                 String imagePath, String[] showingDates, String[] timeSlots, String[] screens,
                 double pricePremium, double priceBoutique, double priceStandard) {
        this.title = title;
        this.director = director;
        this.mainCharacter = mainCharacter;
        this.imagePath = imagePath;
        this.showingDates = showingDates;
        this.timeSlots = timeSlots;
        this.screens = screens;
        this.pricePremium = pricePremium;
        this.priceBoutique = priceBoutique;
        this.priceStandard = priceStandard;
    }

    // Getters and Setters
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDirector() {
        return director;
    }

    public void setDirector(String director) {
        this.director = director;
    }

    public String getMainCharacter() {
        return mainCharacter;
    }

    public void setMainCharacter(String mainCharacter) {
        this.mainCharacter = mainCharacter;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }
    
    public String[] getShowingDates() {
        return showingDates;
    }

    public void setShowingDates(String[] showingDates) {
        this.showingDates = showingDates;
    }

    public String[] getTimeSlots() {
        return timeSlots;
    }

    public void setTimeSlots(String[] timeSlots) {
        this.timeSlots = timeSlots;
    }

    public String[] getScreens() {
        return screens;
    }

    public void setScreens(String[] screens) {
        this.screens = screens;
    }

    public double getPricePremium() {
        return pricePremium;
    }

    public void setPricePremium(double pricePremium) {
        this.pricePremium = pricePremium;
    }

    public double getPriceBoutique() {
        return priceBoutique;
    }

    public void setPriceBoutique(double priceBoutique) {
        this.priceBoutique = priceBoutique;
    }

    public double getPriceStandard() {
        return priceStandard;
    }

    public void setPriceStandard(double priceStandard) {
        this.priceStandard = priceStandard;
    }

    // Helper method to convert to CSV format
    public String toCsvString() {
        return String.join(",",
                title,
                director != null ? director : "",
                mainCharacter != null ? mainCharacter : "",
                imagePath.replace("movie-images/", ""),
                showingDates != null ? String.join(",", showingDates) : "",
                timeSlots != null ? String.join(",", timeSlots) : "",
                screens != null ? String.join(",", screens) : "",
                String.valueOf(pricePremium),
                String.valueOf(priceBoutique),
                String.valueOf(priceStandard)
        );
    }
}
