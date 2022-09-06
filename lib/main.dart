import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie/app/controllers/page_index_controller.dart';

import 'app/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(PageIndexController(), permanent: true);
  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          defaultTransition: Transition.cupertinoDialog,
          transitionDuration: Duration(milliseconds: 600),
          theme: ThemeData(
            scaffoldBackgroundColor: Color(0xff242A32),
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: Color(0xff242A32),
              secondary: Color(0xff67686D),
              tertiary: Color(0xff3A3F47),
            ),
            textTheme: GoogleFonts.poppinsTextTheme(
              TextTheme(
                titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18.sp),
                titleMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16.sp),
                titleSmall: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 14.sp),
                bodySmall: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 12.sp),
                labelSmall: TextStyle(color: Color(0xff92929D), fontWeight: FontWeight.w500, fontSize: 12.sp),
              ),
            ),
          ),
          title: "Application",
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
        );
      },
    ),
  );
}
