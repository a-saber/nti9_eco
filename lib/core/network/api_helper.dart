import 'package:dio/dio.dart';

import 'end_points.dart';

String? accessToken;
String? refreshToken;

class ApiHelper {
  Dio _dio = Dio(BaseOptions(baseUrl: EndPoints.baseUrl));

  Future<Response> postRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    bool isFormData = true,
    bool isPrivate = false,
  }) async {
    return _dio.post(
      endPoint,
      data: data != null
          ? isFormData
                ? FormData.fromMap(data)
                : data
          : null,
      options: Options(
        headers: {if (isPrivate) 'Authorization': 'Bearer $accessToken'},
      ),
    );
  }

  Future<Response> getRequest({
    required String endPoint,
    Map<String, dynamic>? queryParams,
    bool isPrivate = false,
  }) async {
    return _dio.get(
      endPoint,
      queryParameters: queryParams,
      options: Options(
        headers: {if (isPrivate) 'Authorization': 'Bearer $accessToken'},
      ),
    );
  }

  String handleException(Object e) {
    String errorMsg;
    if (e is DioException) {
      print(e.response?.data);
      if (e.response?.data != null) {
        var errorResponse = e.response?.data as Map<String, dynamic>;
        errorMsg = errorResponse['message'];
      } else {
        errorMsg = 'Network error happened try again later';
      }
    } else {
      print(e.toString());
      errorMsg = 'error happened try again later';
    }
    return errorMsg;
  }
}
