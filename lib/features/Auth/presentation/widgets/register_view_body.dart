import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stylish/core/functions/show_snack_bar_function.dart';
import 'package:stylish/config/routing/app_routes.dart';
import 'package:stylish/core/widgets/custom_button.dart';
import 'package:stylish/core/functions/show_custom_dialog.dart';
import 'package:stylish/features/Auth/presentation/manager/signup_cubit/signup_cubit.dart';
import 'package:stylish/features/Auth/presentation/widgets/custom_title_screen_widget.dart';
import 'package:stylish/features/Auth/presentation/widgets/lower_text_widget.dart';
import 'package:stylish/features/Auth/presentation/widgets/register_form_widget.dart';
import 'package:stylish/features/Auth/presentation/widgets/register_subtitle_text_widget.dart';
import 'package:stylish/features/Auth/presentation/widgets/social_accounts_widgets.dart';
import 'package:stylish/generated/l10n.dart';

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({super.key});
  @override
  Widget build(BuildContext context) {
    return
    // --- Horizontal Padding around the page ---
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        children: [
          // --- Title ---
          SizedBox(height: 20.h),
          CustomTitleScreenWidget(title: S.of(context).createAnAccount),

          // --- Form ---
          SizedBox(height: 30.h),
          RegisterFormWidget(),

          // --- Subtitle text ---
          SizedBox(height: 20.h),
          RegisterSubtitleTextWidget(),

          // --- Register Button ---
          SizedBox(height: 40.h),
          BlocConsumer<SignupCubit, SignupState>(
            listener: (context, state) {
              // listen to state
              if (state is SignUpSuccess) {
                context.go(AppRoutes.kHomeView);
              }
              if (state is NoInternetConnection) {
                showNoInternetConnectionDialog(context);
              }
              // Show error in Snack bar on the screen
              if (state is SignUpFailure) {
                showSnackBar(context, message: state.errorMessage);
              }
            },
            builder: (context, state) {
              // loading indicator & button
              return state is SignUpLoading
                  ? // if loading show loading indicator
                    SizedBox(
                      height: 55.h,
                      child: FittedBox(
                        fit: .none,
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : // if not loading show button
                    CustomButton(
                      onPressed: () {
                        context.read<SignupCubit>().signUp();
                      },
                      title: S.of(context).createAnAccount,
                    );
            },
          ),

          // --- Social Login ---
          SizedBox(height: 40.h),
          SocialAccountsWidget(),

          // --- Go To Login Page ---
          SizedBox(height: 30.h),
          LowerTextWidget(
            normalText: S.of(context).iAlreadyHaveAnAccount,
            boldText: S.of(context).login,
            pageRoute: AppRoutes.kLoginView,
          ),
        ],
      ),
    );
  }
}
