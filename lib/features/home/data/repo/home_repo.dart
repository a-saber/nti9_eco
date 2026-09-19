import 'package:dartz/dartz.dart';
import 'package:nti9_eco/core/network/api_helper.dart';
import 'package:nti9_eco/core/network/end_points.dart';
import 'package:nti9_eco/features/home/data/models/slider_model.dart';

class HomeRepo {
  ApiHelper apiHelper = ApiHelper();

  Future<Either<String, GetSlidersResponseModel>> getSliders() async {
    try {
      var response = await apiHelper.getRequest(endPoint: EndPoints.sliders);
      var jsonResponse = response.data as Map<String, dynamic>;
      return right(GetSlidersResponseModel.fromJson(jsonResponse));
    } catch (e) {
      return left(apiHelper.handleException(e));
    }
  }
}
