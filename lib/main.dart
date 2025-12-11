import 'package:flutter/material.dart';
import 'package:lab2_221059/screens/home.dart';
import 'package:lab2_221059/screens/meal_by_category.dart';
import 'package:lab2_221059/screens/recipe.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'notification_handler.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Background message received: ${message.notification?.title}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );


  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


  final notificationSettings = await FirebaseMessaging.instance.requestPermission(provisional: true,);
  print("Permission: ${notificationSettings.authorizationStatus}");

  final fcmToken = await FirebaseMessaging.instance.getToken();
  print("FCM Registration Token: $fcmToken");

  FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
    print("Token refreshed: $newToken");
  });


  runApp(
    NotificationHandler(
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meals App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const HomePage(),
        "/meals": (context) => const MealPage(),
        "/recipe": (context) => RecipePage(),
      },
    );
  }
}