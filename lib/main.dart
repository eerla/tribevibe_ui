import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/event_list_screen.dart';
import 'screens/event_detail_screen.dart';
import 'screens/create_event_screen.dart';
import 'services/auth_service.dart';

void main() {
  runApp(TribeVibeApp());
}

class TribeVibeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tribe Vibe',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginScreen(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/profile': (context) => ProfileScreen(),
        '/events': (context) => EventListScreen(),
        '/event_detail': (context) => EventDetailScreen(eventId: 0), // Placeholder, use push with args
        '/create_event': (context) => CreateEventScreen(),
      },
    );
  }
}
