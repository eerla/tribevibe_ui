import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class EventCard extends StatelessWidget {
  final String title;
  final String date;
  final String location;
  const EventCard({required this.title, required this.date, required this.location, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image placeholder
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.image, size: 36, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xFF232136),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              date,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.location_on, size: 15, color: Colors.grey),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    location,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
