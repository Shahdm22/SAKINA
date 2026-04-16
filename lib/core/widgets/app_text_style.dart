
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sakina/core/theme/app_colors.dart';

abstract class AppTextStyle {
  ///style for hint text in app
  static  TextStyle hintStyle=TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w400,color: AppColors.primaryBeig);
  static  TextStyle errorStyle=TextStyle(fontSize: 9.sp,
      fontWeight: FontWeight.bold,color: Colors.redAccent);
  static  TextStyle headlineStyle=TextStyle(fontSize: 30.sp,color: Color(0xff2F2F2F));

}