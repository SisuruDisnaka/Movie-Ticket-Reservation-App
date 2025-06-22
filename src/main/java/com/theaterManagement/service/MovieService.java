package com.theaterManagement.service;

import com.theaterManagement.model.Theater;
import java.util.List;

public interface MovieService {
    List<Theater> getAllMovies();
    List<Theater> getNowShowing();
    List<Theater> getComingSoon();
    Theater getMovieById(String id);
}