import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/functions/get_shimmer_product.dart';
import 'package:stylish/features/home/presentation/views/widgets/product_card.dart';

class ProductsListLoading extends StatelessWidget {
  const ProductsListLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ProductCardWithRating.cardHeight.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, __) {
          return getShimmerProduct(context);
        },
        itemCount: 4,
      ),
    );
  }
}
