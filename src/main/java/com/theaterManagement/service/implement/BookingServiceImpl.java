package com.theaterManagement.service.implement;

import com.theaterManagement.model.Booking;
import com.theaterManagement.model.Showtime;
import com.theaterManagement.service.BookingService;
import java.io.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class BookingServiceImpl extends BookingService {

    private static final String BOOKINGS_FILE = "bookings.dat";
    private static final String SHOWTIMES_FILE = "showtimes.dat";

    @Override
    public List<Showtime> getShowtimesForMovie(String movieId) {
        List<Showtime> allShowtimes = loadShowtimes();
        List<Showtime> movieShowtimes = new ArrayList<>();

        for (Showtime showtime : allShowtimes) {
            if (showtime.getMovieId().equals(movieId)) {
                movieShowtimes.add(showtime);
            }
        }
        return movieShowtimes;
    }

    @Override
    public Showtime getShowtime(String showtimeId) {
        List<Showtime> showtimes = loadShowtimes();
        for (Showtime showtime : showtimes) {
            if (showtime.getId().equals(showtimeId)) {
                return showtime;
            }
        }
        return null;
    }

    @Override
    public Booking createBooking(Booking booking) {
        // Generate unique ID for the booking
        booking.setId(UUID.randomUUID().toString());
        booking.setBookingTime(LocalDateTime.now());
        booking.setStatus("CONFIRMED");

        List<Booking> bookings = loadBookings();
        bookings.add(booking);
        saveBookings(bookings);

        return booking;
    }

    @Override
    public boolean checkSeatAvailability(String showtimeId, List<String> seats) {
        // In a real system, this would check against reserved seats
        // For this example, we'll assume all seats are available
        return true;
    }

    // Helper methods for file operations
    private List<Booking> loadBookings() {
        try (ObjectInputStream ois = new ObjectInputStream(
                new FileInputStream(BOOKINGS_FILE))) {
            return (List<Booking>) ois.readObject();
        } catch (FileNotFoundException e) {
            return new ArrayList<>();
        } catch (IOException | ClassNotFoundException e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    private void saveBookings(List<Booking> bookings) {
        try (ObjectOutputStream oos = new ObjectOutputStream(
                new FileOutputStream(BOOKINGS_FILE))) {
            oos.writeObject(bookings);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private List<Showtime> loadShowtimes() {
        try (ObjectInputStream ois = new ObjectInputStream(
                new FileInputStream(SHOWTIMES_FILE))) {
            return (List<Showtime>) ois.readObject();
        } catch (FileNotFoundException e) {
            // Initialize with sample data if file doesn't exist
            return initializeSampleShowtimes();
        } catch (IOException | ClassNotFoundException e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    private List<Showtime> initializeSampleShowtimes() {
        List<Showtime> showtimes = new ArrayList<>();

        // Sample data matching your JSPs
        showtimes.add(new Showtime(
                "1", "1", "PCP Colombo City Center Mall", "PCP LUXURY",
                LocalDateTime.now().withHour(12).withMinute(45),
                new double[]{900, 1100, 1200}
        ));

        showtimes.add(new Showtime(
                "2", "1", "PCP Colombo City Center Mall", "PCP STANDARD",
                LocalDateTime.now().withHour(14).withMinute(15),
                new double[]{800, 1000, 1100}
        ));

        showtimes.add(new Showtime(
                "3", "1", "PCP Cinema", "PCP PREMIUM",
                LocalDateTime.now().withHour(18).withMinute(30),
                new double[]{900, 1100, 1200}
        ));

        // Save the sample data
        try (ObjectOutputStream oos = new ObjectOutputStream(
                new FileOutputStream(SHOWTIMES_FILE))) {
            oos.writeObject(showtimes);
        } catch (IOException e) {
            e.printStackTrace();
        }

        return showtimes;
    }
}