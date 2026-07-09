import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylish/core/utils/app_colors.dart';
import 'package:stylish/core/utils/app_text_styles.dart';
import 'package:stylish/features/categories/data/models/category_model.dart';
import 'package:stylish/features/products/data/models/create_product_request.dart';
// TODO: consider extracting to a shared/core model if more features need it
import 'package:stylish/features/home/data/models/product_model/product_model.dart';

/// Reusable form widget shared between Add and Edit product views.
/// [initialProduct] is non-null when editing; null when adding.
class ProductFormWidget extends StatefulWidget {
  const ProductFormWidget({
    super.key,
    required this.categories,
    required this.onSubmit,
    required this.isLoading,
    required this.submitLabel,
    this.initialProduct,
  });

  final List<CategoryModel> categories;
  final void Function(CreateProductRequest request) onSubmit;
  final bool isLoading;
  final String submitLabel;
  final ProductModel? initialProduct;

  @override
  State<ProductFormWidget> createState() => _ProductFormWidgetState();
}

class _ProductFormWidgetState extends State<ProductFormWidget> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleCtrl;
  late final TextEditingController _priceCtrl;
  late final TextEditingController _descCtrl;
  late final TextEditingController _imageCtrl;
  CategoryModel? _selectedCategory;

  @override
  void initState() {
    super.initState();
    final p = widget.initialProduct;
    _titleCtrl = TextEditingController(text: p?.title ?? '');
    _priceCtrl =
        TextEditingController(text: p != null ? p.price.toString() : '');
    _descCtrl = TextEditingController(text: p?.description ?? '');
    _imageCtrl = TextEditingController(
        text: (p?.images.isNotEmpty == true) ? p!.images.first : '');

    // Pre-select category when editing
    if (p?.category?.id != null && widget.categories.isNotEmpty) {
      _selectedCategory = widget.categories
          .where((c) => c.id == p!.category!.id!.toInt())
          .firstOrNull;
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _priceCtrl.dispose();
    _descCtrl.dispose();
    _imageCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a category')),
      );
      return;
    }

    widget.onSubmit(
      CreateProductRequest(
        title: _titleCtrl.text.trim(),
        price: double.tryParse(_priceCtrl.text.trim()) ?? 0,
        description: _descCtrl.text.trim(),
        categoryId: _selectedCategory!.id,
        images: [_imageCtrl.text.trim()],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Title ──────────────────────────────────────────────────
          _fieldLabel('Product Title'),
          SizedBox(height: 6.h),
          _buildTextFormField(
            controller: _titleCtrl,
            hintText: 'e.g. Nike Air Max',
            action: TextInputAction.next,
            validator: (v) =>
                v!.trim().isEmpty ? 'Please enter a product title' : null,
          ),
          SizedBox(height: 16.h),

          // ── Price ──────────────────────────────────────────────────
          _fieldLabel('Price'),
          SizedBox(height: 6.h),
          _buildTextFormField(
            controller: _priceCtrl,
            hintText: 'e.g. 99.99',
            action: TextInputAction.next,
            keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
            ],
            validator: (v) {
              if (v!.trim().isEmpty) return 'Please enter a price';
              if (double.tryParse(v.trim()) == null) {
                return 'Please enter a valid price';
              }
              return null;
            },
          ),
          SizedBox(height: 16.h),

          // ── Description ────────────────────────────────────────────
          _fieldLabel('Description'),
          SizedBox(height: 6.h),
          _buildTextFormField(
            controller: _descCtrl,
            hintText: 'Product description...',
            action: TextInputAction.next,
            maxLines: 4,
            validator: (v) =>
                v!.trim().isEmpty ? 'Please enter a description' : null,
          ),
          SizedBox(height: 16.h),

          // ── Image URL ──────────────────────────────────────────────
          _fieldLabel('Image URL'),
          SizedBox(height: 6.h),
          _buildTextFormField(
            controller: _imageCtrl,
            hintText: 'https://example.com/image.png',
            action: TextInputAction.done,
            keyboardType: TextInputType.url,
            validator: (v) =>
                v!.trim().isEmpty ? 'Please enter an image URL' : null,
          ),
          SizedBox(height: 16.h),

          // ── Category Dropdown ──────────────────────────────────────
          _fieldLabel('Category'),
          SizedBox(height: 6.h),
          _buildCategoryDropdown(),
          SizedBox(height: 32.h),

          // ── Submit Button ──────────────────────────────────────────
          SizedBox(
            width: double.infinity,
            height: 55.h,
            child: ElevatedButton(
              onPressed: widget.isLoading ? null : _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                disabledBackgroundColor: AppColors.primary.withOpacity(0.6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: widget.isLoading
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 2.5),
                    )
                  : Text(widget.submitLabel,
                      style: AppTextStyles.semiBold20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _fieldLabel(String text) => Text(
        text,
        style: AppTextStyles.semiBold14.copyWith(color: AppColors.textPrimary),
      );

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String hintText,
    required TextInputAction action,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    int maxLines = 1,
  }) {
    final border = OutlineInputBorder(
      borderSide: BorderSide(width: 1.w, color: AppColors.border),
      borderRadius: BorderRadius.circular(10.r),
    );
    return TextFormField(
      controller: controller,
      textInputAction: action,
      validator: validator,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyles.medium12,
        fillColor: AppColors.disabled,
        filled: true,
        border: border,
        enabledBorder: border,
        focusedBorder: border.copyWith(
          borderSide: BorderSide(width: 1.5.w, color: AppColors.primary),
        ),
        errorBorder: border.copyWith(
          borderSide: BorderSide(width: 1.w, color: AppColors.error),
        ),
        focusedErrorBorder: border.copyWith(
          borderSide: BorderSide(width: 1.5.w, color: AppColors.error),
        ),
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    final border = OutlineInputBorder(
      borderSide: BorderSide(width: 1.w, color: AppColors.border),
      borderRadius: BorderRadius.circular(10.r),
    );
    return DropdownButtonFormField<CategoryModel>(
      value: _selectedCategory,
      isExpanded: true,
      hint: Text('Select a category', style: AppTextStyles.medium12),
      decoration: InputDecoration(
        fillColor: AppColors.disabled,
        filled: true,
        border: border,
        enabledBorder: border,
        focusedBorder: border.copyWith(
          borderSide: BorderSide(width: 1.5.w, color: AppColors.primary),
        ),
      ),
      items: widget.categories
          .map((cat) => DropdownMenuItem<CategoryModel>(
                value: cat,
                child: Text(cat.name,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.medium12
                        .copyWith(color: AppColors.textPrimary)),
              ))
          .toList(),
      onChanged: (cat) => setState(() => _selectedCategory = cat),
    );
  }
}
