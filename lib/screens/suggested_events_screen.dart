import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
          // Column 2: Filters + Suggested Events
          Expanded(
            flex: 2,
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
                    child: ListView.builder(
                      itemCount: next30Days.length,
                      itemBuilder: (context, i) {
                        final date = next30Days[i];
                        // Dummy events for demo
                        final events = List.generate(2, (j) => {
                          'title': 'Event ${j+1} on ${DateFormat('MMM d').format(date)}',
                          'time': DateFormat('h:mm a').format(date.add(Duration(hours: j+12))),
                          'location': 'Location ${j+1}',
                          'attendees': 10 + j * 5,
                        });
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(DateFormat('EEEE, MMM d').format(date), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            ...events.map((e) => Card(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                                leading: Container(
                                  width: 48, height: 48,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(Icons.event, size: 32, color: Colors.grey),
                                ),
                                title: Text(e['title'] as String),
                                subtitle: Text('${e['time']} · ${e['location']}'),
                                trailing: Text('${e['attendees']} attendees'),
                              ),
                            )),
                            const Divider(),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Column 3: Profile button
          Expanded(
            child: Center(
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
        ],
      ),
    );
  }
}

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
