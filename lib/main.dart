import 'package:flutter/material.dart';

import 'screens/login_screen.dart';
import 'screens/landing_page.dart';
import 'screens/signup_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/event_list_screen.dart';
import 'screens/event_detail_screen.dart';
import 'screens/create_event_screen.dart';
import 'screens/suggested_events_screen.dart';
import 'services/auth_service.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flink',
  theme: AppTheme.lightTheme,
  home: const LandingPage(),
      routes: {
        '/login': (context) => const LoginSheet(),
        '/signup': (context) => const SignupSheet(),
        '/profile': (context) => ProfileScreen(),
        '/events': (context) => EventListScreen(),
        '/event_detail': (context) => EventDetailScreen(eventId: 0), // Placeholder, use push with args
        '/create_event': (context) => CreateEventScreen(),
        // '/groups': (context) => GroupsScreen(),
        // '/group_detail': (context) => GroupDetailScreen(groupId: 0), // Placeholder, use push with args
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/suggested-events') {
          final username = settings.arguments as String? ?? 'User';
          print(username);
          return MaterialPageRoute(
            builder: (context) => SuggestedEventsScreen(username: username),
          );
        }
        return null;
      },
    );
  }
}
