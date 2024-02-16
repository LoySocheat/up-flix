import 'package:flutter/material.dart';
import '../models/movie.dart';
import '../screens/member_screen.dart';
import '../api/api.dart';
import '../screens/profile_screen.dart';
import '../widgets/search_list.dart';
import '../widgets/trending_movies.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../widgets/movies_slider.dart';
// import '../widgets/trending_slider.dart';
// import '../screens/details_screen.dart';
// import 'package:up_flix/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Movie>> trendingMovies;
  late Future<List<Movie>> topRatedMovies;
  late Future<List<Movie>> upcomingMovies;
  bool isHovering = false;

  int _currentIndex = 0;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    trendingMovies = Apis().getTrendingMovies();
    topRatedMovies = Apis().getTopRatedMovies();
    upcomingMovies = Apis().getNowPlayingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentIndex == 0) {
          return true;
        } else {
          _onNavItemTapped(1);
          return false;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Image.asset(
            'assets/up_flix.png',
            fit: BoxFit.cover,
            height: 90,
            filterQuality: FilterQuality.high,
          ),
          centerTitle: true,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text('LOY Socheat'),
                accountEmail: Text('loysocheat.up@gmail.com'),
                currentAccountPicture: MouseRegion(
                  onEnter: (_) {
                    setState(() {
                      isHovering = true;
                    });
                  },
                  onExit: (_) {
                    setState(() {
                      isHovering = false;
                    });
                  },
                  child: GestureDetector(
                    onTap: () {
                      print('Upload image');
                    },
                    child: Stack(
                      children: [
                        const SizedBox(
                          width: 64,
                          height: 64,
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/socheat.jpg'),
                          ),
                        ),
                        if (isHovering)
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withOpacity(0.5),
                              ),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://cdn.hero.page/pfp/e81f1f48-5dd7-4682-8798-b5d3b5cd4069-mysterious-gentleman-anime-guy-pfp-styles-1.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                  _onNavItemTapped(0);
                },
              ),
              ListTile(
                leading: Icon(Icons.search),
                title: Text('Search'),
                onTap: () {
                  Navigator.pop(context);
                  _onNavItemTapped(1);
                },
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Profile'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.group),
                title: Text('Members'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MemberScreen()),
                  );
                },
              ),
            ],
          ),
        ),
        body: _buildBody(),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.white,
          currentIndex: _currentIndex,
          onTap: (index) {
            if (index == 0) {
              _onNavItemTapped(0);
            } else if (index == 1) {
              _onNavItemTapped(1);
            } else if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            } else if (index == 3) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MemberScreen()),
              );
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group),
              label: 'Members',
            ),
          ],
        ),
      ),
    );
  }

  void _onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        break;
      case 1:
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MemberScreen()),
        );
        break;
      default:
    }
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return _buildTrendingMovies();
      case 1:
        return buildSearchScreen(upcomingMovies, trendingMovies, topRatedMovies, _searchQuery, _updateSearchQuery, context);
      default:
        return Container();
    }
  }

  Widget _buildTrendingMovies() {
    return TrendingMoviesWidget(
      trendingMovies: trendingMovies,
      topRatedMovies: topRatedMovies,
      upcomingMovies: upcomingMovies,
    );
  }
  void _updateSearchQuery(String query) {
    setState(() {
      _searchQuery = query;
    });
  }
  // Widget _buildTrendingMovies() {
  //   return SingleChildScrollView(
  //     physics: const BouncingScrollPhysics(),
  //     child: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             'Trending Movies',
  //             style: GoogleFonts.aBeeZee(fontSize: 25),
  //           ),
  //           const SizedBox(height: 32),
  //           SizedBox(
  //             child: FutureBuilder(
  //               future: trendingMovies,
  //               builder: (context, snapshot) {
  //                 if (snapshot.hasError) {
  //                   return Center(
  //                     child: Text(snapshot.error.toString()),
  //                   );
  //                 } else if (snapshot.hasData) {
  //                   return TrendingSlider(
  //                     snapshot: snapshot,
  //                   );
  //                 } else {
  //                   return const Center(child: CircularProgressIndicator());
  //                 }
  //               },
  //             ),
  //           ),
  //           const SizedBox(height: 32),
  //           Text(
  //             'Top rated movies',
  //             style: GoogleFonts.aBeeZee(
  //               fontSize: 25,
  //             ),
  //           ),
  //           const SizedBox(height: 32),
  //           GestureDetector(
  //             child: FutureBuilder(
  //               future: topRatedMovies,
  //               builder: (context, snapshot) {
  //                 if (snapshot.hasError) {
  //                   return Center(
  //                     child: Text(snapshot.error.toString()),
  //                   );
  //                 } else if (snapshot.hasData) {
  //                   return MoviesSlider(
  //                     snapshot: snapshot,
  //                   );
  //                 } else {
  //                   return const Center(child: CircularProgressIndicator());
  //                 }
  //               },
  //             ),
  //           ),
  //           const SizedBox(height: 32),
  //           Text(
  //             'Upcoming movies',
  //             style: GoogleFonts.aBeeZee(
  //               fontSize: 25,
  //             ),
  //           ),
  //           const SizedBox(height: 32),
  //           SizedBox(
  //             child: FutureBuilder(
  //               future: upcomingMovies,
  //               builder: (context, snapshot) {
  //                 if (snapshot.hasError) {
  //                   return Center(
  //                     child: Text(snapshot.error.toString()),
  //                   );
  //                 } else if (snapshot.hasData) {
  //                   return MoviesSlider(
  //                     snapshot: snapshot,
  //                   );
  //                 } else {
  //                   return const Center(child: CircularProgressIndicator());
  //                 }
  //               },
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

}
