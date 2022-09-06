// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:movie/app/data/api/tmdb_service.dart';
import 'package:movie/app/data/models/review_model.dart';
import 'package:movie/app/modules/detail_movie/controllers/detail_movie_controller.dart';

class Review extends GetView<DetailMovieController> {
  String id;
  Review({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ReviewModel>>(
        future: controller.listReview(id),
        builder: (context, snapshot) {
          var dataSnapshot = snapshot.data ?? [];
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: dataSnapshot.length,
            itemBuilder: (context, index) {
              return reviewItem(
                context,
                name: dataSnapshot[index].authorDetails?.username,
                imageUrl: dataSnapshot[index].authorDetails?.avatarPath,
                content: dataSnapshot[index].content,
                rating: dataSnapshot[index].authorDetails?.rating,
              );
            },
          );
        });
  }

  Container reviewItem(
    BuildContext context, {
    String? imageUrl,
    String? name,
    String? content,
    double? rating,
  }) {
    return Container(
      margin: EdgeInsets.all(16.sp),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              CircleAvatar(
                radius: 25.r,
                backgroundImage: NetworkImage(imageUrl != null
                    ? imageUrl.contains('www.gravatar.com')
                        ? imageUrl.substring(1)
                        : TMDBService.url(imageUrl)
                    : 'https://ui-avatars.com/api/?name=$name}'),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                (rating ?? 0.0).toString(),
                style: TextStyle(color: Colors.blueAccent),
              )
            ],
          ),
          SizedBox(
            width: 15.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name ?? '',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  content ?? '',
                  style: Theme.of(context).textTheme.bodySmall,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
