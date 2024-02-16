import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/movie.dart';
import '../widgets/movies_slider.dart';
import '../widgets/trending_slider.dart';

class TrendingMoviesWidget extends StatelessWidget {
  final Future<List<Movie>> trendingMovies;
  final Future<List<Movie>> topRatedMovies;
  final Future<List<Movie>> upcomingMovies;

  const TrendingMoviesWidget({super.key, 
    required this.trendingMovies,
    required this.topRatedMovies,
    required this.upcomingMovies,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Trending Movies',
              style: GoogleFonts.aBeeZee(fontSize: 25),
            ),
            const SizedBox(height: 32),
            SizedBox(
              child: FutureBuilder(
                future: trendingMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else if (snapshot.hasData) {
                    return TrendingSlider(
                      snapshot: snapshot,
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Top rated movies',
              style: GoogleFonts.aBeeZee(
                fontSize: 25,
              ),
            ),
            const SizedBox(height: 32),
            GestureDetector(
              child: FutureBuilder(
                future: topRatedMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else if (snapshot.hasData) {
                    return MoviesSlider(
                      snapshot: snapshot,
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Upcoming movies',
              style: GoogleFonts.aBeeZee(
                fontSize: 25,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              child: FutureBuilder(
                future: upcomingMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else if (snapshot.hasData) {
                    return MoviesSlider(
                      snapshot: snapshot,
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
