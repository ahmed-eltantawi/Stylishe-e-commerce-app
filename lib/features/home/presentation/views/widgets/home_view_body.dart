import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/functions/show_snack_bar_function.dart';
import 'package:stylish/core/utils/app_assets.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/features/home/data/models/product_model/product_model.dart';
import 'package:stylish/features/home/presentation/manager/cubit/products_cubit.dart';
import 'package:stylish/features/home/presentation/manager/nav_cubit/nav_cubit.dart';
import 'package:stylish/features/home/presentation/views/widgets/Products_list_loading.dart';
import 'package:stylish/features/home/presentation/views/widgets/Second_big_ad_banner.dart';
import 'package:stylish/features/home/presentation/views/widgets/big_ad_banner.dart';
import 'package:stylish/features/home/presentation/views/widgets/categories_bar.dart';
import 'package:stylish/features/home/presentation/views/widgets/custom_filter_bar.dart';
import 'package:stylish/features/home/presentation/views/widgets/custom_search_bar.dart';
import 'package:stylish/features/home/presentation/views/widgets/custom_section_banner.dart';
import 'package:stylish/features/home/presentation/views/widgets/horizontal_product_list.dart';
import 'package:stylish/features/home/presentation/views/widgets/promo_banner_card.dart';
import 'package:stylish/features/home/presentation/views/widgets/special_offer_banner.dart';
import 'package:stylish/features/home/presentation/views/widgets/sponsered_ad_banner.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  @override
  void initState() {
    super.initState();
    context.read<ProductsCubit>().fetchProducts();
  }

  List<ProductModel> products = [];
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
              _StaticSizedBox(),
              GestureDetector(
                onTap: () => context.read<NavCubit>().selectTab(3),
                behavior: HitTestBehavior.opaque,
                child: AbsorbPointer(
                  child: CustomSearchBar(textEditingController: TextEditingController()),
                ),
              ),

              //* --- Filter bar ---
              _StaticSizedBox(),
              CustomFilterBar(),

              //* --- Categories ---
              _StaticSizedBox(),
              CategoriesBar(),

              //* --- First Promo Banner ---
              _StaticSizedBox(),
              PromoBannerCardPageView(),

              //* --- deal of the day ---
              _StaticSizedBox(),
              CustomSectionBanner(
                title: 'Deal of the Day',
                subtitle: '22h 55m 20s remaining',
                subtitleIcon: Icons.alarm,
                backgroundColor: AppColors.blueBanner,
                onViewAllPressed: () => context.read<NavCubit>().selectTab(3),
              ),

              //* --- products ---
              _StaticSizedBox(),
              BlocConsumer<ProductsCubit, ProductsState>(
                listener: (context, state) {
                  if (state is ProductsFailure ||
                      state is ProductsPaginationFailure) {
                    final String message = switch (state) {
                      ProductsFailure state => state.errorMessage,
                      ProductsPaginationFailure state => state.errorMessage,
                      _ => '',
                    };
                    showSnackBar(context, message: message);
                  }
                },
                builder: (context, state) {
                  if (state is ProductsLoading) {
                    return const ProductsListLoading();
                  } else if (state is ProductsSuccess ||
                      state is ProductsPaginationLoading ||
                      state is ProductsPaginationFailure) {
                    products = switch (state) {
                      ProductsSuccess state => state.products,
                      ProductsPaginationLoading state => state.currentProducts,
                      ProductsPaginationFailure state => state.currentProducts,
                      _ => [],
                    };

                    final isPaginationLoading =
                        state is ProductsPaginationLoading;

                    final int shimmerCount = isPaginationLoading ? 1 : 0;

                    return HorizontalProductList(
                      shimmerCount: shimmerCount,
                      isProductsWithRating: true,
                      products: products,
                    );
                  } else {
                    return Container();
                  }
                },
              ),

              //*  --- Special Offers ---
              _StaticSizedBox(),
              SpecialOfferBanner(),

              //* --- Big Advertisement component ---
              _StaticSizedBox(),
              BigAdBanner(
                image: Assets.imagesHealsBannerAd,
                title: 'Flat and Heels',
                subtitle: 'Stand a chance to get rewarded',
                action: () => context.read<NavCubit>().selectTab(3),
              ),

              //* --- Trending products ---
              _StaticSizedBox(),
              CustomSectionBanner(
                title: 'Trending Products',
                subtitle: 'Last Date 29/02/22',
                subtitleIcon: Icons.calendar_month,
                backgroundColor: AppColors.pinkBanner,
                onViewAllPressed: () => context.read<NavCubit>().selectTab(3),
              ),

              //* --- products ---
              _StaticSizedBox(),

              BlocConsumer<ProductsCubit, ProductsState>(
                listener: (context, state) {
                  if (state is ProductsFailure) {
                    showSnackBar(context, message: state.errorMessage);
                  } else if (state is ProductsPaginationFailure) {
                    showSnackBar(context, message: state.errorMessage);
                  }
                },
                builder: (context, state) {
                  if (state is ProductsLoading && products.isEmpty) {
                    return const ProductsListLoading();
                  } else {
                    final trendingProducts = products.length > 5
                        ? products.skip(5).toList()
                        : products;
                    if (trendingProducts.isEmpty && state is ProductsLoading) {
                       return const ProductsListLoading();
                    }
                    return HorizontalProductList(
                      isProductsWithRating: false,
                      products: trendingProducts,
                    );
                  }
                },
              ),
              //* --- Big Advertisement component ---
              _StaticSizedBox(),
              SecondBigAdBanner(
                image:
                    "https://media.istockphoto.com/id/1151038023/vector/hot-summer-sale-promotional-banner.jpg?s=612x612&w=0&k=20&c=xrop9zb18RQVW0YmaTz2fVW_pNMx58z5qmhSvdWzZb0=",
                title: "New Arrival",
                subtitle: "Summer' 25 Collections",
                onPressed: () => context.read<NavCubit>().selectTab(3),
              ),

              //* --- Sponsored ---
              _StaticSizedBox(),
              SponsoredBanner(
                imageUrl:
                    "https://img.tineye.com/result/f8d4ea66adb44af07886241b9e3aba9196c00d3bc2ea39448d0adfa1ec126027-56?size=160",
                onPressed: () {},
                title: 'up to 50% Off',
              ),
            ],
          ),
    );
  }
}

class _StaticSizedBox extends StatelessWidget {
  /// custom sized box to make all the widgets have the same space in upper
  /// with height of 16
  const _StaticSizedBox();
  final double height = 16;
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height.h);
  }
}
