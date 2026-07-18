import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:redacted/redacted.dart';
import 'package:stylish/core/utils/app_assets.dart';
import 'package:stylish/features/home/data/models/product_model/product_model.dart';
import 'package:stylish/features/home/presentation/views/widgets/horizontal_product_list.dart';
import 'package:stylish/features/home/presentation/views/widgets/product_card_without_rating.dart';

/// this function is used to get shimmer for product
/// shimmer is used to show loading state of product
Padding getShimmerProduct(BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: (HorizontalProductListState.itemSpacing / 2).w,
    ),
    child:
        ProductCardWithoutRating(
          // Any data for null safety
          product: ProductModel(
            id: 1,
            title: '',
            price: 1,
            description: '',
            images: [Assets.iconsPerson], // any Image
          ),

          // it's an extension method of redacted package
        ).redacted(
          context: context,
          redact: true,
          configuration: RedactedConfiguration(
            animationDuration: const Duration(milliseconds: 800),
          ),
        ),
  );
}
