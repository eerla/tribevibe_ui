import 'package:flutter/material.dart';
import '../models/event.dart';
import '../services/event_service.dart';
import '../theme/app_colors.dart';
import '../widgets/modern_app_bar.dart';
import '../widgets/modern_card.dart';
import 'event_detail_screen.dart';
import 'create_event_screen.dart';

class EventListScreen extends StatefulWidget {
  @override
  _EventListScreenState createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  late Future<List<Event>> _eventsFuture;

  @override
  void initState() {
    super.initState();
    _eventsFuture = EventService().getEvents();
  }

  void _refreshEvents() {
    setState(() {
      _eventsFuture = EventService().getEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: ModernAppBar(
        title: 'Events',
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            tooltip: 'Create Event',
            onPressed: () async {
              final created = await Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => CreateEventScreen(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    const begin = Offset(0.0, 1.0);
                    const end = Offset.zero;
                    const curve = Curves.easeInOut;
                    final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 500),
                ),
              );
              if (created == true) _refreshEvents();
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Event>>(
        future: _eventsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load events'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No events found'));
          }
          final events = snapshot.data!;
          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return ModernCard(
                animationDelay: Duration(milliseconds: 80 * index),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => EventDetailScreen(eventId: event.id!)),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(event.title, style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 18)),
                      const SizedBox(height: 6),
                      Text('${event.date} • ${event.location}', style: TextStyle(color: AppColors.accent)),
                      if (event.organizer != null && event.organizer!['name'] != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text('Organizer: ${event.organizer!['name']}', style: TextStyle(color: AppColors.accent, fontSize: 12)),
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
