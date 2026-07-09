import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:stylish/config/routing/app_routes.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/core/utils/app_text_styles.dart';
import 'package:stylish/core/utils/pricing_utils.dart';
import 'package:stylish/features/wishlist/data/models/wishlist_item.dart';
import 'package:stylish/features/wishlist/presentation/manager/wishlist_cubit/wishlist_cubit.dart';
import 'package:stylish/generated/l10n.dart';

class WishlistView extends StatelessWidget {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.greyBackground,
      appBar: AppBar(
        backgroundColor: context.backgroundColor,
        elevation: 0,
        title: Text(S.of(context).wishlistTitle, style: AppTextStyles.semiBold18),
        centerTitle: true,
      ),
      body: BlocBuilder<WishlistCubit, WishlistState>(
        builder: (context, state) {
          if (state is WishlistInitial) {
            return const Center(
                child: CircularProgressIndicator(color: AppColors.primary));
          } else if (state is WishlistFailure) {
            return Center(child: Text(state.message));
          } else if (state is WishlistLoaded) {
            if (state.items.isEmpty) {
              return _buildEmptyWishlist();
            }
            return _buildWishlistList(context, state.items);
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildEmptyWishlist() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(24.r),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.favorite_border_rounded,
                color: AppColors.primary, size: 56.r),
          ),
          SizedBox(height: 24.h),
          Text('Your wishlist is empty', style: AppTextStyles.semiBold18),
          SizedBox(height: 8.h),
          Text(
            'Explore our products and favorite them here.',
            style: AppTextStyles.regular14,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildWishlistList(BuildContext context, List<WishlistItem> items) {
    return ListView.separated(
      padding: EdgeInsets.all(16.w),
      physics: const BouncingScrollPhysics(),
      itemCount: items.length,
      separatorBuilder: (_, __) => SizedBox(height: 16.h),
      itemBuilder: (context, index) {
        final item = items[index];
        return _buildWishlistItem(context, item);
      },
    );
  }

  Widget _buildWishlistItem(BuildContext context, WishlistItem item) {
    return GestureDetector(
      onTap: () =>
          context.push(AppRoutes.kProductDetailsView, extra: item.product),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: context.backgroundColor,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
                color: context.shadowColor, blurRadius: 8, offset: const Offset(0, 2))
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: CachedNetworkImage(
                imageUrl: item.product.images.isNotEmpty
                    ? item.product.images.first
                    : 'https://via.placeholder.com/150',
                width: 80.w,
                height: 80.h,
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(color: AppColors.primary)),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.regular14),
                  SizedBox(height: 4.h),
                  Text(
                    PricingUtils.formatPrice(
                        PricingUtils.discountedPrice(item.product.price)),
                    style: AppTextStyles.semiBold16,
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                context.read<WishlistCubit>().toggle(item.product);
              },
              icon: const Icon(Icons.delete_outline, color: AppColors.error),
            ),
          ],
        ),
      ),
    );
  }
}
