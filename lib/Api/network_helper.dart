import 'package:dio/dio.dart';

class NetworkHelper {
  static final NetworkHelper _instance = NetworkHelper._internal();
  factory NetworkHelper() => _instance;

  late Dio dio;

  NetworkHelper._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://your-api-url.com/api/",
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      ),
    );

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Attach token if needed
        final token = _getToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
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
