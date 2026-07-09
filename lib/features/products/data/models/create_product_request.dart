/// Request model for creating or updating a product.
/// Maps to the API body: { title, price, description, categoryId, images }
class CreateProductRequest {
  final String title;
  final num price;
  final String description;
  final int categoryId;
  final List<String> images;

  const CreateProductRequest({
    required this.title,
    required this.price,
    required this.description,
    required this.categoryId,
    required this.images,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'price': price,
    'description': description,
    'categoryId': categoryId,
    'images': images,
  };
}
