import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/features/home/data/models/product_model/product_model.dart';
import 'package:stylish/features/home/presentation/views/widgets/categories_bar.dart';
import 'package:stylish/features/home/presentation/views/widgets/custom_filter_bar.dart';
import 'package:stylish/features/home/presentation/views/widgets/custom_search_bar.dart';
import 'package:stylish/features/home/presentation/views/widgets/custom_section_banner.dart';
import 'package:stylish/features/home/presentation/views/widgets/horizontal_product_list.dart';
import 'package:stylish/features/home/presentation/views/widgets/promo_banner_card.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return
    // some padding around the page
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child:
          // ListView that contains all the widgets in homebody
          ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              //* --- Search Bar ---
              _CustomSizedBox(),
              CustomSearchBar(textEditingController: TextEditingController()),

              //* --- Filter bar ---
              _CustomSizedBox(),
              CustomFilterBar(),

              //* --- Categories ---
              _CustomSizedBox(),
              CategoriesBar(),

              //* --- First Promo Banner ---
              _CustomSizedBox(),
              PromoBannerCardPageView(),

              //* --- deal of the day ---
              _CustomSizedBox(),
              CustomSectionBanner(
                title: 'Deal of the Day',
                subtitle: '22h 55m 20s remaining',
                subtitleIcon: Icons.alarm,
                backgroundColor: AppColors.blueBanner,
                onViewAllPressed: () {},
              ),

              //* --- products ---
              _CustomSizedBox(),
              HorizontalProductList(
                productWithRating: true,
                products: [
                  ProductModel(
                    id: 4,
                    title: 'Women T-Shirt',
                    price: 150,
                    description:
                        "A short-sleeve T-shirt for women. Made of 100% cotton. High quality, soft and comfortable.",
                    images: [
                      "https://img.freepik.com/free-photo/stylish-woman-wearing-casual-clothes_23-2148824019.jpg?w=2000",
                    ],
                  ),
                  ProductModel(
                    id: 4,
                    title: 'Women T-Shirt',
                    price: 150,
                    description:
                        "A short-sleeve T-shirt for women. Made of 100% cotton. High quality, soft and comfortable.",
                    images: [
                      "https://img.freepik.com/free-photo/stylish-woman-wearing-casual-clothes_23-2148824019.jpg?w=2000",
                    ],
                  ),
                  ProductModel(
                    id: 4,
                    title: 'Women T-Shirt',
                    price: 150,
                    description:
                        "A short-sleeve T-shirt for women. Made of 100% cotton. High quality, soft and comfortable.",
                    images: [
                      "https://img.freepik.com/free-photo/stylish-woman-wearing-casual-clothes_23-2148824019.jpg?w=2000",
                    ],
                  ),
                  ProductModel(
                    id: 4,
                    title: 'Women T-Shirt',
                    price: 150,
                    description:
                        "A short-sleeve T-shirt for women. Made of 100% cotton. High quality, soft and comfortable.",
                    images: [
                      "https://img.freepik.com/free-photo/stylish-woman-wearing-casual-clothes_23-2148824019.jpg?w=2000",
                    ],
                  ),
                ],
              ),

              //*  --- Special Offers ---
              _CustomSizedBox(),

              //* --- Big Advertisement component ---
              _CustomSizedBox(),

              //* --- Trending products ---
              _CustomSizedBox(),

              //* --- products ---
              _CustomSizedBox(),

              //* --- Big Advertisement component ---
              _CustomSizedBox(),

              //* --- Sponsored ---
              _CustomSizedBox(),
            ],
          ),
    );
  }
}

class _CustomSizedBox extends StatelessWidget {
  /// custom sized box to make all the widgets have the same space in upper
  const _CustomSizedBox();
  final double height = 16;
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height.h);
  }
}
