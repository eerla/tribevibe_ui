import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/event_card.dart';

class SuggestedEventsScreen extends StatelessWidget {
  final String username;
  const SuggestedEventsScreen({required this.username, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get username from route arguments if available
    final args = ModalRoute.of(context)?.settings.arguments;
    final username = (args is String && args.isNotEmpty) ? args : this.username;

    final now = DateTime.now();
    final daysInMonth = DateUtils.getDaysInMonth(now.year, now.month);
    final List<DateTime> next30Days = List.generate(30, (i) => now.add(Duration(days: i)));
    final List<String> categories = [
      'All', 'Tech', 'Business', 'Art', 'Sports', 'Health', 'Social', 'Other'
    ];
    final List<int> distances = [5, 10, 15, 20, 25, 30, 40, 50];

    // Dummy event data for 30 days
    final List<Map<String, String>> allEvents = List.generate(
      60,
      (i) => {
        'title': 'Event ${i + 1} on ${DateFormat('MMM d').format(next30Days[i ~/ 2])}',
        'date': DateFormat('EEE, MMM d, yyyy').format(next30Days[i ~/ 2]),
        'location': 'Location ${(i % 5) + 1}',
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Suggested Events'),
        backgroundColor: Colors.teal,
      ),
      body: Row(
        children: [
          // Column 1: Greeting + Calendar
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hello, $username!', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 24),
                  _CalendarWidget(year: now.year, month: now.month, days: daysInMonth),
                ],
              ),
            ),
          ),
          // Column 2: Filters + Suggested Events (2 per row)
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      DropdownButton<String>(
                        value: categories[0],
                        items: categories.map((cat) => DropdownMenuItem(value: cat, child: Text(cat))).toList(),
                        onChanged: (v) {},
                      ),
                      const SizedBox(width: 16),
                      DropdownButton<int>(
                        value: distances[0],
                        items: distances.map((d) => DropdownMenuItem(value: d, child: Text('$d km'))).toList(),
                        onChanged: (v) {},
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        width: 140,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search by date',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            prefixIcon: const Icon(Icons.calendar_today),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: GridView.builder(
                      itemCount: allEvents.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1.1,
                      ),
                      itemBuilder: (context, i) {
                        final e = allEvents[i];
                        return EventCard(
                          title: e['title'] ?? '',
                          date: e['date'] ?? '',
                          location: e['location'] ?? '',
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Column 3: Profile button at top right
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 24, right: 24),
              child: Align(
                alignment: Alignment.topRight,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.person),
                  label: const Text('Profile'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    backgroundColor: Colors.teal,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/profile');
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ...existing _CalendarWidget code...

class _CalendarWidget extends StatelessWidget {
  final int year;
  final int month;
  final int days;
  const _CalendarWidget({required this.year, required this.month, required this.days});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(icon: const Icon(Icons.chevron_left), onPressed: () {}),
                Text(DateFormat('MMMM yyyy').format(DateTime(year, month)), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                IconButton(icon: const Icon(Icons.chevron_right), onPressed: () {}),
              ],
            ),
            const SizedBox(height: 8),
            Table(
              children: [
                TableRow(
                  children: List.generate(7, (i) => Center(child: Text(['Su','Mo','Tu','We','Th','Fr','Sa'][i], style: const TextStyle(fontWeight: FontWeight.bold))))
                ),
                ...List.generate((days/7).ceil(), (week) {
                  return TableRow(
                    children: List.generate(7, (day) {
                      final d = week * 7 + day + 1;
                      if (d > days) return const SizedBox();
                      final isToday = now.year == year && now.month == month && now.day == d;
                      return Padding(
                        padding: const EdgeInsets.all(4),
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: isToday ? Colors.teal : Colors.grey[200],
                          child: Text('$d', style: TextStyle(color: isToday ? Colors.white : Colors.black)),
                        ),
                      );
                    }),
                  );
                })
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(onPressed: () {}, child: const Text('This week')),
                OutlinedButton(onPressed: () {}, child: const Text('This weekend')),
                OutlinedButton(onPressed: () {}, child: const Text('Next week')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
