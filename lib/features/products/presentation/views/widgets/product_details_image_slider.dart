import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:stylish/core/utils/app_colors.dart';

class ProductDetailsImageSlider extends StatefulWidget {
  const ProductDetailsImageSlider({super.key, required this.images});

  final List<String> images;

  @override
  State<ProductDetailsImageSlider> createState() =>
      _ProductDetailsImageSliderState();
}

class _ProductDetailsImageSliderState
    extends State<ProductDetailsImageSlider> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── Image PageView ────────────────────────────────────────────
        SizedBox(
          height: 280.h,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            itemCount: widget.images.isEmpty ? 1 : widget.images.length,
            itemBuilder: (context, index) {
              if (widget.images.isEmpty) return _buildPlaceholder();
              return ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: CachedNetworkImage(
                  imageUrl: widget.images[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(color: AppColors.primary)),
                  errorWidget: (context, url, error) => _buildPlaceholder(),
                ),
              );
            },
          ),
        ),

        // ── Dot Indicators ────────────────────────────────────────────
        if (widget.images.length > 1)
          Padding(
            padding: EdgeInsets.only(top: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.images.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: EdgeInsets.symmetric(horizontal: 3.w),
                  width: _currentIndex == index ? 16.w : 8.w,
                  height: 6.h,
                  decoration: BoxDecoration(
                    color: _currentIndex == index
                        ? AppColors.primary
                        : AppColors.inactiveIndicator,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                );
              }),
            ),
          ),
      ],
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: context.surfaceVariant,
      child: Center(
        child: Icon(Icons.image_not_supported_outlined,
            color: context.borderColor, size: 64.r),
      ),
    );
  }
}
