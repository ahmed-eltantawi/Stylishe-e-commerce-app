import 'package:go_router/go_router.dart';
import 'package:stylish/core/routing/app_routes.dart';
import 'package:stylish/features/splash/presentation/views/splash_view.dart';

abstract final class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: AppRoutes.splashView,
        builder: (context, state) => const SplashView(),
      ),
    ],
  );
}
