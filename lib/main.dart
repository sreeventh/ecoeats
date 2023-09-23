import 'package:ecoeats/firebase_options.dart';
import 'package:ecoeats/scene.dart';
import 'package:ecoeats/test.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EcoEats',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: ChatScreen(),
      routes: {
        '/login': (context) => ChatScreen(),
        '/main': (context) => const MyApp(),
      },
    );
  }
}
