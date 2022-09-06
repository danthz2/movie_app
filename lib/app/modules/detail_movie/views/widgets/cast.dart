// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:movie/app/data/api/tmdb_service.dart';
import 'package:movie/app/data/models/cast_model.dart';
import 'package:movie/app/modules/detail_movie/controllers/detail_movie_controller.dart';

class Cast extends GetView<DetailMovieController> {
  String movieId;
  Cast({
    Key? key,
    required this.movieId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.sp),
      child: FutureBuilder<List<CastModel>>(
          future: controller.listCast(movieId),
          builder: (context, snapshot) {
            var data = snapshot.data ?? [];
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
              ),
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    CircleAvatar(
                      radius: 40.r,
                      backgroundImage: NetworkImage(data[index].profilePath != null
                          ? TMDBService.url('${data[index].profilePath}')
                          : 'https://ui-avatars.com/api/?name=${data[index].name}'),
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    Text(
                      data[index].name ?? '',
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                  ],
                );
              },
            );
          }),
    );
  }
}
