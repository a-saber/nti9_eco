import 'package:dio/dio.dart';
import 'package:nti9_eco/core/cache/cache_helper.dart';
import 'package:nti9_eco/core/cache/cache_keys.dart';

import 'end_points.dart';

class ApiHelper {
  final Dio _dio =
      Dio(
          BaseOptions(
            baseUrl: EndPoints.baseUrl,
            connectTimeout: Duration(seconds: 5),
          ),
        )
        ..interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) {
              print('------------------------------------------');
              print("Request: ${options.method} ${options.path}");
              print("Headers: ${options.headers}");
              if (options.data is FormData) {
                print((options.data as FormData).fields);
              } else {
                print("Data: ${options.data}");
              }
              print("queryParameters: ${options.queryParameters}");
              print('------------------------------------------');

              return handler.next(options);
            },
            onError: (error, handler) {
              print('------------------------------------------');
              print(
                "Error: ${error.requestOptions.path} ${error.response?.statusCode}",
              );
              print("Error: ${error.response?.data}");
              print('------------------------------------------');

              return handler.next(error);
            },
            onResponse: (response, handler) {
              print('------------------------------------------');
              print(
                "Response: ${response.requestOptions.path} ${response.statusCode}",
              );
              print("Response: ${response.data}");
              print('------------------------------------------');

              return handler.next(response);
            },
          ),
        );

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
        headers: {
          if (isPrivate)
            'Authorization':
                'Bearer ${CacheHelper.getValue(key: CacheKeys.accessToken)}',
        },
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
        headers: {
          if (isPrivate)
            'Authorization':
                'Bearer ${CacheHelper.getValue(key: CacheKeys.accessToken)}',
        },
      ),
    );
  }

  String handleException(Object e) {
    String errorMsg;
    if (e is DioException) {
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
