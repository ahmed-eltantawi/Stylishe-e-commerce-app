import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:stylish/config/routing/app_routes.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/core/utils/app_text_styles.dart';
import 'package:stylish/core/utils/pricing_utils.dart';
import 'package:stylish/features/home/data/models/product_model/product_model.dart';

class ProductsGridItem extends StatelessWidget {
  const ProductsGridItem({super.key, required this.product});

  final ProductModel product;

  static const double _fakeRating = 4.5;
  static const int _fakeRatingCount = 56890;
  double get _priceBeforeDiscount =>
      PricingUtils.priceBeforeDiscount(product.price);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(
        AppRoutes.kProductDetailsView,
        extra: product,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: context.backgroundColor,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: context.shadowColor,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Product Image ──────────────────────────────────────
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.r),
                  topRight: Radius.circular(12.r),
                ),
                child: _buildImage(context),
              ),
            ),

            // ── Info section ───────────────────────────────────────
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.medium12
                          .copyWith(color: context.textPrimary),
                    ),
                    SizedBox(height: 4.h),

                    // Price row
                    Row(
                      children: [
                        Text(
                          PricingUtils.formatPrice(
                              PricingUtils.discountedPrice(product.price)),
                          style: AppTextStyles.semiBold12.copyWith(
                            color: context.textPrimary,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          '₹${_priceBeforeDiscount.toStringAsFixed(0)}',
                          style: AppTextStyles.semiBold12.copyWith(
                            color: context.borderColor,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: context.borderColor,
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),

                    // Rating
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        ...List.generate(5, (i) {
                          if (i < _fakeRating.floor()) {
                            return Icon(Icons.star,
                                color: const Color(0xFFEDB310), size: 10.r);
                          } else if (i < _fakeRating &&
                              _fakeRating % 1 != 0) {
                            return Icon(Icons.star_half,
                                color: const Color(0xFFEDB310), size: 10.r);
                          } else {
                            return Icon(Icons.star,
                                color: Colors.grey.shade300, size: 10.r);
                          }
                        }),
                        SizedBox(width: 2.w),
                        Text(
                          _fakeRatingCount.toString(),
                          style: AppTextStyles.regular10
                              .copyWith(color: context.borderColor, fontSize: 8.sp),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    if (product.images.isEmpty) return _placeholder(context);
    final url = product.images.first;
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      width: double.infinity,
      placeholder: (context, url) => Center(
          child: CircularProgressIndicator(color: AppColors.primary)),
      errorWidget: (context, url, error) => _placeholder(context),
    );
  }

  Widget _placeholder(BuildContext context) {
    return Container(
      color: context.surfaceVariant,
      child: Center(
        child: Icon(Icons.image_not_supported_outlined,
            color: context.borderColor, size: 36.r),
      ),
    );
  }
}
