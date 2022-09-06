import 'package:get/get.dart';
import 'package:movie/app/controllers/page_index_controller.dart';
import 'package:movie/app/data/models/movie_model.dart';

import '../../../data/api/tmdb_service.dart';
import '../../../data/models/detail_movie_model.dart';

class WatchListController extends GetxController {
  var cPage = Get.find<PageIndexController>();

  Future<List<String>> getWatchList() async {
    return cPage.listWatchList;
  }

  Future<DetailMovieModel> detailMovie(String id) async {
    return await TMDBService().getMovieById(id);
  }
}
