import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:movie/app/controllers/page_index_controller.dart';

import '../../../services/assets.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    var c = Get.find<PageIndexController>();
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(24.sp),
        children: [
          Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top)),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: FancyShimmerImage(
                  imageUrl: 'https://i.pravatar.cc/300',
                  boxFit: BoxFit.cover,
                  width: 54.w,
                  height: 54.h,
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Johanes Milk',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    '@johnmilk',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.blue),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            'Welcome Back!',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          SizedBox(
            height: 5.h,
          ),
          Text(
            '16 Watchlist',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          SizedBox(
            height: 10.h,
          ),
          Divider(
            thickness: 0.5,
            color: Colors.white,
          ),
          Text(
            'Your Account',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          ListTile(
            iconColor: Colors.white,
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.person),
            title: Text('Edit Profile'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            iconColor: Colors.white,
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.bookmark_outline),
            title: Text('Watch List'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          Text(
            'Help',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          ListTile(
            iconColor: Colors.white,
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.email),
            title: Text('Contact'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            iconColor: Colors.white,
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.report),
            title: Text('Report Problem'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          Text(
            'Other',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          ListTile(
            iconColor: Colors.white,
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.document_scanner),
            title: Text('Terms of Services'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            iconColor: Colors.white,
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.privacy_tip),
            title: Text('Privacy Policy'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            iconColor: Colors.white,
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.star),
            title: Text('Rate'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            iconColor: Colors.white,
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            iconColor: Colors.white,
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.document_scanner),
            title: Text('Terms of Services'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ],
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
