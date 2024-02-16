import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/movie.dart';
import '../screens/details_screen.dart';
import '../constants.dart';

Widget buildSearchScreen(Future<List<Movie>> upcomingMovies, Future<List<Movie>> trendingMovies,
    Future<List<Movie>> topRatedMovies, String searchQuery, Function(String) updateSearchQuery, BuildContext context) {
  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            onChanged: updateSearchQuery,
            decoration: const InputDecoration(
              labelText: 'Search',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          const SizedBox(height: 16),
          FutureBuilder<List<List<Movie>>>(
            future: Future.wait([upcomingMovies, trendingMovies, topRatedMovies]),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else if (snapshot.hasData) {
                List<Movie> allMovies =
                    snapshot.data!.expand((list) => list).toList();
                List<Movie> searchResults = allMovies
                    .where((movie) => movie.title
                        .toLowerCase()
                        .contains(searchQuery.toLowerCase()))
                    .toList();

                return GridView.builder(
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 0.5,
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: searchResults.length,
                  itemBuilder: (context, index) {
                    Movie movie = searchResults[index];
                    return Card(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsScreen(
                                movie: movie,
                              ),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Column(
                            children: [
                              Image.network(
                                '${Constants.imagePath}${movie.posterPath}',
                                height: 250.0,
                                fit: BoxFit.cover,
                              ),
                              ListTile(
                                title: Tooltip(
                                  message: movie.title,
                                  child: Text(
                                    movie.title.length > 15
                                        ? '${movie.title.substring(0, 15)}...'
                                        : movie.title,
                                    style: GoogleFonts.openSans(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          const SizedBox(height: 40),
        ],
      ),
    ),
  );
}
