import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/features/home/data/models/product_model/product_model.dart';
import 'package:stylish/features/home/presentation/views/widgets/custom_navigation_button.dart';
import 'package:stylish/features/home/presentation/views/widgets/product_card.dart';
import 'package:stylish/features/home/presentation/views/widgets/product_card_without_rating.dart';

class HorizontalProductList extends StatefulWidget {
  const HorizontalProductList({
    super.key,
    this.isProductsWithRating = true,
    required this.products,
  });

  final bool isProductsWithRating;
  final List<ProductModel> products;

  @override
  State<HorizontalProductList> createState() => HorizontalProductListState();
}

class HorizontalProductListState extends State<HorizontalProductList> {
  //* Shared UI constants used across the horizontal list implementation
  static const double buttonSize = 40;
  static const double iconSize = 16;
  static const double _buttonHiddenOffset = 50;
  static const double _scrollThreshold = 5;
  static const double _itemSpacing = 12;

  static const Duration _slideDuration = Duration(milliseconds: 350);
  static const Duration _fadeDuration = Duration(milliseconds: 250);
  static const Duration _scrollDuration = Duration(milliseconds: 300);

  // Attached ScrollController to control the horizontal list programmatic movements
  final ScrollController _scrollController = ScrollController();

  // Boolean visibility control flags for the navigation arrows
  bool _showLeftButton = false;
  bool _showRightButton = false;

  double get _scrollStepDistance =>
      (ProductCardWithRating.cardWidth + _itemSpacing).w;

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
    if (!_scrollController.hasClients) return;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;

    setState(() {
      // Show left arrow only if the list has been scrolled forward
      _showLeftButton = currentScroll > _scrollThreshold;

      // Show right arrow only if the list hasn't hit the final end bounding edge
      _showRightButton = currentScroll < maxScroll - _scrollThreshold;
    });
  }

  @override
  void didUpdateWidget(covariant HorizontalProductList oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Re-evaluate visibility states if the product array changes from backend API
    if (oldWidget.products.length != widget.products.length) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollListener();
      });
    }
  }

  /// Builds the correct product card variant depending on section configuration
  Widget _buildProduct(ProductModel product) {
    return widget.isProductsWithRating
        ? ProductCardWithRating(product: product)
        : ProductCardWithoutRating(product: product);
  }

  /// Handles scroll animation while preventing overflow beyond list boundaries
  void _animateTo(double targetOffset) {
    final position = _scrollController.position;

    targetOffset = targetOffset.clamp(
      position.minScrollExtent,
      position.maxScrollExtent,
    );

    _scrollController.animateTo(
      targetOffset,
      duration: _scrollDuration,
      curve: Curves.easeInOut,
    );
  }

  /// Moves the horizontal list backward by one card width step
  void _scrollLeft() {
    _animateTo(_scrollController.offset - _scrollStepDistance);
  }

  /// Moves the horizontal list forward by one card width step
  void _scrollRight() {
    _animateTo(_scrollController.offset + _scrollStepDistance);
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
    // Parent container holding the horizontal list
    return SizedBox(
      height: widget.isProductsWithRating
          ? ProductCardWithRating.cardHeight.h
          : ProductCardWithRating.cardHeight.h,
      // : ProductCardWithoutRating.cardHeight.h,
      child: Stack(
        clipBehavior: Clip
            .hardEdge, // Prevents buttons from being painted outside bounds during slide animation
        children: [
          ListView.separated(
            controller: _scrollController, // Attach controller configuration
            scrollDirection: Axis.horizontal, // Enables horizontal scrolling
            physics:
                const BouncingScrollPhysics(), // Native smooth bounce effect
            itemCount: widget.products.length,
            itemBuilder: (context, index) {
              return _buildProduct(widget.products[index]);
            },

            // Adds horizontal spacing between each product item
            separatorBuilder: (context, index) =>
                SizedBox(width: _itemSpacing.w),
          ),

          //* 1. ANIMATED LEFT BUTTON OVERLAY (Slides in/out from the left edge)
          AnimatedPositioned(
            duration: _slideDuration,
            curve: Curves.easeInOut,
            left: _showLeftButton
                ? 16.w
                : -_buttonHiddenOffset
                      .w, // Moves off-screen to the left when hidden
            top: 0,
            bottom: 0,

            child: AnimatedOpacity(
              duration: _fadeDuration,
              opacity: _showLeftButton
                  ? 1.0
                  : 0.0, // Smooth fade-out transition
              child: Center(
                child: CustomNavigationButton(
                  icon: Icons.arrow_back_ios_new_rounded,
                  onTap: _scrollLeft,
                ),
              ),
            ),
          ),

          //* 2. ANIMATED RIGHT BUTTON OVERLAY (Slides in/out from the right edge)
          AnimatedPositioned(
            duration: _slideDuration,
            curve: Curves.easeInOut,
            right: _showRightButton
                ? 16.w
                : -_buttonHiddenOffset
                      .w, // Moves off-screen to the right when hidden
            top: 0,
            bottom: 0,

            child: AnimatedOpacity(
              duration: _fadeDuration,

              opacity: _showRightButton
                  ? 1.0
                  : 0.0, // Smooth fade-out transition
              child: Center(
                child: CustomNavigationButton(
                  icon: Icons.arrow_forward_ios_rounded,
                  onTap: _scrollRight,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
