import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/features/home/data/models/product_model/product_model.dart';
import 'package:stylish/features/home/presentation/views/widgets/product_card.dart';
import 'package:stylish/features/home/presentation/views/widgets/product_card_without_rating.dart';

class HorizontalProductList extends StatefulWidget {
  const HorizontalProductList({
    super.key,
    required this.productWithRating,
    required this.products,
    this.onNextPressed,
  });

  final bool productWithRating;
  final List<ProductModel> products;
  final VoidCallback? onNextPressed;

  @override
  State<HorizontalProductList> createState() => _HorizontalProductListState();
}

class _HorizontalProductListState extends State<HorizontalProductList> {
  // Attached ScrollController to control the horizontal list programmatic movements
  final ScrollController _scrollController = ScrollController();

  // Boolean visibility control flags for the navigation arrows
  bool _showLeftButton = false;
  bool _showRightButton = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);

    // Check initial scroll limits right after the first frame layout renders
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollListener();
    });
  }

  /// Evaluates scroll offset positions to toggle buttons visibility state dynamically
  void _scrollListener() {
    if (_scrollController.hasClients) {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.offset;

      setState(() {
        // Show left arrow only if the list has been scrolled forward
        _showLeftButton = currentScroll > 5;
        // Show right arrow only if the list hasn't hit the final end bounding edge
        _showRightButton = currentScroll < maxScroll - 5;
      });
    }
  }

  @override
  void didUpdateWidget(covariant HorizontalProductList oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Re-evaluate visibility states if the product array changes from backend API
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollListener();
    });
  }

  @override
  void dispose() {
    // Dispose resources to prevent memory leak issues
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Distance metric calculated for step increments (170.w card width + 12.w padding layout)
    final double scrollStepDistance = (ProductCardWithRating.cardWidth + 12).w;

    // Parent container holding the horizontal list
    return SizedBox(
      height: widget.productWithRating
          ? ProductCardWithRating.cardHeight.h
          : ProductCardWithoutRating.cardHeight.h,
      child: Stack(
        clipBehavior: Clip
            .hardEdge, // Prevents buttons from being painted outside bounds during slide animation
        children: [
          ListView.builder(
            controller: _scrollController, // Attach controller configuration
            scrollDirection: Axis.horizontal, // Enables horizontal scrolling
            physics:
                const BouncingScrollPhysics(), // Native smooth bounce effect
            itemCount: widget.products.length,

            itemBuilder: (context, index) {
              return Padding(
                // Adds horizontal spacing between each product item
                padding: EdgeInsets.only(right: 12.w),
                child: widget.productWithRating
                    ? ProductCardWithRating(product: widget.products[index])
                    : ProductCardWithoutRating(product: widget.products[index]),
              );
            },
          ),

          //* 1. ANIMATED LEFT BUTTON OVERLAY (Slides in/out from the left edge)
          AnimatedPositioned(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOut,
            left: _showLeftButton
                ? 16.w
                : -50.w, // Moves off-screen to the left when hidden
            top: 0,
            bottom: 0,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 250),
              opacity: _showLeftButton
                  ? 1.0
                  : 0.0, // Smooth fade-out transition
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    double targetScrollDestination =
                        _scrollController.offset - scrollStepDistance;

                    if (targetScrollDestination <
                        _scrollController.position.minScrollExtent) {
                      targetScrollDestination =
                          _scrollController.position.minScrollExtent;
                    }

                    _scrollController.animateTo(
                      targetScrollDestination,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  //* The left arrow button
                  child: Container(
                    width: 40.r,
                    height: 40.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.onPrimary.withOpacity(
                        0.5,
                      ), // Semi-transparent glass effect
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.textPrimary.withOpacity(0.05),
                          blurRadius: 4.r,
                          spreadRadius: 1.r,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons
                          .arrow_back_ios_new_rounded, // Backward pointing icon asset
                      size: 16.r,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ),

          //* 2. ANIMATED RIGHT BUTTON OVERLAY (Slides in/out from the right edge)
          AnimatedPositioned(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOut,
            right: _showRightButton
                ? 16.w
                : -50.w, // Moves off-screen to the right when hidden
            top: 0,
            bottom: 0,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 250),
              opacity: _showRightButton
                  ? 1.0
                  : 0.0, // Smooth fade-out transition
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    if (widget.onNextPressed != null) {
                      widget.onNextPressed!();
                    }

                    double targetScrollDestination =
                        _scrollController.offset + scrollStepDistance;

                    if (targetScrollDestination >
                        _scrollController.position.maxScrollExtent) {
                      targetScrollDestination =
                          _scrollController.position.maxScrollExtent;
                    }

                    _scrollController.animateTo(
                      targetScrollDestination,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  //* The right arrow button
                  child: Container(
                    width: 40.r,
                    height: 40.r,
                    decoration: BoxDecoration(
                      shape: BoxShape
                          .circle, // Circular shape wrapper design match
                      color: AppColors.onPrimary.withOpacity(
                        0.5,
                      ), // Semi-transparent look
                      boxShadow: [
                        // Subtle shadow barrier layer to guarantee visible separation
                        BoxShadow(
                          color: AppColors.textPrimary.withOpacity(0.05),
                          blurRadius: 4.r,
                          spreadRadius: 1.r,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons
                          .arrow_forward_ios_rounded, // Arrow styling vector representation
                      size: 16.r, // Fully responsive icon sizing metrics
                      color: AppColors
                          .textPrimary, // High contrast text/icon color variant
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
