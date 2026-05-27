import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/networking/dio_consumer.dart';
import 'package:stylish/core/utils/app_constants.dart';
import 'package:stylish/config/routing/app_router.dart';
import 'package:stylish/config/services/services_locator.dart';
import 'package:stylish/config/theme/light_theme.dart' as theme;
import 'package:stylish/features/Auth/data/repositories/user_repo.dart';
import 'package:stylish/features/Auth/presentation/view_models/user_cubit.dart';
import 'package:stylish/generated/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();

  runApp(
    BlocProvider(
      create: (context) => UserCubit(
        userRepo: UserRepo(dioConsumer: DioConsumer(dio: getIt<Dio>())),
      ),
      child: const Stylish(),
    ),
  );
}

class Stylish extends StatelessWidget {
  const Stylish({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
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
    );
  }
}
