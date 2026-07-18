import 'category.dart';

class ProductModel {
  final num id;
  final String title;
  final String? slug;
  final num price;
  final String description;
  final Category? category;
  final List<String> images;
  final DateTime? creationAt;
  final DateTime? updatedAt;

  const ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.images,
    this.slug,
    this.category,
    this.creationAt,
    this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json['id'] as num,
    title: json['title'] as String,
    slug: json['slug'] as String,
    price: json['price'] as num,
    description: json['description'] as String,
    category: json['category'] == null
        ? null
        : Category.fromJson(json['category'] as Map<String, dynamic>),
    images: List<String>.from(json['images']),
    creationAt: json['creationAt'] == null
        ? null
        : DateTime.parse(json['creationAt'] as String),
    updatedAt: json['updatedAt'] == null
        ? null
        : DateTime.parse(json['updatedAt'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'slug': slug,
    'price': price,
    'description': description,
    'category': category?.toJson(),
    'images': images,
    'creationAt': creationAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
  };
}
