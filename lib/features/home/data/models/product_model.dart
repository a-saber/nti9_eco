import 'package:nti9_eco/features/home/data/models/category_model.dart';

class GetProductsResponseModel {
  List<ProductModel>? products;
  bool? status;

  GetProductsResponseModel({this.products, this.status});

  GetProductsResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['best_seller_products'] != null) {
      products = [];
      json['best_seller_products'].forEach((v) {
        products!.add(ProductModel.fromJson(v));
      });
    }
    status = json['status'];
  }

}

class ProductModel {
  bool? isBestSeller;
  bool? isFavorite;
  String? description;
  String? imagePath;
  String? name;
  int? id;
  double? rating;
  double? price;
  CategoryModel? categoryModel;

  ProductModel({
    this.id,
    this.imagePath,
    this.description,
    this.name,
    this.price,
    this.isBestSeller,
    this.isFavorite,
    this.rating,
    this.categoryModel
  });
  ProductModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    imagePath = json['image_path'];
    isBestSeller = json['best_seller'] == 1;
    description = json['description'];
    isFavorite = json['is_favorite'];
    name = json['name'];
    price = json['price'];
    rating = json['rating'];
    if(json['category'] != null){
      categoryModel = CategoryModel.fromJson(json['category']);
    }

  }

}