import 'package:nti9_eco/features/home/data/models/product_model.dart';

class CartItemModel {
  ProductModel productModel;
  int quantity;

  CartItemModel({required this.productModel, this.quantity = 1});
}
