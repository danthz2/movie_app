import 'package:get/get.dart';
import 'package:movie/app/routes/app_pages.dart';

import '../data/models/movie_model.dart';

class PageIndexController extends GetxController {
  int selectedIndex = 0;
  var isWatchlist = false.obs;
  List<MovieModel> listSearch = [];
  var listWatchList = <String>[].obs;
  void pageController(int index, {dynamic arguments}) {
    switch (index) {
      case 1:
        selectedIndex = index;
        Get.offAllNamed(Routes.SEARCH, arguments: arguments);
        break;
      case 2:
        selectedIndex = index;
        Get.offAllNamed(Routes.WATCH_LIST);
        break;
      default:
        selectedIndex = index;
        Get.offAllNamed(Routes.HOME);
    }
  }

  void addWatchlist(String idMovie) {
    listWatchList.add(idMovie);
  }

  bool isSelected(String id) {
    update();
    int index = listWatchList.indexOf(id);
    if (index == -1) {
      return false;
    }
    return true;
  }
}
