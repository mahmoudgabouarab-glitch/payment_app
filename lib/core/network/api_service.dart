import 'package:dio/dio.dart';
import 'package:payment_app/core/network/api_keys.dart';

import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiServise {
  final String _baseurl = "https://api.stripe.com/v1/";
  final Dio _dio;
  ApiServise(this._dio) {
    _dio.options.headers = {"Accept": "application/json"};
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['Authorization'] = 'Bearer ${ApiKeys.secretKey}';
        },
      ),
    );
    _dio.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );
  }

  Future<Map<String, dynamic>> get({
    required String endpoint,
    Options? options,
    Map<String, dynamic>? queryParameters,
  }) async {
    var response = await _dio.get(
      "$_baseurl$endpoint",
      options: options,
      queryParameters: queryParameters,
    );

    return response.data;
  }

  Future<Map<String, dynamic>> post({
    required String endpoint,
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    dynamic postData = data;
    if (data is Map<String, dynamic>) {
      bool hasFile = data.values.any((v) => v is MultipartFile);
      if (hasFile) {
        postData = FormData.fromMap(data);
      }
    }
    final response = await _dio.post(
      "$_baseurl$endpoint",
      data: postData,
      queryParameters: queryParameters,
    );
    return response.data;
  }

  Future<Map<String, dynamic>> delete({
    required String endpoint,
    Object? data,
  }) async {
    dynamic postData = data;
    if (data is Map<String, dynamic>) {
      bool hasFile = data.values.any((v) => v is MultipartFile);
      if (hasFile) {
        postData = FormData.fromMap(data);
      }
    }
    final response = await _dio.delete("$_baseurl$endpoint", data: postData);
    return response.data;
  }
}
