import 'package:feme/core/theme.dart';
import 'package:feme/providers/auth_provider.dart';
import 'package:feme/routes/routes.dart';
import 'package:flutter/material.dart';
// import 'package:friend_app/core/theme.dart';
// import 'package:friend_app/providers/auth_provider.dart';
// import 'package:friend_app/routes/routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => AuthProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Friend App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.welcome,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}

// This widget is kept as a placeholder for the home screen
// after successful authentication
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome to Friend App')),
      body: const Center(
        child: Text(
          'Welcome to Friend App!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
