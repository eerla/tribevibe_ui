import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import './_landing_page_extras.dart';
// Category data model for responsive grid
class _CategoryData {
  final String label;
  final IconData icon;
  final Color color;
  const _CategoryData(this.label, this.icon, this.color);
}

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  static final List<_CategoryData> categories = [
    _CategoryData('Travel and Outdoor', Icons.park, Colors.green),
    _CategoryData('Social Activities', Icons.groups, Colors.purple),
    _CategoryData('Hobbies & Passions', Icons.palette, Colors.orange),
    _CategoryData('Sports & Fitness', Icons.sports_soccer, Colors.blue),
    _CategoryData('Health & Wellbeing', Icons.spa, Colors.teal),
    _CategoryData('Technology', Icons.computer, Colors.pink),
    _CategoryData('Art & Culture', Icons.theater_comedy, Colors.amber),
    _CategoryData('Games', Icons.casino, Colors.cyan),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.secondary,
              child: Icon(Icons.people, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Text('TribeVibe', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/login'),
            child: const Text('Log in', style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/signup'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: const Text('Sign up', style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Hero Section
                SizedBox(height: 32),
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primary, AppColors.secondary.withOpacity(0.7)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Find your tribe. Join amazing events.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Discover and join local groups, meet new people, and explore your interests.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 18),
                      ),
                      const SizedBox(height: 32),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search events, groups, or interests',
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: Icon(Icons.search, color: AppColors.primary),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.button,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            ),
                            child: const Text('Search', style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                                      // Modern Two-Column Intro Section
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
                                        child: LayoutBuilder(
                                          builder: (context, constraints) {
                                            bool isWide = constraints.maxWidth > 700;
                                            return Flex(
                                              direction: isWide ? Axis.horizontal : Axis.vertical,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                // Left: Text and Button
                                                Expanded(
                                                  flex: 2,
                                                  child: Column(
                                                    crossAxisAlignment: isWide ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        'This is the modern way to meet people',
                                                        style: TextStyle(
                                                          fontSize: 28,
                                                          fontWeight: FontWeight.bold,
                                                          color: AppColors.primary,
                                                          letterSpacing: 1.1,
                                                        ),
                                                        textAlign: isWide ? TextAlign.left : TextAlign.center,
                                                      ),
                                                      const SizedBox(height: 18),
                                                      Text(
                                                        'Find and join events of all types, connect with like-minded people, and share your passions. TribeVibe makes it easy to discover new friendships and experiences in your city or online.',
                                                        style: TextStyle(fontSize: 17, color: AppColors.accent.withOpacity(0.95)),
                                                        textAlign: isWide ? TextAlign.left : TextAlign.center,
                                                      ),
                                                      const SizedBox(height: 28),
                                                      Align(
                                                        alignment: isWide ? Alignment.centerLeft : Alignment.center,
                                                        child: ElevatedButton(
                                                          onPressed: () => Navigator.pushNamed(context, '/signup'),
                                                          style: ElevatedButton.styleFrom(
                                                            backgroundColor: AppColors.button,
                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                                                            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                                          ),
                                                          child: const Text('Join TribeVibe', style: TextStyle(color: Colors.white, fontSize: 18)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: isWide ? 40 : 0, height: isWide ? 0 : 40),
                                                // Right: Image Placeholder
                                                Expanded(
                                                  flex: 2,
                                                  child: Center(
                                                    child: Container(
                                                      width: 220,
                                                      height: 180,
                                                      decoration: BoxDecoration(
                                                        color: AppColors.secondary.withOpacity(0.08),
                                                        borderRadius: BorderRadius.circular(24),
                                                      ),
                                                      child: const Icon(Icons.groups, size: 100, color: Colors.grey),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                      // Popular Cities & How TribeVibe Works Side by Side
                                      LayoutBuilder(
                                        builder: (context, constraints) {
                                          bool isWide = constraints.maxWidth > 900;
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 8),
                                            child: SizedBox(
                                              width: constraints.maxWidth,
                                              child: Flex(
                                                direction: isWide ? Axis.horizontal : Axis.vertical,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  // Popular Cities
                                                  Container(
                                                    width: isWide ? (constraints.maxWidth / 2) - 24 : null,
                                                    margin: EdgeInsets.only(right: isWide ? 32 : 0, bottom: isWide ? 0 : 32),
                                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                                    decoration: BoxDecoration(
                                                      color: AppColors.background,
                                                      borderRadius: BorderRadius.circular(18),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        const Text('Popular cities on TribeVibe', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                                                        const SizedBox(height: 8),
                                                        Text(
                                                          "Looking for fun things to do near you? See what TribeVibe organizers are planning in cities around the country.",
                                                          style: TextStyle(color: Colors.black87, fontSize: 15),
                                                        ),
                                                        const SizedBox(height: 24),
                                                        SingleChildScrollView(
                                                          scrollDirection: Axis.horizontal,
                                                          child: Row(
                                                            children: [
                                                              CityCircle(name: 'Hyderabad', imageUrl: null, isBold: true),
                                                              CityCircle(name: 'Bangalore', imageUrl: null, isBold: true),
                                                              CityCircle(name: 'New Delhi', imageUrl: null, isBold: true),
                                                              CityCircle(name: 'Chennai', imageUrl: null, isBold: true),
                                                              CityCircle(name: 'Gurgaon', imageUrl: null, isBold: true),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  // How TribeVibe Works
                                                  Container(
                                                    width: isWide ? (constraints.maxWidth / 2) - 24 : null,
                                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        const Text('How TribeVibe works', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                                                        const SizedBox(height: 18),
                                                        HowItWorksCard(
                                                          icon: Icons.search,
                                                          title: 'Discover events and groups',
                                                          description: "See who's hosting local events for all the things you love",
                                                          linkText: 'Search events and groups',
                                                          onTap: () {},
                                                        ),
                                                        const SizedBox(height: 18),
                                                        HowItWorksCard(
                                                          icon: Icons.add,
                                                          title: 'Start a group to host events',
                                                          description: 'Create your own TribeVibe group, and draw from a community of millions',
                                                          linkText: 'Start a group',
                                                          onTap: () {},
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            const Text('Explore top categories', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                            const SizedBox(height: 12),
                                            LayoutBuilder(
                                              builder: (context, constraints) {
                                                int crossAxisCount = constraints.maxWidth > 900
                                                    ? 4
                                                    : constraints.maxWidth > 600
                                                        ? 2
                                                        : 1;
                                                return GridView.builder(
                                                  shrinkWrap: true,
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  itemCount: categories.length,
                                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: crossAxisCount,
                                                    crossAxisSpacing: 16,
                                                    mainAxisSpacing: 16,
                                                    childAspectRatio: 1.8, // Even more vertical space
                                                  ),
                                                  itemBuilder: (context, index) {
                                                    final cat = categories[index];
                                                    return SizedBox(
                                                      child: Card(
                                                        color: Colors.grey[100],
                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                                        child: Center(
                                                          child: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            Icon(cat.icon, color: cat.color, size: 36),
                                                            const SizedBox(height: 8),
                                                            Text(
                                                            cat.label,
                                                            textAlign: TextAlign.center,
                                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                                            ),
                                                          ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Responsive Featured Events Section
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            const Text('Featured Events', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                            const SizedBox(height: 12),
                                            LayoutBuilder(
                                              builder: (context, constraints) {
                                                int crossAxisCount = constraints.maxWidth > 900
                                                    ? 4
                                                    : constraints.maxWidth > 600
                                                        ? 2
                                                        : 1;
                                                return GridView.builder(
                                                  shrinkWrap: true,
                                                  physics: const NeverScrollableScrollPhysics(),
                                                  itemCount: 4,
                                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: crossAxisCount,
                                                    crossAxisSpacing: 16,
                                                    mainAxisSpacing: 16,
                                                    childAspectRatio: 1.2,
                                                  ),
                                                  itemBuilder: (context, index) {
                                                    // Placeholder event data
                                                    final eventTitles = [
                                                      'Flutter Community Meetup',
                                                      'Yoga in the Park',
                                                      'Startup Pitch Night',
                                                      'Art & Wine Evening',
                                                    ];
                                                    final eventDates = [
                                                      'Sep 10, 2025 · 6:00 PM',
                                                      'Sep 12, 2025 · 8:00 AM',
                                                      'Sep 15, 2025 · 7:30 PM',
                                                      'Sep 18, 2025 · 5:00 PM',
                                                    ];
                                                    final eventLocations = [
                                                      'Downtown Community Hall',
                                                      'Central Park',
                                                      'Tech Hub Auditorium',
                                                      'Vineyard Art Space',
                                                    ];
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
                                                            Text(
                                                              eventTitles[index % eventTitles.length],
                                                              textAlign: TextAlign.center,
                                                              style: const TextStyle(
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 16,
                                                                color: Color(0xFF232136),
                                                              ),
                                                            ),
                                                            Text(
                                                              eventDates[index % eventDates.length],
                                                              style: TextStyle(
                                                                color: Colors.grey[700],
                                                                fontSize: 13,
                                                              ),
                                                            ),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                const Icon(Icons.location_on, size: 15, color: Colors.grey),
                                                                const SizedBox(width: 4),
                                                                Flexible(
                                                                  child: Text(
                                                                    eventLocations[index % eventLocations.length],
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
                                                  },
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Call to Action Section
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                                      child: Column(
                                        children: [
                                          Text(
                                            'Ready to start your own group or event?',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primary),
                                          ),
                                          const SizedBox(height: 16),
                                          ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: AppColors.secondary,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                            ),
                                            child: const Text('Start a Group', style: TextStyle(color: Colors.white, fontSize: 18)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  // Footer (full width)
                                  Container(
                                    width: double.infinity,
                                    color: AppColors.primary,
                                    padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text('TribeVibe', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                                        const SizedBox(height: 12),
                                        Wrap(
                                          alignment: WrapAlignment.center,
                                          spacing: 24,
                                          children: [
                                            _FooterLink(label: 'About'),
                                            _FooterLink(label: 'Careers'),
                                            _FooterLink(label: 'Blog'),
                                            _FooterLink(label: 'Help'),
                                            _FooterLink(label: 'Privacy'),
                                            _FooterLink(label: 'Terms'),
                                          ],
                                        ),
                                        const SizedBox(height: 16),
                                        Text('© 2025 TribeVibe. All rights reserved.', style: TextStyle(color: Colors.white70)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
  }
}

// Footer link widget for footer section
class _FooterLink extends StatelessWidget {
  final String label;
  const _FooterLink({required this.label});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(label, style: const TextStyle(color: Colors.white70)),
    );
  }
}