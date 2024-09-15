import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../config/app_config.dart';
import '../shared/utils/util.dart';
import '../shared/widgets/widgets.dart';
import 'exception/exceptions.dart';

class ApiClient {
  static String BASE_URL = AppConfig.buildType.apiBaseUrl;

  static ApiClient? _instance;

  static ApiClient get instance {
    if (_instance != null) return _instance!;
    _instance = ApiClient._init();
    return _instance!;
  }

  late final Dio dio;

  ApiClient._init() {
    dio = Dio(
      BaseOptions(
        baseUrl: BASE_URL,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    )
      ..interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90))
      ..interceptors.add(InterceptorsWrapper(onError: handleOnError));
  }

  Future handleOnError(
      DioException exception, ErrorInterceptorHandler handler) async {
    if (exception.response?.statusCode == 401) {
      Navigators.showTokenExpiredDialog();
      return handler.reject(exception);
    }
    return handler.next(exception);
  }

  Future<Response> post(String path, dynamic data) async {
    BBSBaseDialogLoading.show(globalKey.currentContext!);
    var token = Shared.getAccessToken();
    try {
      final options = Options(contentType: Headers.jsonContentType, headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      return await dio.post(
        path,
        data: data,
        options: options,
      );
    } on DioException catch (e) {
      BBSBaseDialogLoading.hide(globalKey.currentContext!);
      final errorMessage = ApiExceptions.fromDioError(e).toString();
      final errorCode = ApiExceptions.fromDioError(e).code;
      Navigators.showErrorDialog(errorMessage, code: errorCode);
      rethrow;
    } finally {
      BBSBaseDialogLoading.hide(globalKey.currentContext!);
    }
  }

  Future<Response> put(String path, {dynamic data}) async {
    BBSBaseDialogLoading.show(globalKey.currentContext!);
    var token = Shared.getAccessToken();
    try {
      return await dio.put(
        path,
        data: data,
        options: Options(contentType: Headers.jsonContentType, headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        }),
      );
    } on DioException catch (e) {
      BBSBaseDialogLoading.hide(globalKey.currentContext!);
      final errorMessage = ApiExceptions.fromDioError(e).toString();
      final errorCode = ApiExceptions.fromDioError(e).code;
      Navigators.showErrorDialog(errorMessage, code: errorCode);
      rethrow;
    } finally {
      BBSBaseDialogLoading.hide(globalKey.currentContext!);
    }
  }

  Future<Response> delete(String path) async {
    BBSBaseDialogLoading.show(globalKey.currentContext!);
    var token = Shared.getAccessToken();
    try {
      return await dio.delete(
        path,
        options: Options(contentType: Headers.jsonContentType, headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        }),
      );
    } on DioException catch (e) {
      BBSBaseDialogLoading.hide(globalKey.currentContext!);
      final errorMessage = ApiExceptions.fromDioError(e).toString();
      final errorCode = ApiExceptions.fromDioError(e).code;
      Navigators.showErrorDialog(errorMessage, code: errorCode);
      rethrow;
    } finally {
      BBSBaseDialogLoading.hide(globalKey.currentContext!);
    }
  }

  Future<Response> get(String path,
      {Map<String, dynamic>? param, bool isLoadMore = false}) async {
    if (!isLoadMore) BBSBaseDialogLoading.show(globalKey.currentContext!);
    var token = Shared.getAccessToken();
    try {
      return await dio.get(path,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          }),
          queryParameters: param);
    } on DioException catch (e) {
      BBSBaseDialogLoading.hide(globalKey.currentContext!);
      final errorMessage = ApiExceptions.fromDioError(e).toString();
      final errorCode = ApiExceptions.fromDioError(e).code;
      Navigators.showErrorDialog(errorMessage, code: errorCode);
      rethrow;
    } finally {
      BBSBaseDialogLoading.hide(globalKey.currentContext!);
    }
  }

  Future<Response> patch(String path, {dynamic data}) async {
    BBSBaseDialogLoading.show(globalKey.currentContext!);
    var token = Shared.getAccessToken();
    try {
      return await dio.patch(
        path,
        data: data,
        options: Options(contentType: Headers.jsonContentType, headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        }),
      );
    } on DioException catch (e) {
      BBSBaseDialogLoading.hide(globalKey.currentContext!);
      final errorMessage = ApiExceptions.fromDioError(e).toString();
      final errorCode = ApiExceptions.fromDioError(e).code;
      Navigators.showErrorDialog(errorMessage, code: errorCode);
      rethrow;
    } finally {
      BBSBaseDialogLoading.hide(globalKey.currentContext!);
    }
  }
}
