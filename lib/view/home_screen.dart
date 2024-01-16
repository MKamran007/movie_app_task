import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app_task/view_models/home/home_view_model.dart';

import '../data/response/status.dart';
import '../res/routes/routes_names.dart';
import '../utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeViewModel = Get.put(HomeViewModel());

  @override
  void initState() {
    homeViewModel.fetchMoviesListApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blue,
          title: Text(
            'Movies',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.05, // Responsive font size
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, RouteName.favoriteScreen);
          },
          backgroundColor: Colors.blue, // Set the background color
          foregroundColor: Colors.white, // Set the text/icon color
          elevation: 4.0, // Set the elevation
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          child: const Text('Favorite'), // Set the shape
        ),
          body: Obx(() {
          switch (homeViewModel.rxRequestStatus.value) {
            case Status.LOADING:
              return const Center(child: CircularProgressIndicator());
            case Status.ERROR:
              return const Center(child: Text('Something went wrong'));
            case Status.COMPLETE:
              return ListView.builder(
                itemCount: homeViewModel.movieList.value.movies!.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Image.network(
                        homeViewModel.movieList.value.movies![index].posterurl.toString(),
                        errorBuilder: (context, error, stack) {
                          return const Icon(Icons.error, color: Colors.red);
                        },
                        height: screenHeight * 0.07, // Responsive height
                        width: screenWidth * 0.18, // Responsive width
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        homeViewModel.movieList.value.movies![index].title.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(fontSize: screenWidth * 0.04), // Responsive font size
                      ),
                      subtitle: Text(
                        homeViewModel.movieList.value.movies![index].year.toString(),
                        style: TextStyle(fontSize: screenWidth * 0.03), // Responsive font size
                      ),
                      trailing: Obx(
                            () => Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              Utils.averageRatting(homeViewModel.movieList.value.movies![index].ratings!).toStringAsFixed(1),
                              style: TextStyle(fontSize: screenWidth * 0.04), // Responsive font size
                            ),
                            const Icon(Icons.star, color: Colors.yellow),
                            IconButton(
                              onPressed: () {
                                if (homeViewModel.favoriteMovieList.contains(homeViewModel.movieList.value.movies![index].id)) {
                                  homeViewModel.removeFromFavourite(homeViewModel.movieList.value.movies![index].id);
                                } else {
                                  homeViewModel.addToFavourite(homeViewModel.movieList.value.movies![index].id);
                                }
                              },
                              icon: Icon(
                                Icons.favorite,
                                color: homeViewModel.favoriteMovieList.contains(homeViewModel.movieList.value.movies![index].id) ? Colors.red : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
          }
        }),
      ),
    );
  }
}
