import 'package:flutter/material.dart';
import 'package:stylish/core/utils/app_text_styles.dart';

class CustomTitleScreenWidget extends StatelessWidget {
  const CustomTitleScreenWidget({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: .centerLeft,
      child: Text(title, style: AppTextStyles.bold36.copyWith(height: 1.2)),
    );
  }
}
