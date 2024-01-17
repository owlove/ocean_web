import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ocean_app_web/views/tickets/tickets_view.dart';
import 'firebase_options.dart';
import 'package:ocean_app_web/views/home/home_view.dart';
import 'package:ocean_app_web/views/gallery/gallery_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeView(),
      initialRoute: '/view/home/HomeView',
      routes: {
        '/view/home/HomeView': (context) => HomeView(),
        '/view/gallery/gallery_view':(context) => GalleryView(),
        '/view/tickets/tickets_view':(context) => TicketsView(),
      },
    );
  }
}
