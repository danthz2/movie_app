import 'package:get/get.dart';
import 'package:movie/app/data/api/tmdb_service.dart';
import 'package:movie/app/data/models/cast_model.dart';
import 'package:movie/app/data/models/detail_movie_model.dart';
import 'package:movie/app/data/models/review_model.dart';

class DetailMovieController extends GetxController {
  Future<DetailMovieModel> detailMovie(String id) async {
    return await TMDBService().getMovieById(id);
  }

  Future<List<CastModel>> listCast(String id) async {
    return await TMDBService().getListCast(id);
  }

  Future<List<ReviewModel>> listReview(String id) async {
    return await TMDBService().getListReview(id);
  }
}
