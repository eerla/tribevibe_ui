import 'package:flutter/material.dart';
import '../models/event.dart';
import '../services/event_service.dart';
import '../theme/app_colors.dart';
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
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('Events', style: TextStyle(color: AppColors.buttonText)),
        iconTheme: const IconThemeData(color: AppColors.buttonText),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: AppColors.buttonText),
            tooltip: 'Create Event',
            onPressed: () async {
              final created = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CreateEventScreen()),
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
              return Card(
                color: AppColors.card,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(event.title, style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${event.date} • ${event.location}', style: TextStyle(color: AppColors.accent)),
                      if (event.organizer != null && event.organizer!['name'] != null)
                        Text('Organizer: ${event.organizer!['name']}', style: TextStyle(color: AppColors.accent, fontSize: 12)),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => EventDetailScreen(eventId: event.id!)),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
