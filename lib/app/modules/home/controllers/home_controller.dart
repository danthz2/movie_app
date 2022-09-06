import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:movie/app/data/api/tmdb_service.dart';
import 'package:movie/app/data/models/movie_model.dart';

import '../../../data/models/detail_movie_model.dart';

enum MovieType {
  nowPlaying,
  upcoming,
  topRated,
  popular,
}

class HomeController extends GetxController {
  TextEditingController query = TextEditingController();

  Future<List<MovieModel>> getTypeMovie(type) async {
    switch (type) {
      case MovieType.nowPlaying:
        return await TMDBService().getListMovie('now_playing');
      case MovieType.upcoming:
        return await TMDBService().getListMovie('upcoming');
      case MovieType.topRated:
        return await TMDBService().getListMovie('top_rated');
      case MovieType.popular:
        return await TMDBService().getListMovie('popular');
      default:
        return await TMDBService().getListMovie('popular');
    }
  }

  Future<List<MovieModel?>> getSearch(String query) async {
    return await TMDBService().getSearch(query);
  }

  Future<DetailMovieModel> detailMovie(String id) async {
    return await TMDBService().getMovieById(id);
  }
}
