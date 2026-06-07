import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/core/utils/app_text_styles.dart';
import 'package:stylish/features/home/data/models/product_model/product_model.dart';

class ProductCardWithoutRating extends StatelessWidget {
  const ProductCardWithoutRating({super.key, required this.product});
  static const double cardHeight = 185;
  final ProductModel product;

  // Same calculation to put price and discounted price side by side
  // because we don't have real discount in api
  final int discount = 40;
  double get priceBeforeDiscount =>
      product.price * (discount / 100) + product.price;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // * ---- Product Image ----
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.r),
              image: DecorationImage(
                image: NetworkImage(product.images[0]),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

        // gap between image and text layout
        SizedBox(height: 4.h),

        //* ----  Product Title Header Text ----
        Container(
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(8.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                product.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.medium12.copyWith(color: Colors.black),
              ),

              SizedBox(height: 4.h),

              //* ---- Product Body Description Text ----
              Text(
                product.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.regular10,
              ),

              SizedBox(height: 4.h),

              // Current Price Text
              Text(
                '₹${product.price.toStringAsFixed(0)}',
                style: AppTextStyles.semiBold12.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),

              //* Pricing Row Layout Structure (Original Line out & Discount Status)
              Row(
                children: [
                  // Original Price Text with a strikethrough line
                  Text(
                    '₹${priceBeforeDiscount.toStringAsFixed(0)}',
                    style: AppTextStyles.semiBold12.copyWith(
                      color: AppColors.border,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: AppColors.border,
                      decorationThickness: 1.5,
                    ),
                  ),
                  SizedBox(width: 8.w),

                  // Dynamic Discount Percentage Text
                  Flexible(
                    child: Text(
                      '$discount%Off',
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.regular10.copyWith(
                        color: AppColors.pinkBanner,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
