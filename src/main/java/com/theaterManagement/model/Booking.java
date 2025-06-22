package com.theaterManagement.model;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.List;

public class Booking implements Serializable {
    private String id;
    private String userId;
    private String showtimeId;
    private List<String> seats;
    private double totalPrice;
    private LocalDateTime bookingTime;
    private String status;

    public Booking() {
    }

    public Booking(String id, String userId, String showtimeId, List<String> seats,
                   double totalPrice, LocalDateTime bookingTime, String status) {
        this.id = id;
        this.userId = userId;
        this.showtimeId = showtimeId;
        this.seats = seats;
        this.totalPrice = totalPrice;
        this.bookingTime = bookingTime;
        this.status = status;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getShowtimeId() {
        return showtimeId;
    }

    public void setShowtimeId(String showtimeId) {
        this.showtimeId = showtimeId;
    }

    public List<String> getSeats() {
        return seats;
    }

    public void setSeats(List<String> seats) {
        this.seats = seats;
    }
    public String getSeatType() {
        return seats.get(0);
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public LocalDateTime getBookingTime() {
        return bookingTime;
    }

    public void setBookingTime(LocalDateTime bookingTime) {
        this.bookingTime = bookingTime;
    }
    public int[] getNumberOfTickets() {
        return new int[0];
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Booking{" +
                "id='" + id + '\'' +
                ", userId='" + userId + '\'' +
                ", showtimeId='" + showtimeId + '\'' +
                ", seats=" + seats +
                ", totalPrice=" + totalPrice +
                ", bookingTime=" + bookingTime +
                ", status='" + status + '\'' +
                '}';
    }
}
