class LoginResponseModel {
  String? accessToken;
  String? refreshToken;
  bool? status;
  UserModel? userModel;

  LoginResponseModel({
    this.accessToken,
    this.refreshToken,
    this.status,
    this.userModel,
  });
  LoginResponseModel.fromJson(Map<String, dynamic> json){
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    status = json['status'];
    userModel = UserModel.fromJson(json['user']);
  }


}
class UserModel{
  String? email;
  List? favouriteProducts;
  int? id;
  String? imagePath;
  String? name;
  String? phone;

  UserModel({
    this.email,
    this.favouriteProducts,
    this.id,
    this.imagePath,
    this.name,
    this.phone,
  });

  UserModel.fromJson(Map<String, dynamic> json){
    email = json['email'];
    favouriteProducts = json['favorite_products'];
    id = json['id'];
    imagePath = json['image_path'];
    name = json['name'];
    phone = json['phone'];
  }
}