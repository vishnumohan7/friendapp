import 'package:feme/Api/network_helper.dart';
import 'package:feme/models/user_model.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  final NetworkHelper _networkHelper = NetworkHelper();
  
  List<User> _users = [];
  bool _isLoading = false;
  String? _error;
  
  // Getters
  List<User> get users => _users;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Fetch list of users/executives
  Future<void> fetchUsers() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await _networkHelper.get('user/');
      print('API Response: ${response.data}'); // Debug log
      
      if (response.statusCode == 200) {
        final userList = response.data['data'] as List<dynamic>? ?? [];
        print('User list length: ${userList.length}'); // Debug log
        if (userList.isNotEmpty) {
          print('First user data: ${userList.first}'); // Debug log
        }
        _users = userList.map((user) {
          print('Processing user: $user'); // Debug log
          return User.fromJson(user);
        }).toList();
      } else {
        _error = 'Failed to load users. Status code: ${response.statusCode}';
        print('Error response: ${response.data}'); // Debug log
      }
    } catch (e) {
      _error = 'Error fetching users: $e';
      print('Exception details: $e'); // Debug log
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Clear the user list
  void clearUsers() {
    _users = [];
    _error = null;
    notifyListeners();
  }
}
