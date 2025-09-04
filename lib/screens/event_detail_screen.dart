import 'package:flutter/material.dart';
import '../models/event.dart';
import '../services/event_service.dart';
import '../theme/app_colors.dart';
import '../widgets/modern_app_bar.dart';
import '../widgets/modern_card.dart';

class EventDetailScreen extends StatelessWidget {
  final int eventId;
  const EventDetailScreen({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
  appBar: const ModernAppBar(title: 'Event Details'),
      body: FutureBuilder<Event>(
        future: EventService().getEventById(eventId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load event'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Event not found'));
          }
          final event = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: ModernCard(
              elevation: 6,
              borderRadius: 24,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(event.title, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.primary)),
                    const SizedBox(height: 16),
                    Text('Date: ${event.date}', style: TextStyle(color: AppColors.accentText)),
                    Text('Time: ${event.time}', style: TextStyle(color: AppColors.accentText)),
                    const SizedBox(height: 12),
                    Text('Location: ${event.location}', style: TextStyle(color: AppColors.accentText)),
                    const SizedBox(height: 12),
                    if (event.organizer != null && event.organizer!['name'] != null)
                      Text('Organizer: ${event.organizer!['name']}', style: TextStyle(color: AppColors.accentText)),
                    if (event.createdAt != null)
                      Text('Created: ${event.createdAt}', style: TextStyle(color: AppColors.accentText, fontSize: 12)),
                    const SizedBox(height: 24),
                    if (event.description != null)
                      Text(event.description!, style: TextStyle(fontSize: 16, color: AppColors.primary)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
