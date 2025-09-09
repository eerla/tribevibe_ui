import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/event_card.dart';
import '../theme/app_colors.dart';

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
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Suggested Events', style: TextStyle(color: AppColors.primaryText)),
        backgroundColor: AppColors.cardBackground,
        elevation: 1,
        iconTheme: const IconThemeData(color: AppColors.primary),
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
                  Text('Hello, $username!', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.primaryText)),
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
                        items: categories.map((cat) => DropdownMenuItem(value: cat, child: Text(cat, style: const TextStyle(color: AppColors.primaryText)))).toList(),
                        onChanged: (v) {},
                        dropdownColor: AppColors.cardBackground,
                        style: const TextStyle(color: AppColors.primaryText),
                        iconEnabledColor: AppColors.primary,
                      ),
                      const SizedBox(width: 16),
                      DropdownButton<int>(
                        value: distances[0],
                        items: distances.map((d) => DropdownMenuItem(value: d, child: Text('$d km', style: const TextStyle(color: AppColors.primaryText)))).toList(),
                        onChanged: (v) {},
                        dropdownColor: AppColors.cardBackground,
                        style: const TextStyle(color: AppColors.primaryText),
                        iconEnabledColor: AppColors.primary,
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        width: 140,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search by date',
                            hintStyle: const TextStyle(color: AppColors.secondaryText),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            prefixIcon: const Icon(Icons.calendar_today, color: AppColors.primary),
                            filled: true,
                            fillColor: AppColors.secondaryCard,
                          ),
                          style: const TextStyle(color: AppColors.primaryText),
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
                        return Card(
                          color: AppColors.cardBackground,
                          elevation: 3,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          child: EventCard(
                            title: e['title'] ?? '',
                            date: e['date'] ?? '',
                            location: e['location'] ?? '',
                          ),
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
                  icon: const Icon(Icons.person, color: Colors.white),
                  label: const Text('Profile', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    backgroundColor: AppColors.primary,
                    elevation: 4,
                    shadowColor: AppColors.primary.withOpacity(0.18),
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
      color: AppColors.cardBackground,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(icon: const Icon(Icons.chevron_left, color: AppColors.primary), onPressed: () {}),
                Text(DateFormat('MMMM yyyy').format(DateTime(year, month)), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryText)),
                IconButton(icon: const Icon(Icons.chevron_right, color: AppColors.primary), onPressed: () {}),
              ],
            ),
            const SizedBox(height: 8),
            Table(
              children: [
                TableRow(
                  children: List.generate(7, (i) => Center(child: Text(['Su','Mo','Tu','We','Th','Fr','Sa'][i], style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.secondaryText))))
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
                          backgroundColor: isToday ? AppColors.primary : AppColors.secondaryCard,
                          child: Text('$d', style: TextStyle(color: isToday ? Colors.white : AppColors.primaryText)),
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
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(color: AppColors.primary),
                  ),
                  child: const Text('This week'),
                ),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(color: AppColors.primary),
                  ),
                  child: const Text('This weekend'),
                ),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(color: AppColors.primary),
                  ),
                  child: const Text('Next week'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
