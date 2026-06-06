import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stylish/config/routing/app_routes.dart';
import 'package:stylish/config/services/secure_storage_service.dart';
import 'package:stylish/config/services/shared_preferences_service.dart';
import 'package:stylish/core/utils/app_text_styles.dart';
import 'package:stylish/core/widgets/custom_button.dart';
import 'package:stylish/features/home/presentation/views/widgets/custom_search_bar.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomSearchBar(textEditingController: TextEditingController()),
          Text("Home View", style: AppTextStyles.extraBold24),
          CustomButton(
            title: "Logout",
            onPressed: () {
              SharedPreferencesService.clearAuthData();
              SharedPreferencesService.setLoggedIn(false);
              SecureStorageService.deleteTokens();
              context.go(AppRoutes.kLoginView);
            },
          ),
        ],
      ),
    );
  }
}
