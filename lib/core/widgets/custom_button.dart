import 'package:flutter/material.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/generated/l10n.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      child: Text(S.of(context).login),
    );
  }
}
