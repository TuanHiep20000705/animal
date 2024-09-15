import 'dart:convert';

import 'package:dio/dio.dart';

import '../../shared/resources/string.dart';

class ApiExceptions implements Exception {
  String message = "";
  int code = 0;

  ApiExceptions.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = exceptionCancel;
        break;
      case DioExceptionType.connectionTimeout:
        message = exceptionConnectTimeOut;
        break;
      case DioExceptionType.unknown:
        message = exceptionDefault;
        break;
      case DioExceptionType.receiveTimeout:
        message = exceptionConnectTimeOut;
        break;
      case DioExceptionType.badResponse:
        message = _handleError(dioError.response.toString());
        break;
      case DioExceptionType.sendTimeout:
        message = exceptionConnectTimeOut;
        break;
      default:
        message = exceptionDefault;
        break;
    }
  }

  String _handleError(String error) {
    final jsonData = jsonDecode(error);
    final errorCode = jsonData['code'];
    return jsonData['message'];
  }

  @override
  String toString() => message;
}