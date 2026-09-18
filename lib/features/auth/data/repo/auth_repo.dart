import 'package:dartz/dartz.dart';
import 'package:nti9_eco/core/network/api_helper.dart';
import 'package:nti9_eco/core/network/end_points.dart';
import 'package:nti9_eco/features/auth/data/models/login_response_model.dart';

class AuthRepo {
  ApiHelper apiHelper = ApiHelper();

  Future<Either<String, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      var response = await apiHelper.postRequest(
        endPoint: EndPoints.login,
        data: {'email': email, 'password': password},
      );
      var jsonResponse = response.data as Map<String, dynamic>;
      LoginResponseModel model =
          LoginResponseModel.fromJson(jsonResponse);

      accessToken = model.accessToken;
      refreshToken = model.refreshToken;

      return right(model.userModel!);

    } catch (e) {
      return left(apiHelper.handleException(e));
    }
  }
}
