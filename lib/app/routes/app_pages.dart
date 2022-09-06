import 'package:get/get.dart';

import 'package:movie/app/modules/detail_movie/bindings/detail_movie_binding.dart';
import 'package:movie/app/modules/detail_movie/views/detail_movie_view.dart';
import 'package:movie/app/modules/home/bindings/home_binding.dart';
import 'package:movie/app/modules/home/views/home_view.dart';
import 'package:movie/app/modules/search/bindings/search_binding.dart';
import 'package:movie/app/modules/search/views/search_view.dart';
import 'package:movie/app/modules/watch_list/bindings/watch_list_binding.dart';
import 'package:movie/app/modules/watch_list/views/watch_list_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => SearchView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: _Paths.WATCH_LIST,
      page: () => WatchListView(),
      binding: WatchListBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_MOVIE,
      page: () => DetailMovieView(),
      binding: DetailMovieBinding(),
    ),
  ];
}
