import 'package:flutter/material.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/features/home/presentation/views/home_view_app_bar.dart';
import 'package:stylish/features/home/presentation/views/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // background color
      backgroundColor: AppColors.greyBackground,

      // app bar
      appBar: HomeViewAppBar(),

      // body
      body: SafeArea(child: HomeViewBody()),
    );
  }
}
