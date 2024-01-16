import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app_task/view_models/home/home_view_model.dart';

import '../utils/utils.dart';

class FavoritesScreen extends StatelessWidget {
  final HomeViewModel homeViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Favorites',
          style: TextStyle(
            fontSize: screenWidth * 0.05, // Responsive font size
          ),
        ),
      ),
      body: Obx(() {
        if (homeViewModel.favoriteMovieList.isEmpty) {
          return const Center(child: Text('No favorites yet.'));
        } else {
          return ListView.builder(
            itemCount: homeViewModel.favoriteMovieList.length,
            itemBuilder: (context, index) {
              final movieId = homeViewModel.favoriteMovieList[index];
              final movie = homeViewModel.movieList.value.movies!.firstWhere((element) => element.id == movieId);

              return Card(
                child: ListTile(
                  leading: Image.network(
                    movie.posterurl.toString(),
                    errorBuilder: (context, error, stack) {
                      return Icon(Icons.error, color: Colors.red);
                    },
                    height: screenHeight * 0.1, // Responsive height
                    width: screenWidth * 0.2, // Responsive width
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    movie.title.toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(fontSize: screenWidth * 0.04), // Responsive font size
                  ),
                  subtitle: Text(
                    movie.year.toString(),
                    style: TextStyle(fontSize: screenWidth * 0.03), // Responsive font size
                  ),
                  trailing: Obx(
                        () => Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          Utils.averageRatting(movie.ratings!).toStringAsFixed(1),
                          style: TextStyle(fontSize: screenWidth * 0.04), // Responsive font size
                        ),
                        const Icon(Icons.star, color: Colors.yellow),
                        IconButton(
                          onPressed: () {
                            if (homeViewModel.favoriteMovieList.contains(movie.id)) {
                              homeViewModel.removeFromFavourite(movie.id);
                            } else {
                              homeViewModel.addToFavourite(movie.id);
                            }
                          },
                          icon: Icon(
                            Icons.favorite,
                            color: homeViewModel.favoriteMovieList.contains(movie.id) ? Colors.red : Colors.black,
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
    );
  }
}
