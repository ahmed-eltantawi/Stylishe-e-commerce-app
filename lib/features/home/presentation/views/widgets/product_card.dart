import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/core/utils/app_text_styles.dart';
import 'package:stylish/features/home/data/models/product_model/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  // that's because we don't have real ratting in api
  final double ratting = 4.5;
  final int rattingCount = 143134;

  // Same calculation to put price and discounted price side by side
  // because we don't have real discount in api
  final int discount = 40;
  double get priceBeforeDiscount =>
      product.price * (discount / 100) + product.price;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170.w,
      height: 240.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* 1. Top Section: Product Image Container with Rounded Corners ----
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
          SizedBox(height: 8.h),

          //* ---- 2. Product Title Header Text ----
          Text(
            product.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.medium12.copyWith(color: Colors.black),
          ),

          SizedBox(height: 4.h),

          //* ---- 3. Product Body Description Text ----
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

          //* 4. Pricing Row Layout Structure (Original Line out & Discount Status)
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

          SizedBox(height: 4.h),

          //* 5. Star Rating Row and Total Reviews Metric Count
          Row(
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
                  color: AppColors.border,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
