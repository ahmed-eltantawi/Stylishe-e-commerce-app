// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:stylish/core/utils/app_colors.dart';

// class VisibilityPasswordIcon extends StatefulWidget {
//   const VisibilityPasswordIcon({super.key});

//   @override
//   State<VisibilityPasswordIcon> createState() => _VisibilityPasswordIconState();
// }

// class _VisibilityPasswordIconState extends State<VisibilityPasswordIcon> {
//   IconData icon = Icons.visibility_outlined;
//   void changeVisibility() {
//     if (icon == Icons.visibility_outlined) {
//       icon = Icons.visibility_off_outlined;
//     } else {
//       icon = Icons.visibility_outlined;
//     }

//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(right: 15.w),
//       child: GestureDetector(
//         onTap: () => changeVisibility(),
//         child: Icon(icon, color: AppColors.textHint),
//       ),
//     );
//   }
// }
