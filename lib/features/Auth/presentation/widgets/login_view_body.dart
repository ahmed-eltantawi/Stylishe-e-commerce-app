import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stylish/core/functions/show_snack_bar_function.dart';
import 'package:stylish/core/routing/app_routes.dart';
import 'package:stylish/core/widgets/custom_button.dart';
import 'package:stylish/features/Auth/presentation/view_models/user_cubit.dart';
import 'package:stylish/features/Auth/presentation/widgets/lower_text_widget.dart';
import 'package:stylish/features/Auth/presentation/widgets/forget_password_text_widget.dart';
import 'package:stylish/features/Auth/presentation/widgets/login_form_widget.dart';
import 'package:stylish/features/Auth/presentation/widgets/social_accounts_widgets.dart';
import 'package:stylish/features/Auth/presentation/widgets/custom_title_screen_widget.dart';
import 'package:stylish/generated/l10n.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .symmetric(horizontal: 30.w),
      child: Column(
        children: [
          //* --- Title ---
          SizedBox(height: 20.h),
          CustomTitleScreenWidget(title: S.of(context).welcomeBack),

          //* --- Form ---
          SizedBox(height: 36.h),
          LoginFormWidget(),

          //* --- Forget Password text ---
          SizedBox(height: 9.h),
          ForgetPasswordTextWidget(),

          //* --- Login Button ---
          SizedBox(height: 52.h),
          BlocConsumer<UserCubit, UserState>(
            listener: (context, state) {
              // listen to state
              if (state is UserGetDataSuccess) {
                context.go(AppRoutes.kHomeView);
              }

              // Show error in Snack bar on the screen
              if (state is UserSignInFailure) {
                showSnackBar(context, message: state.errorMessage);
              }
              if (state is UserGetDataFailure) {
                showSnackBar(context, message: state.errorMessage);
              }
            },
            builder: (context, state) {
              return state is UserSignInLoading
                  ? const CircularProgressIndicator()
                  : CustomButton(
                      onPressed: () {
                        if (context
                            .read<UserCubit>()
                            .formKeySignin
                            .currentState!
                            .validate()) {
                          context.read<UserCubit>().signin();
                        }
                      },
                      title: S.of(context).login,
                    );
            },
          ),
          //* --- Social Login ---
          SizedBox(height: 75.h),
          SocialAccountsWidget(),

          //* --- Create an account ---
          SizedBox(height: 30.h),
          LowerTextWidget(
            normalText: "Create An Account",
            boldText: "Sign Up",
            pageRoute: AppRoutes.kRegisterView,
          ),
        ],
      ),
    );
  }
}
