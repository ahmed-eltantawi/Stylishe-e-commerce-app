import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/features/home/data/models/product_model/product_model.dart';
import 'package:stylish/features/home/presentation/views/widgets/product_card.dart';

class HorizontalProductList extends StatelessWidget {
  final List<ProductModel> products;

  const HorizontalProductList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    // Parent container holding the horizontal list
    return SizedBox(
      height: 240.h, // Constrained to exactly 240h to match the card height
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // Enables horizontal scrolling
        physics: const BouncingScrollPhysics(), // Native smooth bounce effect
        itemCount: products.length,
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
        ), // Outer list start/end padding
        itemBuilder: (context, index) {
          return Padding(
            // Adds horizontal spacing between each product item
            padding: EdgeInsets.only(right: 14.w),
            child: ProductCard(product: products[index]),
          );
        },
      ),
    );
  }
}
