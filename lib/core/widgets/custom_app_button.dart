import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  
  // جعلناهم اختياريين عشان نستخدم القيم الافتراضية لو متبعتوش
  final Color? backgroundColor;
  final double? width;
  final double? height;
  final double? borderRadius;

  const CustomAppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.backgroundColor,
    this.width,
    this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // لو الـ width متبعتش (null) هيستخدم double.infinity (العرض الكامل)
      width: width ?? double.infinity, 
      // لو الـ height متبعتش هيستخدم 55.h
      height: height ?? 55.h, 
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          // القيمة الافتراضية للون اللي كانت في الكود بتاعك
          backgroundColor: backgroundColor ?? const Color(0xFF2D240E),
          shape: RoundedRectangleBorder(
            // القيمة الافتراضية للـ radius هي 12
            borderRadius: BorderRadius.circular(borderRadius ?? 12.r),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: Colors.white, size: 20.sp),
              SizedBox(width: 10.w),
            ],
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}