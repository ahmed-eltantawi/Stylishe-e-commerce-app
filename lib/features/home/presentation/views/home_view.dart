import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stylish/config/routing/app_routes.dart';
import 'package:stylish/config/services/secure_storage_service.dart';
import 'package:stylish/config/services/shared_preferences_service.dart';
import 'package:stylish/core/widgets/custom_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomButton(
          title: "Logout",
          onPressed: () {
            SharedPreferencesService.clearAuthData();
            SharedPreferencesService.setLoggedIn(false);
            SecureStorageService.deleteTokens();
            context.go(AppRoutes.kLoginView);
          },
        ),
      ),
    );
  }
}
