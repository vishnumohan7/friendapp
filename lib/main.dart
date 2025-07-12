import 'package:feme/core/theme.dart';
import 'package:feme/providers/auth_provider.dart';
import 'package:feme/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
// import 'package:friend_app/core/theme.dart';
// import 'package:friend_app/providers/auth_provider.dart';
// import 'package:friend_app/routes/routes.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => AuthProvider())],
      child: const MyApp(),
    ),
  );
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // Handle background message (can auto-join call or show local notification)
  print("Handling background message: ${message.data}");
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

void setupFCM() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Get the token (send this to your server for call notification targeting)
  String? token = await messaging.getToken();
  print("FCM Token: $token");

  // Request permissions (especially on iOS)
  await messaging.requestPermission();

  // Handle foreground messages
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("Got FCM in foreground: ${message.data}");

    // If it's a call type, navigate to video screen
    if (message.data['type'] == 'call') {
      String channel = message.data['channelName'];
      // navigatorKey.currentState?.push(
      //   MaterialPageRoute(
      //     builder: (_) => VideoCallPage(channelName: channel),
      //   ),
      // );
    }
  });
}
