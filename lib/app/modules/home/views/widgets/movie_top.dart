// ignore_for_file: must_be_immutable

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:movie/app/data/api/tmdb_service.dart';
import 'package:movie/app/data/models/movie_model.dart';
import 'package:movie/app/routes/app_pages.dart';

class MovieTop extends StatelessWidget {
  int index;
  MovieModel? data;
  MovieTop({
    Key? key,
    required this.index,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(
        Routes.DETAIL_MOVIE,
        arguments: data,
      ),
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(index == 1 ? 16 : 0, 16, 16, 16),
            height: 230.h,
            width: 120.w,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: FancyShimmerImage(
                shimmerDuration: Duration(milliseconds: 800),
                boxFit: BoxFit.cover,
                imageUrl: TMDBService.url(data?.posterPath ?? ''),
              ),
            ),
          ),
          Positioned(
            bottom: -20.sp,
            left: 10.sp,
            child: Stack(
              children: [
                Text(
                  '$index',
                  style: TextStyle(
                    fontSize: 100.sp,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 4.sp
                      ..color = Colors.blue,
                  ),
                ),
                // Text(
                //   '$index',
                //   style: TextStyle(
                //     fontSize: 100.sp,
                //     color: Theme.of(context).colorScheme.primary,
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
