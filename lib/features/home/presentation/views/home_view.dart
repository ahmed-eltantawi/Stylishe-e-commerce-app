import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/core/utils/app_text_styles.dart';
import 'package:stylish/features/cart/presentation/views/cart_view.dart';
import 'package:stylish/features/home/presentation/manager/nav_cubit/nav_cubit.dart';
import 'package:stylish/features/home/presentation/views/widgets/home_view_app_bar.dart';
import 'package:stylish/features/home/presentation/views/widgets/home_view_body.dart';
import 'package:stylish/features/products/presentation/views/products_view.dart';
import 'package:stylish/features/products/presentation/manager/get_products_cubit/get_products_cubit.dart';
import 'package:stylish/features/products/data/repositories/products_repo_implementation.dart';
import 'package:stylish/features/categories/presentation/manager/get_categories_cubit/get_categories_cubit.dart';
import 'package:stylish/features/categories/data/repositories/categories_repo_implementation.dart';
import 'package:stylish/config/services/services_locator.dart';
import 'package:stylish/features/settings/presentation/views/settings_view.dart';
import 'package:stylish/features/wishlist/presentation/views/wishlist_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static final List<Widget> _pages = [
    const _HomeTab(),
    const WishlistView(),
    const CartView(),
    const _SearchTab(),
    const SettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavCubit, NavState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.greyBackground,
          body: IndexedStack(
            index: state.selectedIndex,
            children: _pages,
          ),
          bottomNavigationBar: _buildBottomNav(context, state.selectedIndex),
        );
      },
    );
  }

  Widget _buildBottomNav(BuildContext context, int currentIndex) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.background,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          height: 60.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: Icons.home_outlined,
                activeIcon: Icons.home_rounded,
                label: 'Home',
                isActive: currentIndex == 0,
                onTap: () => context.read<NavCubit>().selectTab(0),
              ),
              _NavItem(
                icon: Icons.favorite_border_rounded,
                activeIcon: Icons.favorite_rounded,
                label: 'Wishlist',
                isActive: currentIndex == 1,
                onTap: () => context.read<NavCubit>().selectTab(1),
              ),
              _NavItem(
                icon: Icons.shopping_cart_outlined,
                activeIcon: Icons.shopping_cart_rounded,
                label: 'Cart',
                isActive: currentIndex == 2,
                onTap: () => context.read<NavCubit>().selectTab(2),
              ),
              _NavItem(
                icon: Icons.search_rounded,
                activeIcon: Icons.search_rounded,
                label: 'Search',
                isActive: currentIndex == 3,
                onTap: () => context.read<NavCubit>().selectTab(3),
              ),
              _NavItem(
                icon: Icons.settings_outlined,
                activeIcon: Icons.settings_rounded,
                label: 'Setting',
                isActive: currentIndex == 4,
                onTap: () => context.read<NavCubit>().selectTab(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// The actual Home tab content (wraps the original HomeViewBody with an AppBar).
class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyBackground,
      appBar: HomeViewAppBar(),
      body: SafeArea(child: HomeViewBody()),
    );
  }
}

/// Single bottom-nav icon+label item with animated active indicator.
class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 60.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isActive ? activeIcon : icon,
              color: isActive ? AppColors.primary : AppColors.textHint,
              size: 22.r,
            ),
            SizedBox(height: 3.h),
            Text(
              label,
              style: AppTextStyles.regular10.copyWith(
                color: isActive ? AppColors.primary : AppColors.textHint,
                fontSize: 9.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchTab extends StatelessWidget {
  const _SearchTab();

  @override
  Widget build(BuildContext context) {
    // Read pending category set by Home category tap — consumed once then cleared
    final pending =
        context.select<NavCubit, String?>((c) => c.state.pendingCategoryName);

    return MultiBlocProvider(
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
        hideBackButton: true,
        initialSearchQuery: pending,
        onSearchQueryConsumed: () =>
            context.read<NavCubit>().clearPendingCategory(),
      ),
    );
  }
}
