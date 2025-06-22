package com.theaterManagement.service;

import com.theaterManagement.model.*;
import java.io.*;
import java.nio.file.*;
import java.util.*;
import java.util.stream.*;

public abstract class BookingService {
    private static final String DATA_DIR = System.getProperty("user.dir") + "/src/main/resources/data/";

    // Read movies from file
    public List<Theater> getAllMovies() throws IOException {
        Path path = Paths.get(DATA_DIR + "movies.txt");
        if (!Files.exists(path)) return new ArrayList<>();

        return Files.readAllLines(path).stream()
                .map(line -> {
                    String[] parts = line.split("\\|");
                    Theater m = new Theater();
                    m.setId(parts[0]);
                    m.setTitle(parts[1]);
                    m.setNowShowing(Boolean.parseBoolean(parts[parts.length-1]));
                    return m;
                })
                .collect(Collectors.toList());
    }

    // Save booking to file
    public void saveBooking(Booking booking) throws IOException {
        Path path = Paths.get(DATA_DIR + "bookings.txt");
        String line = String.join("|",
                booking.getId(),
                booking.getShowtimeId(),
                booking.getSeatType(),
                Arrays.toString(booking.getNumberOfTickets()),
                String.valueOf(booking.getTotalPrice())
        );
        Files.write(path, (line + System.lineSeparator()).getBytes(),
                StandardOpenOption.CREATE, StandardOpenOption.APPEND);
    }

    public abstract List<Showtime> getShowtimesForMovie(String movieId);

    public abstract Showtime getShowtime(String showtimeId);

    public abstract Booking createBooking(Booking booking);

    public abstract boolean checkSeatAvailability(String showtimeId, List<String> seats);
}