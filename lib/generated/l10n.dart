// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Choose Products`
  String get chooseProductsTitle {
    return Intl.message(
      'Choose Products',
      name: 'chooseProductsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.`
  String get chooseProductsSubtitle {
    return Intl.message(
      'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
      name: 'chooseProductsSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Make Payment`
  String get makePaymentTitle {
    return Intl.message(
      'Make Payment',
      name: 'makePaymentTitle',
      desc: '',
      args: [],
    );
  }

  /// `Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.`
  String get makePaymentSubtitle {
    return Intl.message(
      'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
      name: 'makePaymentSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Get Your Order`
  String get getYourOrderTitle {
    return Intl.message(
      'Get Your Order',
      name: 'getYourOrderTitle',
      desc: '',
      args: [],
    );
  }

  /// `Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.`
  String get getYourOrderSubtitle {
    return Intl.message(
      'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.',
      name: 'getYourOrderSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Skip`
  String get skip {
    return Intl.message('Skip', name: 'skip', desc: '', args: []);
  }

  /// `Prev`
  String get prev {
    return Intl.message('Prev', name: 'prev', desc: '', args: []);
  }

  /// `Get Started`
  String get getStarted {
    return Intl.message('Get Started', name: 'getStarted', desc: '', args: []);
  }

  /// `Welcome\nBack!`
  String get welcomeBack {
    return Intl.message(
      'Welcome\nBack!',
      name: 'welcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Create an account`
  String get createAnAccount {
    return Intl.message(
      'Create an account',
      name: 'createAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message('Name', name: 'name', desc: '', args: []);
  }

  /// `Last Name`
  String get lastName {
    return Intl.message('Last Name', name: 'lastName', desc: '', args: []);
  }

  /// `Phone`
  String get phone {
    return Intl.message('Phone', name: 'phone', desc: '', args: []);
  }

  /// `Register`
  String get register {
    return Intl.message('Register', name: 'register', desc: '', args: []);
  }

  /// `Choose Products`
  String get chooseProducts {
    return Intl.message(
      'Choose Products',
      name: 'chooseProducts',
      desc: '',
      args: [],
    );
  }

  /// `Make Payment`
  String get makePayment {
    return Intl.message(
      'Make Payment',
      name: 'makePayment',
      desc: '',
      args: [],
    );
  }

  /// `Get Your Order`
  String get getYourOrder {
    return Intl.message(
      'Get Your Order',
      name: 'getYourOrder',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPasswordTitle {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message('Submit', name: 'submit', desc: '', args: []);
  }

  /// `We will send you a message to set or reset your new password`
  String get forgotPasswordSubtitle {
    return Intl.message(
      'We will send you a message to set or reset your new password',
      name: 'forgotPasswordSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Email Address`
  String get enterYourEmailAddress {
    return Intl.message(
      'Enter Your Email Address',
      name: 'enterYourEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `- OR Continue With -`
  String get orContinueWith {
    return Intl.message(
      '- OR Continue With -',
      name: 'orContinueWith',
      desc: '',
      args: [],
    );
  }

  /// `By clicking the`
  String get signUpSubtitle1 {
    return Intl.message(
      'By clicking the',
      name: 'signUpSubtitle1',
      desc: '',
      args: [],
    );
  }

  /// `button, you agree to the public offer`
  String get signUpSubtitle2 {
    return Intl.message(
      'button, you agree to the public offer',
      name: 'signUpSubtitle2',
      desc: '',
      args: [],
    );
  }

  /// `Username or Email`
  String get userNameOrEmail {
    return Intl.message(
      'Username or Email',
      name: 'userNameOrEmail',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message('Sign Up', name: 'signUp', desc: '', args: []);
  }

  /// `We will send you a message to set or reset your new password`
  String get forgetPasswordSubtitle {
    return Intl.message(
      'We will send you a message to set or reset your new password',
      name: 'forgetPasswordSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `I Already Have an Account`
  String get iAlreadyHaveAnAccount {
    return Intl.message(
      'I Already Have an Account',
      name: 'iAlreadyHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters`
  String get passwordMustBeAtLeast6Characters {
    return Intl.message(
      'Password must be at least 6 characters',
      name: 'passwordMustBeAtLeast6Characters',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email`
  String get pleaseEnterValidEmail {
    return Intl.message(
      'Please enter a valid email',
      name: 'pleaseEnterValidEmail',
      desc: '',
      args: [],
    );
  }

  /// `is required`
  String get isRequired {
    return Intl.message('is required', name: 'isRequired', desc: '', args: []);
  }

  /// `No internet connection`
  String get noInternetConnection {
    return Intl.message(
      'No internet connection',
      name: 'noInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Please check your internet connection and try again`
  String get pleaseCheckYourInternetConnection {
    return Intl.message(
      'Please check your internet connection and try again',
      name: 'pleaseCheckYourInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Try Again`
  String get tryAgain {
    return Intl.message('Try Again', name: 'tryAgain', desc: '', args: []);
  }

  /// `Products`
  String get products {
    return Intl.message('Products', name: 'products', desc: '', args: []);
  }

  /// `Categories`
  String get categories {
    return Intl.message('Categories', name: 'categories', desc: '', args: []);
  }

  /// `All`
  String get allCategories {
    return Intl.message('All', name: 'allCategories', desc: '', args: []);
  }

  /// `Add Product`
  String get addProduct {
    return Intl.message('Add Product', name: 'addProduct', desc: '', args: []);
  }

  /// `Edit Product`
  String get editProduct {
    return Intl.message(
      'Edit Product',
      name: 'editProduct',
      desc: '',
      args: [],
    );
  }

  /// `Delete Product`
  String get deleteProduct {
    return Intl.message(
      'Delete Product',
      name: 'deleteProduct',
      desc: '',
      args: [],
    );
  }

  /// `Product Title`
  String get productTitle {
    return Intl.message(
      'Product Title',
      name: 'productTitle',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get productPrice {
    return Intl.message('Price', name: 'productPrice', desc: '', args: []);
  }

  /// `Description`
  String get productDescription {
    return Intl.message(
      'Description',
      name: 'productDescription',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get productCategory {
    return Intl.message(
      'Category',
      name: 'productCategory',
      desc: '',
      args: [],
    );
  }

  /// `Image URL`
  String get productImageUrl {
    return Intl.message(
      'Image URL',
      name: 'productImageUrl',
      desc: '',
      args: [],
    );
  }

  /// `Product Details`
  String get productDetails {
    return Intl.message(
      'Product Details',
      name: 'productDetails',
      desc: '',
      args: [],
    );
  }

  /// `Similar Products`
  String get similarProducts {
    return Intl.message(
      'Similar Products',
      name: 'similarProducts',
      desc: '',
      args: [],
    );
  }

  /// `View All`
  String get viewAll {
    return Intl.message('View All', name: 'viewAll', desc: '', args: []);
  }

  /// `Search any Product...`
  String get search {
    return Intl.message(
      'Search any Product...',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get filter {
    return Intl.message('Filter', name: 'filter', desc: '', args: []);
  }

  /// `Sort`
  String get sort {
    return Intl.message('Sort', name: 'sort', desc: '', args: []);
  }

  /// `No products found`
  String get noProductsFound {
    return Intl.message(
      'No products found',
      name: 'noProductsFound',
      desc: '',
      args: [],
    );
  }

  /// `Loading products...`
  String get loadingProducts {
    return Intl.message(
      'Loading products...',
      name: 'loadingProducts',
      desc: '',
      args: [],
    );
  }

  /// `Delete Product`
  String get deleteProductConfirmTitle {
    return Intl.message(
      'Delete Product',
      name: 'deleteProductConfirmTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this product? This action cannot be undone.`
  String get deleteProductConfirmMessage {
    return Intl.message(
      'Are you sure you want to delete this product? This action cannot be undone.',
      name: 'deleteProductConfirmMessage',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get deleteProductConfirmButton {
    return Intl.message(
      'Delete',
      name: 'deleteProductConfirmButton',
      desc: '',
      args: [],
    );
  }

  /// `Product added successfully`
  String get productAddedSuccess {
    return Intl.message(
      'Product added successfully',
      name: 'productAddedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Product updated successfully`
  String get productUpdatedSuccess {
    return Intl.message(
      'Product updated successfully',
      name: 'productUpdatedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Product deleted successfully`
  String get productDeletedSuccess {
    return Intl.message(
      'Product deleted successfully',
      name: 'productDeletedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Please login to manage products`
  String get loginToManageProducts {
    return Intl.message(
      'Please login to manage products',
      name: 'loginToManageProducts',
      desc: '',
      args: [],
    );
  }

  /// `...More`
  String get more {
    return Intl.message('...More', name: 'more', desc: '', args: []);
  }

  /// `Less`
  String get less {
    return Intl.message('Less', name: 'less', desc: '', args: []);
  }

  /// `Items`
  String get items {
    return Intl.message('Items', name: 'items', desc: '', args: []);
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Wishlist`
  String get wishlist {
    return Intl.message('Wishlist', name: 'wishlist', desc: '', args: []);
  }

  /// `Cart`
  String get cart {
    return Intl.message('Cart', name: 'cart', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `My Wishlist`
  String get wishlistTitle {
    return Intl.message(
      'My Wishlist',
      name: 'wishlistTitle',
      desc: '',
      args: [],
    );
  }

  /// `My Cart`
  String get cartTitle {
    return Intl.message('My Cart', name: 'cartTitle', desc: '', args: []);
  }

  /// `Settings`
  String get settingsTitle {
    return Intl.message('Settings', name: 'settingsTitle', desc: '', args: []);
  }

  /// `Coming Soon`
  String get comingSoon {
    return Intl.message('Coming Soon', name: 'comingSoon', desc: '', args: []);
  }

  /// `This feature is coming soon. Stay tuned!`
  String get featureComingSoon {
    return Intl.message(
      'This feature is coming soon. Stay tuned!',
      name: 'featureComingSoon',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a product title`
  String get pleaseEnterProductTitle {
    return Intl.message(
      'Please enter a product title',
      name: 'pleaseEnterProductTitle',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid price`
  String get pleaseEnterValidPrice {
    return Intl.message(
      'Please enter a valid price',
      name: 'pleaseEnterValidPrice',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a description`
  String get pleaseEnterDescription {
    return Intl.message(
      'Please enter a description',
      name: 'pleaseEnterDescription',
      desc: '',
      args: [],
    );
  }

  /// `Please enter an image URL`
  String get pleaseEnterImageUrl {
    return Intl.message(
      'Please enter an image URL',
      name: 'pleaseEnterImageUrl',
      desc: '',
      args: [],
    );
  }

  /// `Please select a category`
  String get pleaseSelectCategory {
    return Intl.message(
      'Please select a category',
      name: 'pleaseSelectCategory',
      desc: '',
      args: [],
    );
  }

  /// `Appearance`
  String get appearance {
    return Intl.message('Appearance', name: 'appearance', desc: '', args: []);
  }

  /// `Light`
  String get light {
    return Intl.message('Light', name: 'light', desc: '', args: []);
  }

  /// `Dark`
  String get dark {
    return Intl.message('Dark', name: 'dark', desc: '', args: []);
  }

  /// `System Default`
  String get systemDefault {
    return Intl.message(
      'System Default',
      name: 'systemDefault',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `العربية`
  String get arabic {
    return Intl.message('العربية', name: 'arabic', desc: '', args: []);
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Enable Notifications`
  String get enableNotifications {
    return Intl.message(
      'Enable Notifications',
      name: 'enableNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Receive updates and offers`
  String get receiveUpdates {
    return Intl.message(
      'Receive updates and offers',
      name: 'receiveUpdates',
      desc: '',
      args: [],
    );
  }

  /// `General`
  String get general {
    return Intl.message('General', name: 'general', desc: '', args: []);
  }

  /// `Clear Cache`
  String get clearCache {
    return Intl.message('Clear Cache', name: 'clearCache', desc: '', args: []);
  }

  /// `About`
  String get about {
    return Intl.message('About', name: 'about', desc: '', args: []);
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Conditions`
  String get termsAndConditions {
    return Intl.message(
      'Terms & Conditions',
      name: 'termsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `Licenses`
  String get licenses {
    return Intl.message('Licenses', name: 'licenses', desc: '', args: []);
  }

  /// `This will clear cached images and temporary files. Your login session will remain intact.`
  String get clearCacheMessage {
    return Intl.message(
      'This will clear cached images and temporary files. Your login session will remain intact.',
      name: 'clearCacheMessage',
      desc: '',
      args: [],
    );
  }

  /// `Clear`
  String get clear {
    return Intl.message('Clear', name: 'clear', desc: '', args: []);
  }

  /// `Cache cleared successfully`
  String get cacheClearedSuccessfully {
    return Intl.message(
      'Cache cleared successfully',
      name: 'cacheClearedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Your cart is empty`
  String get cartEmptyTitle {
    return Intl.message(
      'Your cart is empty',
      name: 'cartEmptyTitle',
      desc: '',
      args: [],
    );
  }

  /// `Explore our products and add them here.`
  String get cartEmptySubtitle {
    return Intl.message(
      'Explore our products and add them here.',
      name: 'cartEmptySubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Buy Now`
  String get buyNow {
    return Intl.message('Buy Now', name: 'buyNow', desc: '', args: []);
  }

  /// `Go to Cart`
  String get goToCart {
    return Intl.message('Go to Cart', name: 'goToCart', desc: '', args: []);
  }

  /// `Add to Cart`
  String get addToCart {
    return Intl.message('Add to Cart', name: 'addToCart', desc: '', args: []);
  }

  /// `Total: `
  String get total {
    return Intl.message('Total: ', name: 'total', desc: '', args: []);
  }

  /// `Checkout`
  String get checkout {
    return Intl.message('Checkout', name: 'checkout', desc: '', args: []);
  }

  /// `Try a different search or category`
  String get tryDifferentSearch {
    return Intl.message(
      'Try a different search or category',
      name: 'tryDifferentSearch',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
