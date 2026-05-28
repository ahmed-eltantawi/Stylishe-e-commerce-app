import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:stylish/config/services/services_locator.dart';
import 'package:stylish/config/services/shared_preferences_service.dart';
import 'package:stylish/config/routing/app_routes.dart';
import 'package:stylish/features/Auth/data/repositories/auth_repo_implementation.dart';
import 'package:stylish/features/Auth/presentation/manager/signin_cubit/signin_cubit.dart';
import 'package:stylish/features/Auth/presentation/manager/signup_cubit/signup_cubit.dart';
import 'package:stylish/features/Auth/presentation/views/forget_password_view.dart';
import 'package:stylish/features/Auth/presentation/views/login_view.dart';
import 'package:stylish/features/Auth/presentation/views/register_view.dart';
import 'package:stylish/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:stylish/features/splash/presentation/splash_view.dart';

abstract final class AppRouter {
  //* --- Global Transition ---
  static CustomTransitionPage<dynamic> _buildTransitionPage({
    required GoRouterState state,
    required Widget child,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  static final router = GoRouter(
    routes: [
      //* --- Splash ---
      GoRoute(
        path: AppRoutes.kSplashView,
        builder: (context, state) => const SplashView(),
      ),

      //* --- Onboarding ---
      GoRoute(
        path: AppRoutes.kOnboardingView,
        pageBuilder: (context, state) {
          return _buildTransitionPage(
            state: state,
            child: const OnboardingView(),
          );
        },
      ),

      //* --- Login ---
      GoRoute(
        path: AppRoutes.kLoginView,
        pageBuilder: (context, state) {
          SharedPreferencesService.onBoardingViewed();
          return _buildTransitionPage(
            state: state,
            child: BlocProvider(
              create: (context) =>
                  SigninCubit(authRepo: getIt<AuthRepoImplementation>()),
              child: const LoginView(),
            ),
          );
        },
      ),

      //* --- Register ---
      GoRoute(
        path: AppRoutes.kRegisterView,
        pageBuilder: (context, state) {
          return _buildTransitionPage(
            state: state,
            child: BlocProvider(
              create: (context) =>
                  SignupCubit(authRepo: getIt<AuthRepoImplementation>()),
              child: const RegisterView(),
            ),
          );
        },
      ),

      //* --- Forget Password ---
      GoRoute(
        path: AppRoutes.kForgetPasswordView,
        pageBuilder: (context, state) {
          return _buildTransitionPage(
            state: state,
            child: const ForgetPasswordView(),
          );
        },
      ),
    ],
  );
}
