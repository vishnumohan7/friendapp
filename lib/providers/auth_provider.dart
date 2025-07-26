import 'package:feme/Api/network_helper.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class AuthProvider with ChangeNotifier {
  // -------------------- Form Controllers --------------------
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // -------------------- Gender & User Type --------------------
  String? selectedGender;
  String? selectedUserType;

  // -------------------- State --------------------
  bool _isLoading = false;
  String? _error;

  // -------------------- Getters --------------------
  bool get isLoading => _isLoading;
  String? get error => _error;

  // -------------------- Setters --------------------
  void setGender(String? gender) {
    selectedGender = gender;
    notifyListeners();
  }

  void setUserType(String? type) {
    selectedUserType = type;
    notifyListeners();
  }

  // -------------------- Clear All Form Fields --------------------
  void clearForm() {
    phoneController.clear();
    usernameController.clear();
    emailController.clear();
    passwordController.clear();
    selectedGender = null;
    selectedUserType = null;
    notifyListeners();
  }

  // -------------------- Signup Function --------------------
  Future<bool> signUp(BuildContext context) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await NetworkHelper().postFormData(
        'signup',
        {
          "username": usernameController.text.trim(),
          "email": emailController.text.trim().isEmpty
              ? "customer@gmail.com"
              : emailController.text.trim(),
          "gender": selectedGender ?? "",
          "phone": phoneController.text.trim(),
          "usertype": selectedUserType?.toLowerCase() ?? "customer",
          "status": "offline",
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        clearForm();
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _error = response.data['message'] ?? 'Signup failed';
      }
    } catch (e) {
      if (e is DioError) {
        if (e.type == DioErrorType.connectionTimeout) {
          _error = 'Connection timeout. Please check your internet connection.';
        } else if (e.type == DioErrorType.receiveTimeout) {
          _error = 'Server is taking too long to respond. Please try again later.';
        } else if (e.response != null) {
          // Server responded with an error status code (4xx, 5xx)
          _error = e.response?.data['message'] ?? 'Server error: ${e.response?.statusCode}';
        } else {
          _error = 'Network error: ${e.message}';
        }
      } else {
        _error = 'An unexpected error occurred: ${e.toString()}';
      }
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  // -------------------- Login Function --------------------
  /// Returns a Map containing:
  /// - 'success': bool indicating if login was successful
  /// - 'userData': Map containing user data if successful
  /// - 'token': String containing the auth token if successful
  /// - 'userType': String indicating the type of user ('customer' or 'executive')
  Future<Map<String, dynamic>> login(BuildContext context) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await NetworkHelper().postFormData(
        'app-signin',
        {
          "phone": phoneController.text.trim(),
          "password": passwordController.text.trim(),
        },
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        
        if (responseData is Map && 
            responseData['status'] == 'success' &&
            responseData['data'] is Map) {
          
          final userData = responseData['data'];
          final userType = userData['usertype']?.toString().toLowerCase() ?? 'customer';
          final token = responseData['token'];
          
          clearForm();
          _isLoading = false;
          notifyListeners();
          
          return {
            'success': true,
            'userData': userData,
            'token': token,
            'userType': userType,
          };
        } else {
          _error = 'Invalid response format from server';
        }
      } else {
        _error = response.data['message']?.toString() ?? 'Login failed';
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectionTimeout) {
        _error = 'Connection timeout. Please check your internet connection.';
      } else if (e.type == DioErrorType.receiveTimeout) {
        _error = 'Server is taking too long to respond.';
      } else if (e.response != null) {
        _error = e.response?.data['message']?.toString() ?? 'Network error';
      } else {
        _error = 'Network error: ${e.message}';
      }
    } catch (e) {
      _error = 'An unexpected error occurred: ${e.toString()}';
    }

    _isLoading = false;
    notifyListeners();
    return {'success': false};
  }

  // -------------------- Dispose Controllers --------------------
  @override
  void dispose() {
    phoneController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
