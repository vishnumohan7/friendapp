import 'package:feme/routes/routes.dart' as routes;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class AuthProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  String? _userType;
  String? _gender;
  bool _isExecutiveLogin = false; // Flag to determine user type

  // Getters
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get userType => _userType;
  String? get gender => _gender;

  // Setters
  void setUserType(String type) {
    _userType = type;
    notifyListeners();
  }

  void setGender(String gender) {
    _gender = gender;
    notifyListeners();
  }

  // Sign up method
  Future<bool> signUp({
    required String phone,
    required String username,
    required String password,
    required String userType,
    required String gender,
    String? email,
  }) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // TODO: Implement actual signup logic with your backend
      // For now, just store the user type and gender
      _userType = userType;
      _gender = gender;
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
  

Future<bool> login({
  required String username,
  required String password,
  required BuildContext context,
}) async {
  try {
    _isLoading = true;
    _error = null;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    // Dummy logic to determine executive or customer
    _isExecutiveLogin = username.toLowerCase().contains('executive');

    _isLoading = false;
    notifyListeners();

    // Navigation
    if (_isExecutiveLogin) {
      Navigator.pushReplacementNamed(context, routes.AppRoutes.executiveDashboard);
    } else {
      Navigator.pushReplacementNamed(context, routes.AppRoutes.customerDashboard);
    }

    return true;
  } catch (e) {
    _error = e.toString();
    _isLoading = false;
    notifyListeners();
    return false;
  }
}



  // Logout method
  void logout() {
    _userType = null;
    _gender = null;
    _error = null;
    notifyListeners();
  }
}
