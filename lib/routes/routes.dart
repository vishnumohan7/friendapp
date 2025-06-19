import 'package:flutter/material.dart';
import 'package:friend_app/screens/auth/welcome_screen.dart';
import 'package:friend_app/screens/auth/login_screen.dart';
import 'package:friend_app/screens/auth/signup_screen.dart';
import 'package:friend_app/screens/auth/forgot_password_screen.dart';
import 'package:friend_app/screens/customer/coins_screen.dart';
import 'package:friend_app/screens/customer/dashboard_screen.dart';
import 'package:friend_app/screens/executive/executive_dashboard.dart';

class AppRoutes {
  static const String welcome = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';
  static const String customerDashboard = '/customer-dashboard';
  static const String executiveDashboard = '/executive-dashboard';
  static const String coins = '/coins';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcome:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case signup:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case customerDashboard:
        return MaterialPageRoute(
          builder: (_) => const CustomerDashboardScreen(),
        );
      case executiveDashboard:
        return MaterialPageRoute(
          builder: (_) => const ExecutiveDashboardScreen(),
        );
      case coins:
        return MaterialPageRoute(builder: (_) => const CoinsScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
