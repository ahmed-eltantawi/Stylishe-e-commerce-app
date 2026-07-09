import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:stylish/core/functions/show_custom_dialog.dart';
import 'package:stylish/core/payment/paymob/paymob_interface.dart';
import 'package:stylish/core/payment/stripe/stripe_manager.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/core/utils/app_text_styles.dart';

class CheckoutBottomSheet extends StatefulWidget {
  const CheckoutBottomSheet({
    super.key,
    required this.amount,
    required this.currency,
    required this.onSuccess,
  });

  final double amount;
  final String currency;
  final VoidCallback onSuccess;

  @override
  State<CheckoutBottomSheet> createState() => _CheckoutBottomSheetState();
}

class _CheckoutBottomSheetState extends State<CheckoutBottomSheet> {
  bool _isLoading = false;

  void _handlePayment(Future<dynamic> Function() paymentMethod) async {
    setState(() => _isLoading = true);
    final result = await paymentMethod();
    setState(() => _isLoading = false);

    result.fold(
      (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error), backgroundColor: AppColors.error),
        );
      },
      (_) {
        // Payment successful
        context.pop(); // Close bottom sheet
        showCustomDialog(
          context: context,
          title: 'Success!',
          message: 'Your order has been placed successfully.',
          buttonTitle: 'Continue Shopping',
          icon: Icons.check_circle_outline_rounded,
          onPressed: () {
            context.pop(); // Close dialog
            widget.onSuccess();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Checkout Summary',
              style: AppTextStyles.semiBold18,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Amount:', style: AppTextStyles.regular14),
                Text(
                  '${widget.amount.toStringAsFixed(2)} ${widget.currency}',
                  style: AppTextStyles.semiBold18.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 32.h),
            Text(
              'Select Payment Method',
              style: AppTextStyles.semiBold14,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              )
            else ...[
              ElevatedButton.icon(
                onPressed: () => _handlePayment(
                  () => StripeManager().makePayment(
                    context: context,
                    amount: widget.amount,
                    currency: widget.currency,
                  ),
                ),
                icon: const Icon(Icons.credit_card, color: Colors.white),
                label: Text(
                  'Pay with Stripe',
                  style: AppTextStyles.semiBold14.copyWith(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(
                    0xFF635BFF,
                  ), // Stripe brand color
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              ElevatedButton.icon(
                onPressed: () => _handlePayment(
                  () => PaymobManager().makePayment(
                    context: context,
                    amount: widget.amount,
                    currency: widget.currency,
                  ),
                ),
                icon: const Icon(
                  Icons.account_balance_wallet,
                  color: Colors.white,
                ),
                label: Text(
                  'Pay with Paymob',
                  style: AppTextStyles.semiBold14.copyWith(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(
                    0xFF0075FF,
                  ), // Paymob brand color
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
            ],
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}

Future<void> showCheckoutBottomSheet({
  required BuildContext context,
  required double amount,
  required String currency,
  required VoidCallback onSuccess,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => CheckoutBottomSheet(
      amount: amount,
      currency: currency,
      onSuccess: onSuccess,
    ),
  );
}
