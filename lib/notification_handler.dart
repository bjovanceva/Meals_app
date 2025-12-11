import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:lab2_221059/screens/recipe.dart';
import 'package:lab2_221059/services/api_service.dart';

class NotificationHandler extends StatefulWidget {
  final Widget child;

  const NotificationHandler({super.key, required this.child});

  @override
  State<NotificationHandler> createState() => _NotificationHandlerState();
}

class _NotificationHandlerState extends State<NotificationHandler> {
  @override
  void initState() {
    super.initState();


    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        _handleMessage(message);
      }
    });


    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);


    FirebaseMessaging.onMessage.listen((message) {
      print("Foreground message received: ${message.notification?.title}");

    });
  }

  void _handleMessage(RemoteMessage message) async {

    if (message.data['type'] == 'recipe') {
      print("Received recipe notification");

      final randomMeal = await ApiService().loadRandomMeal();
      Navigator.pushNamed(context, '/recipe',
        arguments: randomMeal,
      );
      // if (randomMeal != null && mounted) {
      //   WidgetsBinding.instance.addPostFrameCallback((_) {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (_) => RecipePage(),
      //         settings: RouteSettings(arguments: randomMeal),
      //       ),
      //     );
      //   });
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}