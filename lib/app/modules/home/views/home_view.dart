import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:movie/app/controllers/page_index_controller.dart';
import 'package:movie/app/data/models/movie_model.dart';
import 'package:movie/app/routes/app_pages.dart';
import 'package:movie/app/services/assets.dart';
import 'package:movie/app/modules/home/views/widgets/movie_top.dart';

import '../controllers/home_controller.dart';
import 'widgets/movie_tab.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    var c = Get.find<PageIndexController>();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: DefaultTabController(
        length: 4,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Padding(
                padding: EdgeInsets.only(left: 10.sp),
                child: Text(
                  'What do you want to watch?',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.person),
                  onPressed: () => Get.toNamed(Routes.PROFILE),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16.sp),
                child: TextField(
                  onSubmitted: (value) async {
                    List<MovieModel?> data = await controller.getSearch(value);
                    Get.find<PageIndexController>().pageController(1, arguments: data);
                  },
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
                        List<MovieModel?> data = await controller.getSearch(controller.query.text);
                        Get.find<PageIndexController>().pageController(1, arguments: data);
                      },
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 200.h,
                child: FutureBuilder<List<MovieModel>>(
                    future: controller.getTypeMovie(MovieType.popular),
                    builder: (context, snapshot) {
                      var data = snapshot.data ?? [];
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return MovieTop(index: index + 1, data: data[index]);
                        },
                      );
                    }),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: Theme.of(context).colorScheme.tertiary,
                  indicatorWeight: 5.sp,
                  padding: EdgeInsets.symmetric(horizontal: 16.sp),
                  labelPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 10.sp),
                  tabs: [
                    Text(
                      'Now playing',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text('Upcoming', style: Theme.of(context).textTheme.titleSmall),
                    Text('Top rated', style: Theme.of(context).textTheme.titleSmall),
                    Text('Popular', style: Theme.of(context).textTheme.titleSmall),
                  ],
                ),
                Container(
                  height: 300,
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      MovieTab(future: controller.getTypeMovie(MovieType.nowPlaying)),
                      MovieTab(future: controller.getTypeMovie(MovieType.upcoming)),
                      MovieTab(future: controller.getTypeMovie(MovieType.topRated)),
                      MovieTab(future: controller.getTypeMovie(MovieType.popular)),
                    ],
                  ),
                ),
              ]),
            )
          ],
          // ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(top: 2),
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
