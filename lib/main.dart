import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'theme/app_text.dart';
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
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_, child) {
        return MaterialApp(
          title: 'Flink',
          theme: AppTheme.lightTheme.copyWith(textTheme: AppText.textTheme),
          darkTheme: AppTheme.darkTheme.copyWith(textTheme: AppText.textTheme),
          themeMode: ThemeMode.system,
          builder: (context, widget) => ResponsiveBreakpoints.builder(
            breakpoints: [
              const Breakpoint(start: 0, end: 450, name: MOBILE),
              const Breakpoint(start: 451, end: 800, name: TABLET),
              const Breakpoint(start: 801, end: 1920, name: DESKTOP),
              const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
            ],
            child: widget!,
          ),
          home: child,
          // App routes organized by feature
          routes: {
            // 🔑 Authentication & Onboarding
            '/login': (context) => const LoginSheet(),
            // /register or /signup
            '/signup': (context) => const SignupSheet(),
            // 
            '/me': (context) => ProfileScreen(),
            '/me/rsvps': (context) => ProfileScreen(),
            '/me/events': (context) => ProfileScreen(),
            '/me/groups': (context) => ProfileScreen(),

            // 🏠 Home / Event Discovery
            '/events': (context) => EventListScreen(),
            '/categories': (context) => EventListScreen(),
            '/events/:id': (context) => EventDetailScreen(eventId: 0),
            '/events/:id/rsvp': (context) => EventDetailScreen(eventId: 0),
            '/events/:id/attendees': (context) => EventDetailScreen(eventId: 0),
            // Search screen can be added here if needed

            // 📅 Event Details & RSVP
            '/event_detail': (context) => EventDetailScreen(eventId: 0),
            // RSVP confirmation, attendee list screens can be added here

            // 👤 Profile & My Events
            // '/my_rsvps': (context) => MyRSVPsScreen(),
            // '/my_events': (context) => MyEventsScreen(),

            // ✍️ Create / Manage Events
            '/create_event': (context) => CreateEventScreen(),
            // '/edit_event': (context) => EditEventScreen(),
            // '/organizer_dashboard': (context) => OrganizerDashboardScreen(),

            // 🔔 Notifications
            // '/notifications': (context) => NotificationsScreen(),
          },
          onGenerateRoute: (settings) {
            if (settings.name == '/suggested-events') {
              final username = settings.arguments as String? ?? 'User';
              return MaterialPageRoute(
                builder: (context) => SuggestedEventsScreen(username: username),
              );
            }
            return null;
          },
          debugShowCheckedModeBanner: false,
        );
      },
      child: const LandingPage(),
    );
  }
}