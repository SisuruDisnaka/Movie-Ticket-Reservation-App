package com.theaterManagement.model;

import java.io.*;
import java.util.*;

public class BookedSeats {
    // Key is in format "movie:date:time:theater"
    private Map<String, Set<String>> bookedSeatsMap;
    private final String seatsFilePath;
    
    public BookedSeats(String filePath) {
        this.seatsFilePath = filePath;
        this.bookedSeatsMap = new HashMap<>();
        loadBookedSeats();
    }
    
    // Load booked seats from file
    private void loadBookedSeats() {
        File file = new File(seatsFilePath);
        if (!file.exists()) {
            try {
                file.getParentFile().mkdirs();
                file.createNewFile();
            } catch (IOException e) {
                e.printStackTrace();
            }
            return;
        }
        
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                if (line.trim().isEmpty()) continue;
                
                String[] parts = line.split("\\|");
                if (parts.length >= 2) {
                    String key = parts[0].trim();
                    String[] seats = parts[1].split(",");
                    
                    Set<String> seatSet = new HashSet<>();
                    for (String seat : seats) {
                        seatSet.add(seat.trim());
                    }
                    
                    bookedSeatsMap.put(key, seatSet);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    
    // Save booked seats to file
    public void saveBookedSeats() {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(seatsFilePath))) {
            for (Map.Entry<String, Set<String>> entry : bookedSeatsMap.entrySet()) {
                if (!entry.getValue().isEmpty()) {
                    writer.write(entry.getKey() + " | " + String.join(",", entry.getValue()));
                    writer.newLine();
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    
    // Check if a seat is booked
    public boolean isSeatBooked(String movie, String date, String time, String theater, String seat) {
        String key = getKey(movie, date, time, theater);
        Set<String> seats = bookedSeatsMap.get(key);
        return seats != null && seats.contains(seat);
    }
    
    // Get all booked seats for a specific showing
    public Set<String> getBookedSeats(String movie, String date, String time, String theater) {
        String key = getKey(movie, date, time, theater);
        Set<String> seats = bookedSeatsMap.get(key);
        return seats != null ? new HashSet<>(seats) : new HashSet<>();
    }
    
    // Book seats for a specific showing
    public void bookSeats(String movie, String date, String time, String theater, Set<String> seats) {
        String key = getKey(movie, date, time, theater);
        Set<String> bookedSeats = bookedSeatsMap.getOrDefault(key, new HashSet<>());
        bookedSeats.addAll(seats);
        bookedSeatsMap.put(key, bookedSeats);
        saveBookedSeats();
    }
    
    // Book seats for a specific showing (array version)
    public void bookSeats(String movie, String date, String time, String theater, String[] seats) {
        Set<String> seatSet = new HashSet<>(Arrays.asList(seats));
        bookSeats(movie, date, time, theater, seatSet);
    }
    
    // Book a single seat
    public void bookSeat(String movie, String date, String time, String theater, String seat) {
        String key = getKey(movie, date, time, theater);
        Set<String> bookedSeats = bookedSeatsMap.getOrDefault(key, new HashSet<>());
        bookedSeats.add(seat);
        bookedSeatsMap.put(key, bookedSeats);
        saveBookedSeats();
    }
    
    // Create a key for the seats map
    private String getKey(String movie, String date, String time, String theater) {
        return movie + ":" + date + ":" + time + ":" + theater;
    }
} 