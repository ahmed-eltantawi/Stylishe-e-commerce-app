import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/utils/app_text_styles.dart';
import 'package:stylish/features/home/presentation/views/widgets/action_chip_button.dart';

class CustomFilterBar extends StatelessWidget {
  const CustomFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // --- All Featureds text ---
        Text("All Featured", style: AppTextStyles.semiBold18),

        // --- Spacer to add space between the text and the buttons ---
        Spacer(),

        // --- Sort button ---
        ActionChipButton(label: "Sort", icon: Icons.swap_vert, onTap: () {}),

        SizedBox(width: 12.w),

        // --- Filter button ---
        ActionChipButton(
          label: "Filters",
          icon: Icons.filter_alt_outlined,
          onTap: () {},
        ),
      ],
    );
  }
}
