// ignore_for_file: must_be_immutable

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:movie/app/data/api/tmdb_service.dart';
import 'package:movie/app/data/models/detail_movie_model.dart';
import 'package:movie/app/modules/home/controllers/home_controller.dart';
import 'package:movie/app/services/assets.dart';

import '../../../../routes/app_pages.dart';

class MovieSearch extends GetView<HomeController> {
  DetailMovieModel? data;
  MovieSearch({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(
        Routes.DETAIL_MOVIE,
        arguments: data,
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: 24.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: FancyShimmerImage(
                errorWidget:
                    SvgPicture.network('https://upload.wikimedia.org/wikipedia/commons/6/65/No-Image-Placeholder.svg'),
                imageUrl: TMDBService.url(data?.posterPath ?? ''),
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
                    data?.title ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium,
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
                        '${data?.voteAverage?.toDouble().toStringAsFixed(1)}',
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
                        data?.genres?.isEmpty == true ? 'Not found' : data?.genres?[0].name ?? '',
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
                        data?.releaseDate != '' ? (data?.releaseDate)!.split('-').first : 'Not found',
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
                        '${data?.runtime} Minutes',
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
      ),
    );
  }
}
