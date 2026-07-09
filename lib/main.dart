import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/config/routing/app_routes.dart';
import 'package:stylish/core/networking/api_interceptor.dart';
import 'package:stylish/core/utils/app_constants.dart';
import 'package:stylish/config/routing/app_router.dart';
import 'package:stylish/config/services/services_locator.dart';
import 'package:stylish/config/theme/light_theme.dart' as theme;
import 'package:stylish/generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish/features/cart/data/repositories/cart_repo.dart';
import 'package:stylish/features/cart/presentation/manager/cart_cubit/cart_cubit.dart';
import 'package:stylish/features/home/presentation/manager/nav_cubit/nav_cubit.dart';
import 'package:stylish/features/wishlist/data/repositories/wishlist_repo.dart';
import 'package:stylish/features/wishlist/presentation/manager/wishlist_cubit/wishlist_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();

  runApp(const Stylish());
}

class Stylish extends StatefulWidget {
  const Stylish({super.key});

  @override
  State<Stylish> createState() => _StylishState();
}

class _StylishState extends State<Stylish> {
  late StreamSubscription<AuthEvent> _authSubscription;

  @override
  void initState() {
    super.initState();

    _authSubscription = AuthEventBus.instance.stream.listen((event) {
      if (event == AuthEvent.logout) {
        AppRouter.router.go(AppRoutes.kLoginView);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => NavCubit(),
          ),
          BlocProvider(
            create: (context) => CartCubit(cartRepo: getIt<CartRepo>())..loadCart(),
          ),
          BlocProvider(
            create: (context) =>
                WishlistCubit(wishlistRepo: getIt<WishlistRepo>())..loadWishlist(),
          ),
        ],
        child: MaterialApp.router(
          locale: const Locale(AppConstants.languageCode),
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          debugShowCheckedModeBanner: false,
          theme: theme.lightTheme,
          routerConfig: AppRouter.router,
        ),
      ),
    );
  }
}
