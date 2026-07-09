import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/functions/get_shimmer_product.dart';

class ProductsListLoading extends StatelessWidget {
  const ProductsListLoading({super.key, this.count = 4});

  final int count;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (185 + 50).h,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8.w,
          crossAxisSpacing: 8.h,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (_, __) => getShimmerProduct(context),
        itemCount: count,
      ),
    );
  }
}
