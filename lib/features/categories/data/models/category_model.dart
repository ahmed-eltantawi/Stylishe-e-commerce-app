class CategoryModel {
  final int id;
  final String name;
  final String image;
  final String? slug;
  final DateTime? creationAt;
  final DateTime? updatedAt;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    this.slug,
    this.creationAt,
    this.updatedAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json['id'] as int,
    name: json['name'] as String,
    image: json['image'] as String? ?? '',
    slug: json['slug'] as String?,
    creationAt: json['creationAt'] == null
        ? null
        : DateTime.tryParse(json['creationAt'] as String),
    updatedAt: json['updatedAt'] == null
        ? null
        : DateTime.tryParse(json['updatedAt'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'image': image,
    'slug': slug,
    'creationAt': creationAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
  };
}
