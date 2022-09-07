// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:movie/app/controllers/page_index_controller.dart';
import 'package:movie/app/data/models/movie_model.dart';
import 'package:movie/app/modules/watch_list/views/widgets/movie_watch_list.dart';

import '../../../services/assets.dart';
import '../controllers/watch_list_controller.dart';

class WatchListView extends GetView<WatchListController> {
  var c = Get.find<PageIndexController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watch List'),
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder<List<String>>(
          future: controller.getWatchList(),
          builder: (context, snapshot) {
            print('data watchlist ${snapshot.data}');
            var dataSnapshot = snapshot.data;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data!.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(watchlistBoxIcon),
                  SizedBox(
                    height: 10.h,
                  ),
                  Center(
                    child: Text(
                      'There Is No Movie Yet!',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Center(
                    child: Text(
                      'Find your movie by Type title,\ncategories, years, etc',
                      style: Theme.of(context).textTheme.labelSmall,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              );
            }
            return ListView.builder(
              padding: EdgeInsets.all(24.sp),
              itemCount: dataSnapshot?.length,
              itemBuilder: (context, index) {
                return MovieWatchList(
                  idMovie: dataSnapshot![index],
                );
              },
            );
          }),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(top: 2.sp),
        color: Colors.blue,
        child: BottomNavigationBar(
          unselectedItemColor: Theme.of(context).colorScheme.secondary,
          selectedItemColor: Colors.blue,
          selectedIconTheme: IconThemeData(color: Colors.blue),
          backgroundColor: Theme.of(context).colorScheme.primary,
          currentIndex: c.selectedIndex,
          onTap: (value) => c.pageController(value),
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
