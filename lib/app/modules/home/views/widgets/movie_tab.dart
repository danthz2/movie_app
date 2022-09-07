// ignore_for_file: must_be_immutable

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie/app/data/api/tmdb_service.dart';
import 'package:movie/app/data/models/movie_model.dart';
import 'package:movie/app/routes/app_pages.dart';

import '../../controllers/home_controller.dart';

class MovieTab extends StatelessWidget {
  Future<List<MovieModel>> future;
  MovieTab({
    Key? key,
    required this.future,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MovieModel>>(
        future: future,
        builder: (context, snapshot) {
          var dataSnapshot = snapshot.data ?? [];
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return GridView.builder(
            primary: false,
            shrinkWrap: true,
            padding: EdgeInsets.all(16),
            itemCount: 15,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, childAspectRatio: 3 / 4.6, mainAxisSpacing: 16, crossAxisSpacing: 16),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  var detail = await Get.find<HomeController>().detailMovie(dataSnapshot[index].id.toString());
                  Get.toNamed(
                    Routes.DETAIL_MOVIE,
                    arguments: detail,
                  );
                },
                child: FancyShimmerImage(
                  imageUrl: TMDBService.url(dataSnapshot[index].posterPath ?? ''),
                  shimmerDuration: Duration(milliseconds: 800),
                  boxFit: BoxFit.cover,
                ),
              );
            },
          );
        });
  }
}
