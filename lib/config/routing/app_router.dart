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
import 'package:stylish/features/categories/presentation/manager/get_categories_cubit/get_categories_cubit.dart';
import 'package:stylish/features/categories/presentation/views/categories_view.dart';
import 'package:stylish/features/home/data/repos/products_repo_impl.dart';
import 'package:stylish/features/home/data/models/product_model/product_model.dart';
import 'package:stylish/features/home/presentation/manager/cubit/products_cubit.dart';
import 'package:stylish/features/home/presentation/views/home_view.dart';
import 'package:stylish/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:stylish/features/products/data/repositories/products_repo_implementation.dart';
import 'package:stylish/features/products/presentation/manager/add_product_cubit/add_product_cubit.dart';
import 'package:stylish/features/products/presentation/manager/delete_product_cubit/delete_product_cubit.dart';
import 'package:stylish/features/products/presentation/manager/edit_product_cubit/edit_product_cubit.dart';
import 'package:stylish/features/products/presentation/manager/get_products_cubit/get_products_cubit.dart';
import 'package:stylish/features/products/presentation/manager/product_details_cubit/product_details_cubit.dart';
import 'package:stylish/features/products/presentation/views/add_product_view.dart';
import 'package:stylish/features/products/presentation/views/edit_product_view.dart';
import 'package:stylish/features/products/presentation/views/product_details_view.dart';
import 'package:stylish/features/products/presentation/views/products_view.dart';
import 'package:stylish/features/splash/presentation/splash_view.dart';
import 'package:stylish/features/categories/data/repositories/categories_repo_implementation.dart';

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

      //* --- Home (with bottom nav shell) ---
      GoRoute(
        path: AppRoutes.kHomeView,
        pageBuilder: (context, state) {
          return _buildTransitionPage(
            state: state,
            child: BlocProvider(
              create: (context) =>
                  ProductsCubit(productsRepoImpl: getIt<ProductsRepoImpl>()),
              child: const HomeView(),
            ),
          );
        },
      ),

      //* --- Products List ---
      GoRoute(
        path: AppRoutes.kProductsView,
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final categoryId = extra?['categoryId'] as int?;
          final categoryName = extra?['categoryName'] as String?;
          return _buildTransitionPage(
            state: state,
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (_) => GetProductsCubit(
                    productsRepo: getIt<ProductsRepoImplementation>(),
                  ),
                ),
                BlocProvider(
                  create: (_) => GetCategoriesCubit(
                    categoriesRepo: getIt<CategoriesRepoImplementation>(),
                  ),
                ),
              ],
              child: ProductsView(
                initialCategoryId: categoryId,
                categoryName: categoryName,
              ),
            ),
          );
        },
      ),

      //* --- Product Details ---
      GoRoute(
        path: AppRoutes.kProductDetailsView,
        pageBuilder: (context, state) {
          final product = state.extra as ProductModel;
          return _buildTransitionPage(
            state: state,
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (_) => ProductDetailsCubit(
                    productsRepo: getIt<ProductsRepoImplementation>(),
                  ),
                ),
                BlocProvider(
                  create: (_) => DeleteProductCubit(
                    productsRepo: getIt<ProductsRepoImplementation>(),
                  ),
                ),
              ],
              child: ProductDetailsView(product: product),
            ),
          );
        },
      ),

      //* --- Add Product ---
      GoRoute(
        path: AppRoutes.kAddProductView,
        pageBuilder: (context, state) {
          return _buildTransitionPage(
            state: state,
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (_) => AddProductCubit(
                    productsRepo: getIt<ProductsRepoImplementation>(),
                  ),
                ),
                BlocProvider(
                  create: (_) => GetCategoriesCubit(
                    categoriesRepo: getIt<CategoriesRepoImplementation>(),
                  ),
                ),
              ],
              child: const AddProductView(),
            ),
          );
        },
      ),

      //* --- Edit Product ---
      GoRoute(
        path: AppRoutes.kEditProductView,
        pageBuilder: (context, state) {
          final product = state.extra as ProductModel;
          return _buildTransitionPage(
            state: state,
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (_) => EditProductCubit(
                    productsRepo: getIt<ProductsRepoImplementation>(),
                  ),
                ),
                BlocProvider(
                  create: (_) => GetCategoriesCubit(
                    categoriesRepo: getIt<CategoriesRepoImplementation>(),
                  ),
                ),
              ],
              child: EditProductView(product: product),
            ),
          );
        },
      ),

      //* --- Categories ---
      GoRoute(
        path: AppRoutes.kCategoriesView,
        pageBuilder: (context, state) {
          return _buildTransitionPage(
            state: state,
            child: BlocProvider(
              create: (_) => GetCategoriesCubit(
                categoriesRepo: getIt<CategoriesRepoImplementation>(),
              ),
              child: const CategoriesView(),
            ),
          );
        },
      ),
    ],
  );
}
