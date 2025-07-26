import 'package:dio/dio.dart';

class NetworkHelper {
  static final NetworkHelper _instance = NetworkHelper._internal();
  factory NetworkHelper() => _instance;

  late Dio dio;

  NetworkHelper._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://demo.perutions.com/femeapi/api/",
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      ),
    );

    // Add interceptor to include Bearer token in all requests
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Add the Bearer token to the headers
        options.headers['Authorization'] = 'Bearer 1592|aWtHmWCgQiup6w3P6tcfKC8kOXohr12AQUisPEEL626a2e61';
        return handler.next(options);
      },
      onError: (e, handler) {
        // Handle errors globally
        print("Network Error: ${e.response?.statusCode} - ${e.message}");
        return handler.next(e);
      },
    ));
  }

  Future<Response> get(String endpoint, {Map<String, dynamic>? params}) async {
    try {
      return await dio.get(endpoint, queryParameters: params);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> postFormData(
      String endpoint, Map<String, String> fields) async {
    try {
      FormData formData = FormData.fromMap(fields);
      return await dio.post(endpoint, data: formData);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(String endpoint, dynamic data) async {
    try {
      return await dio.post(endpoint, data: data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put(String endpoint, dynamic data) async {
    try {
      return await dio.put(endpoint, data: data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(String endpoint) async {
    try {
      return await dio.delete(endpoint);
    } catch (e) {
      rethrow;
    }
  }

  String? _getToken() {
    // TODO: Replace this with your secure token fetch method (e.g., from storage or provider)
    return null;
  }
}
