import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie/app/controllers/page_index_controller.dart';

import '../../../data/api/tmdb_service.dart';
import '../../../data/models/detail_movie_model.dart';
import '../../../data/models/movie_model.dart';

class SearchController extends GetxController {
  TextEditingController query = TextEditingController();

  Future<List<MovieModel?>> getSearch(String query) async {
    var dataSearch = await TMDBService().getSearch(query);
    dataSearch.map((e) => Get.find<PageIndexController>().listSearch.add(e!)).toList();
    print('data list search : ${Get.find<PageIndexController>().listSearch}');
    update();
    return dataSearch;
  }

  Future<DetailMovieModel> detailMovie(String id) async {
    return await TMDBService().getMovieById(id);
  }
}
