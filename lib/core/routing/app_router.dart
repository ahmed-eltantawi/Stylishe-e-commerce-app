import 'package:go_router/go_router.dart';
import 'package:stylish/core/routing/app_routes.dart';
import 'package:stylish/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:stylish/features/splash/presentation/splash_view.dart';

abstract final class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: AppRoutes.kSplashView,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: AppRoutes.kOnboardingView,
        builder: (context, state) => const OnboardingView(),
      ),
    ],
  );
}
