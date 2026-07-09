import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/core/utils/app_text_styles.dart';
import 'package:stylish/features/home/data/models/product_model/product_model.dart';
import 'package:stylish/features/home/presentation/views/widgets/product_card_without_rating.dart';

import 'package:go_router/go_router.dart';
import 'package:stylish/config/routing/app_routes.dart';

class ProductCardWithRating extends StatelessWidget {
  final ProductModel product;

  // that's because we don't have real ratting in api
  final double ratting = 4.5;
  final int rattingCount = 143134;

  const ProductCardWithRating({super.key, required this.product});
  static const double cardWidth = 170;
  static const double cardHeight = 240;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(AppRoutes.kProductDetailsView, extra: product),
      child: Container(
        color: context.backgroundColor,
        width: cardWidth.w,
        height: cardHeight.h,
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* 1. Product Card Info (image, title, description, and price) ----
          Expanded(child: ProductCardWithoutRating(product: product)),
          SizedBox(height: 4.h),

          //* 2. Rating Row and Total Reviews Metric Count
          Container(
            padding: EdgeInsets.only(left: 4.w, right: 4.w, bottom: 4.h),
            decoration: BoxDecoration(
              color: context.backgroundColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8.r),
                bottomRight: Radius.circular(8.r),
              ),
            ),
            child: Row(
              children: [
                // Generates 5 rating stars dynamically based on api response rating value
                Row(
                  children: List.generate(5, (index) {
                    if (index < ratting.floor()) {
                      return Icon(
                        Icons.star,
                        color: const Color(0xFFEDB310),
                        size: 14.r,
                      );
                    } else if (index < ratting && ratting % 1 != 0) {
                      return Icon(
                        Icons.star_half,
                        color: const Color(0xFFEDB310),
                        size: 14.r,
                      );
                    } else {
                      return Icon(
                        Icons.star,
                        color: Colors.grey.shade300,
                        size: 14.r,
                      );
                    }
                  }),
                ),
                SizedBox(width: 4.w),

                // Total numeric calculation counts
                Text(
                  rattingCount.toString(),
                  style: AppTextStyles.regular10.copyWith(
                    color: context.borderColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }
}
