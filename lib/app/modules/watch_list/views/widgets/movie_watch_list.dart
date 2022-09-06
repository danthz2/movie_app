import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:movie/app/data/api/tmdb_service.dart';
import 'package:movie/app/data/models/detail_movie_model.dart';
import 'package:movie/app/data/models/movie_model.dart';
import 'package:movie/app/modules/watch_list/controllers/watch_list_controller.dart';

import '../../../../services/assets.dart';

class MovieWatchList extends GetView<WatchListController> {
  String idMovie;
  MovieWatchList({Key? key, required this.idMovie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DetailMovieModel>(
        future: controller.detailMovie(idMovie),
        builder: (context, snapshot) {
          var dataSnapshot = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            margin: EdgeInsets.only(bottom: 24.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: FancyShimmerImage(
                    imageUrl: TMDBService.url(dataSnapshot?.posterPath ?? ''),
                    boxFit: BoxFit.cover,
                    width: 95.w,
                    height: 110.h,
                  ),
                ),
                SizedBox(
                  width: 12.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dataSnapshot?.title ?? '',
                        style: Theme.of(context).textTheme.titleMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            starIcon,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          Text(
                            '${dataSnapshot?.voteAverage?.toDouble().toStringAsFixed(1)}',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            ticketIcon,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          Text(
                            dataSnapshot?.genres?[0].name ?? '',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            dateIcon,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          Text(
                            dataSnapshot?.releaseDate != ''
                                ? (dataSnapshot?.releaseDate)!.split('-').first
                                : 'Not found',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            clockIcon,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 4.w,
                          ),
                          Text(
                            '${dataSnapshot?.runtime} Minutes',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
