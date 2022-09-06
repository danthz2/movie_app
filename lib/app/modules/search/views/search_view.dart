// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import '../../../controllers/page_index_controller.dart';
import '../../../data/models/detail_movie_model.dart';
import '../../../data/models/movie_model.dart';

import '../../../services/assets.dart';
import '../controllers/search_controller.dart';
import 'widgets/movie_search.dart';

class SearchView extends GetView<SearchController> {
  var cPage = Get.find<PageIndexController>();
  List<MovieModel?> data = Get.arguments ?? [];
  @override
  Widget build(BuildContext context) {
    print('data argument $data');
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Search',
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
        centerTitle: true,
        leading: IconButton(
            padding: EdgeInsets.only(left: 16.sp),
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20.sp,
            ),
            onPressed: () {
              Get.find<PageIndexController>().pageController(0);
            }),
        actions: [
          IconButton(
            padding: EdgeInsets.only(right: 16.sp),
            onPressed: () => print('info'),
            icon: SvgPicture.asset(infoIcon),
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(24.sp),
        children: [
          TextField(
            controller: controller.query,
            cursorColor: Theme.of(context).colorScheme.secondary,
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: TextStyle(color: Theme.of(context).colorScheme.secondary),
              filled: true,
              fillColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 0),
              suffixIcon: IconButton(
                icon: SvgPicture.asset(searchIcon),
                splashColor: Colors.red,
                splashRadius: 1,
                onPressed: () async {
                  print('jalan');
                  List<MovieModel?> search = await controller.getSearch(controller.query.text);
                  print('jalan2');
                  print(search);
                },
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
          GetBuilder<SearchController>(
            builder: (c) {
              print('list search di builder ${cPage.listSearch}');
              if (cPage.listSearch.isEmpty) {
                if (data.isEmpty) {
                  return Text(
                    'No Data Found',
                    style: Theme.of(context).textTheme.titleMedium,
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return FutureBuilder<DetailMovieModel>(
                        future: c.detailMovie((data[index]?.id).toString()),
                        builder: (context, snapshot) {
                          print('data snapshot $snapshot');
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          return MovieSearch(data: snapshot.data);
                        },
                      );
                    },
                  );
                }
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: cPage.listSearch.length,
                  itemBuilder: (context, index) {
                    return FutureBuilder<DetailMovieModel>(
                      future: c.detailMovie((cPage.listSearch[index].id).toString()),
                      builder: (context, snapshot) {
                        print('data snapshot $snapshot');
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        return MovieSearch(data: snapshot.data);
                      },
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(top: 2.sp),
        color: Colors.blue,
        child: BottomNavigationBar(
          unselectedItemColor: Theme.of(context).colorScheme.secondary,
          selectedItemColor: Colors.blue,
          selectedIconTheme: IconThemeData(color: Colors.blue),
          backgroundColor: Theme.of(context).colorScheme.primary,
          currentIndex: cPage.selectedIndex,
          onTap: (value) => cPage.pageController(value),
          items: [
            BottomNavigationBarItem(
                label: 'Home',
                icon: SvgPicture.asset(homeIcon),
                activeIcon: SvgPicture.asset(
                  homeIcon,
                  color: Colors.blue,
                )),
            BottomNavigationBarItem(
              label: 'Search',
              icon: SvgPicture.asset(searchIcon),
              activeIcon: SvgPicture.asset(
                searchIcon,
                color: Colors.blue,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Watch list',
              icon: SvgPicture.asset(bookmarkIcon),
              activeIcon: SvgPicture.asset(
                bookmarkIcon,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
