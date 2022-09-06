import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:movie/app/controllers/page_index_controller.dart';
import 'package:movie/app/data/api/tmdb_service.dart';
import 'package:movie/app/data/models/detail_movie_model.dart';
import 'package:movie/app/data/models/movie_model.dart';
import 'package:movie/app/modules/detail_movie/views/widgets/about_movie.dart';
import 'package:movie/app/modules/detail_movie/views/widgets/cast.dart';
import 'package:movie/app/modules/detail_movie/views/widgets/reviews.dart';
import 'package:movie/app/services/assets.dart';

import '../controllers/detail_movie_controller.dart';

class DetailMovieView extends GetView<DetailMovieController> {
  @override
  Widget build(BuildContext context) {
    // var cPage = Get.find<PageIndexController>();
    MovieModel data = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Movie'),
        centerTitle: true,
        elevation: 0,
        actions: [
          GetBuilder<PageIndexController>(
            builder: (cPage) {
              return IconButton(
                onPressed: () {
                  if (cPage.listWatchList.contains(data.id.toString())) {
                    cPage.listWatchList.remove(data.id.toString());
                  } else {
                    cPage.addWatchlist(data.id.toString());
                  }
                  cPage.isSelected(data.id.toString());
                  print(cPage.listWatchList);
                },
                icon: SvgPicture.asset(
                  cPage.isSelected(data.id.toString()) ? bookmarkFillIcon : bookmarkIcon,
                  color: Colors.white,
                ),
              );
            },
          )
        ],
      ),
      body: FutureBuilder<DetailMovieModel>(
          future: controller.detailMovie(data.id.toString()),
          builder: (context, snapshot) {
            var dataSnapshot = snapshot.data;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: [
                Stack(
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      height: 240.h,
                      width: double.infinity,
                      child: FancyShimmerImage(
                        imageUrl: TMDBService.url(data.backdropPath ?? ''),
                        width: double.infinity,
                        height: 180.h,
                      ),
                    ),
                    Positioned(
                      left: 16.sp,
                      bottom: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width - 40.w,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16.r),
                              child: FancyShimmerImage(
                                imageUrl: TMDBService.url(data.posterPath ?? ''),
                                boxFit: BoxFit.cover,
                                height: 120.h,
                                width: 95.w,
                              ),
                            ),
                            SizedBox(
                              width: 10.sp,
                            ),
                            Expanded(
                              child: Text(
                                data.title ?? '',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 80.sp,
                      right: 20.sp,
                      child: Container(
                        width: 54.w,
                        height: 24.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(starIcon, color: Color(0xffFF8700)),
                            SizedBox(
                              width: 5.w,
                            ),
                            Text(
                              '${dataSnapshot?.voteAverage?.toStringAsFixed(1) ?? 0.0}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(color: Color(0xffFF8700), fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 40.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(dateIcon),
                          SizedBox(
                            width: 4.sp,
                          ),
                          Text(
                            (data.releaseDate ?? '').split('-').first,
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),
                      Container(
                        height: 20.sp,
                        child: VerticalDivider(
                          color: Color(0xffff92929D),
                        ),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(clockIcon),
                          SizedBox(
                            width: 4.sp,
                          ),
                          Text(
                            '${dataSnapshot?.runtime} Minutes',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),
                      Container(
                        height: 20.sp,
                        child: VerticalDivider(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(ticketIcon),
                          SizedBox(
                            width: 4.sp,
                          ),
                          Text(
                            (dataSnapshot?.genres?[0])?.name ?? '',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                DefaultTabController(
                  length: 3,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.sp),
                        child: TabBar(
                          labelStyle: Theme.of(context).textTheme.titleMedium,
                          labelPadding: EdgeInsets.zero,
                          indicatorColor: Theme.of(context).colorScheme.secondary.withOpacity(0.4),
                          indicatorWeight: 5.sp,
                          tabs: [
                            Tab(
                              child: Text('About Movie'),
                            ),
                            Tab(
                              child: Text('Reviews'),
                            ),
                            Tab(
                              child: Text('Cast'),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 300,
                        child: TabBarView(children: [
                          AboutMovie(text: data.overview ?? ''),
                          Review(id: data.id.toString()),
                          Cast(movieId: data.id.toString()),
                        ]),
                      )
                    ],
                  ),
                )
              ],
            );
          }),
    );
  }
}
