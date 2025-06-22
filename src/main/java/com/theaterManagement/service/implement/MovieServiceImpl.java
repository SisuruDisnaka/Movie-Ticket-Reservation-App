package com.theaterManagement.service.implement;

import com.theaterManagement.model.Theater;
import com.theaterManagement.service.MovieService;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class MovieServiceImpl implements MovieService {
    private List<Theater> movies;

    public MovieServiceImpl() {
        initializeMovies();
    }

    private void initializeMovies() {
        movies = new ArrayList<>();
        // Sample data matching your JSPs
        movies.add(new Theater("1", "Oppenheimer", "(A)", 180,
                LocalDate.of(2023, 5, 1), "English", "Thriller/Historical drama",
                "Cillian Murphy, Emily Blunt, Matt Damon", true, "", 4.5));

        movies.add(new Theater("2", "A Tale of Redemption", "", 121,
                LocalDate.now(), "English", "Action/Drama",
                "Actor 1, Actor 2", true, "", 4.5));

        // Add other movies from your JSP
    }

    @Override
    public List<Theater> getAllMovies() {
        return new ArrayList<>(movies);
    }

    @Override
    public List<Theater> getNowShowing() {
        List<Theater> nowShowing = new ArrayList<>();
        for (Theater movie : movies) {
            if (movie.isNowShowing()) {
                nowShowing.add(movie);
            }
        }
        return nowShowing;
    }

    @Override
    public List<Theater> getComingSoon() {
        List<Theater> comingSoon = new ArrayList<>();
        for (Theater movie : movies) {
            if (!movie.isNowShowing()) {
                comingSoon.add(movie);
            }
        }
        return comingSoon;
    }

    @Override
    public Theater getMovieById(String id) {
        for (Theater movie : movies) {
            if (movie.getId().equals(id)) {
                return movie;
            }
        }
        return null;
    }
}