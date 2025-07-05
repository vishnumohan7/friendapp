import 'package:feme/screens/auth/forgot_password_screen.dart';
import 'package:feme/screens/auth/login_screen.dart';
import 'package:feme/screens/auth/signup_screen.dart';
import 'package:feme/screens/auth/welcome_screen.dart';
import 'package:feme/screens/customer/coins_screen.dart';
import 'package:feme/screens/customer/dashboard_screen.dart';
import 'package:feme/screens/customer/executive_list_screen.dart';
import 'package:feme/screens/customer/profile_screen.dart';
import 'package:feme/screens/customer/report_screen.dart';
import 'package:feme/screens/customer/transaction_summary_screen.dart';
import 'package:feme/screens/executive/executive_dashboard.dart';
import 'package:flutter/material.dart';


class AppRoutes {
  static const String welcome = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';
  static const String customerDashboard = '/customer-dashboard';
  static const String executiveDashboard = '/executive-dashboard';
  static const String executives = '/executives';
  static const String coins = '/coins';
  static const String reports = '/reports';
  static const String profile = '/profile';
  static const String transactionSummary = '/transaction-summary';

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
      case executives:
        return MaterialPageRoute(builder: (_) => const ExecutiveListScreen());
      case reports:
        return MaterialPageRoute(builder: (_) => const ReportScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case transactionSummary:
        return MaterialPageRoute(builder: (_) => const TransactionSummaryScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
