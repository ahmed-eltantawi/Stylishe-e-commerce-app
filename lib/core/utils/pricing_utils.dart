abstract class PricingUtils {
  static const int discountPercent = 40;

  static double discountedPrice(num originalPrice) =>
      originalPrice.toDouble() * (1 - discountPercent / 100);

  static double priceBeforeDiscount(num originalPrice) =>
      originalPrice.toDouble() * (discountPercent / 100) +
      originalPrice.toDouble();

  static String formatPrice(num price) =>
      '₹${price.toStringAsFixed(0)}';
}
