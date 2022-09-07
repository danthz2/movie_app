import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:movie/app/data/models/cast_model.dart';
import 'package:movie/app/data/models/detail_movie_model.dart';
import 'package:movie/app/data/models/movie_model.dart';
import 'package:movie/app/data/models/review_model.dart';

class TMDBService {
  String apiKey = '4f5d9fbafe6ccc6b2bfd27aa8de5e5da';
  static String url(String url) {
    return 'https://image.tmdb.org/t/p/w500/$url';
  }

  Future<List<MovieModel>> getListMovie(String type) async {
    var url = Uri.parse('https://api.themoviedb.org/3/movie/$type?api_key=$apiKey&language=en-US&page=1');
    try {
      var response = await http.get(
        url,
      );
      var jsonData = jsonDecode(response.body);
      var data = jsonData['results'] as List<dynamic>;
      return data.map((e) => MovieModel.fromJson(e)).toList();
    } catch (e) {
      Get.snackbar('Error Message', e.toString());
    }
    return [];
  }

  Future<List<MovieModel>> getSearch(String query) async {
    var url = Uri.parse(
        'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$query&language=en-US&page=1&include_adult=false');
    try {
      var response = await http.get(
        url,
      );
      var jsonData = jsonDecode(response.body);
      var data = jsonData['results'] as List<dynamic>;
      return data.map((e) => MovieModel.fromJson(e)).toList();
    } catch (e) {
      Get.snackbar('Error Message', e.toString());
    }
    return [];
  }

  Future<DetailMovieModel> getMovieById(String id) async {
    var url = Uri.parse('https://api.themoviedb.org/3/movie/$id?api_key=$apiKey&language=en-US');
    try {
      var response = await http.get(
        url,
      );
      var jsonData = jsonDecode(response.body) as Map<String, dynamic>;
      return DetailMovieModel.fromJson(jsonData);
    } catch (e) {
      Get.snackbar('Error Message', e.toString());
    }
    return DetailMovieModel();
  }

  Future<List<CastModel>> getListCast(String id) async {
    var url = Uri.parse('https://api.themoviedb.org/3/movie/$id/credits?api_key=$apiKey&language=en-US');
    try {
      var response = await http.get(
        url,
      );
      var jsonData = jsonDecode(response.body);
      var data = jsonData['cast'] as List<dynamic>;
      return data.map((e) => CastModel.fromJson(e)).toList();
    } catch (e) {
      Get.snackbar('Error Message', e.toString());
    }
    return [];
  }

  Future<List<ReviewModel>> getListReview(String id) async {
    var url = Uri.parse('https://api.themoviedb.org/3/movie/$id/reviews?api_key=$apiKey&language=en-US&page=1');
    try {
      var response = await http.get(
        url,
      );
      var jsonData = jsonDecode(response.body);
      var data = jsonData['results'] as List<dynamic>;
      print('data : $data');
      return data.map((e) => ReviewModel.fromJson(e)).toList();
    } catch (e) {
      Get.snackbar('Error Message', e.toString());
    }
    return [];
  }
}
