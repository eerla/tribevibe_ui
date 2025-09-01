import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../widgets/profile_card.dart';
import '../widgets/custom_button.dart';
import '../theme/app_colors.dart';
import '../widgets/event_card.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // --- Section builder methods ---
  Widget buildProfileCard({required bool isMobile}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.accent.withOpacity(0.95)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: isMobile ? 20 : 32, horizontal: isMobile ? 14 : 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.edit, size: 18),
                  label: const Text('Change profile photo'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 12, vertical: isMobile ? 6 : 8),
                    textStyle: TextStyle(fontSize: isMobile ? 11 : 13),
                  ),
                ),
              ],
            ),
            SizedBox(height: isMobile ? 16 : 24),
            Text(
              user!['name'] ?? 'User',
              style: TextStyle(fontSize: isMobile ? 22 : 26, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 8),
            Text(
              user!['email'] ?? '',
              style: TextStyle(fontSize: isMobile ? 14 : 16, color: Colors.white70),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.location_on, color: AppColors.limeGreen, size: 18),
                SizedBox(width: 6),
                Text('Manchester, CT', style: TextStyle(color: Colors.white, fontSize: isMobile ? 14 : 15)),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.calendar_today, color: AppColors.vibrantCoral, size: 16),
                SizedBox(width: 6),
                Text('Joined TribeVibe on Aug 2025', style: TextStyle(color: Colors.white70, fontSize: isMobile ? 13 : 14)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStatsRow({required bool isMobile}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _StatColumn(label: 'Groups', value: '0', fontSize: isMobile ? 16 : 20),
          _StatColumn(label: 'Interests', value: '0', fontSize: isMobile ? 16 : 20),
          _StatColumn(label: 'RSVPs', value: '0', fontSize: isMobile ? 16 : 20),
        ],
      ),
    );
  }

  Widget buildAvatarCard({required bool isMobile}) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 12 : 20),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: isMobile ? 18 : 24,
            backgroundColor: AppColors.secondary,
            child: Text(
              (user!['name'] ?? 'U').substring(0, 1).toUpperCase(),
              style: TextStyle(fontSize: isMobile ? 16 : 22, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(width: isMobile ? 12 : 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user!['name'] ?? '', style: TextStyle(fontWeight: FontWeight.bold, fontSize: isMobile ? 14 : 16, color: AppColors.text)),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: Text('Edit profile', style: TextStyle(color: AppColors.primary, decoration: TextDecoration.underline)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildEventSection(String title, List<Widget> cards, {required bool isMobile}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: isMobile ? 15 : 18)),
        SizedBox(height: 8),
        GridView.count(
          crossAxisCount: isMobile ? 1 : 2,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          mainAxisSpacing: isMobile ? 12 : 16,
          crossAxisSpacing: isMobile ? 0 : 16,
          childAspectRatio: isMobile ? 2.2 : 1.2,
          children: cards,
        ),
      ],
    );
  }

  Widget buildPromoCard({required bool isMobile}) {
    return Container(
      width: isMobile ? double.infinity : 400,
      padding: EdgeInsets.all(isMobile ? 14 : 24),
      decoration: BoxDecoration(
        color: AppColors.secondary.withOpacity(0.12),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Join over 10k members on TribeVibe', style: TextStyle(fontWeight: FontWeight.bold, fontSize: isMobile ? 15 : 18, color: AppColors.accent)),
          SizedBox(height: 8),
          Text('Subscribers are more likely to meet people with similar goals and interests.', style: TextStyle(color: AppColors.text)),
          SizedBox(height: 18),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.vibrantCoral,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            ),
            child: const Text('Start your journey now!'),
          ),
        ],
      ),
    );
  }
  Map<String, dynamic>? user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  void _loadProfile() async {
    final profile = await AuthService().getProfile();
    setState(() {
      user = profile;
      isLoading = false;
    });
  }

  void _logout() async {
    await AuthService().logout();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: Row(
          children: [
            Image.asset('assets/logo.png', height: 32, fit: BoxFit.contain),
            const SizedBox(width: 12),
            Text('TribeVibe', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: _logout,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : user == null
              ? const Center(child: Text('Failed to load profile'))
              : LayoutBuilder(
                  builder: (context, constraints) {
                    final isMobile = constraints.maxWidth < 700;
                    // ...mobile/desktop layout logic will go here...
                    // For now, just stack everything vertically on mobile, keep original Row for desktop
                    return SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: isMobile ? 16 : 32, horizontal: isMobile ? 8 : 32),
                        child: isMobile
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  buildProfileCard(isMobile: true),
                                  const SizedBox(height: 20),
                                  buildStatsRow(isMobile: true),
                                  const SizedBox(height: 20),
                                  buildAvatarCard(isMobile: true),
                                  const SizedBox(height: 20),
                                  buildEventSection('Registered Events', [
                                    EventCard(
                                      title: 'Flutter Community Meetup',
                                      date: 'Sep 10, 2025 · 6:00 PM',
                                      location: 'Downtown Community Hall',
                                    ),
                                    EventCard(
                                      title: 'Yoga in the Park',
                                      date: 'Sep 12, 2025 · 8:00 AM',
                                      location: 'Central Park',
                                    ),
                                    EventCard(
                                      title: 'Startup Pitch Night',
                                      date: 'Sep 15, 2025 · 7:30 PM',
                                      location: 'Tech Hub Auditorium',
                                    ),
                                  ], isMobile: true),
                                  const SizedBox(height: 20),
                                  buildEventSection('Joined Groups', [
                                    EventCard(
                                      title: 'Art & Wine Evening',
                                      date: 'Sep 18, 2025 · 5:00 PM',
                                      location: 'Vineyard Art Space',
                                    ),
                                    EventCard(
                                      title: 'AI Conference',
                                      date: 'Sep 20, 2025 · 9:00 AM',
                                      location: 'Tech Hub Auditorium',
                                    ),
                                  ], isMobile: true),
                                  const SizedBox(height: 20),
                                  buildEventSection('Attending Events', [
                                    EventCard(
                                      title: 'Hackathon Spring',
                                      date: 'Sep 22, 2025 · 10:00 AM',
                                      location: 'Central Park',
                                    ),
                                    EventCard(
                                      title: 'Flutter Meetup 2025',
                                      date: 'Sep 25, 2025 · 6:00 PM',
                                      location: 'Downtown Community Hall',
                                    ),
                                  ], isMobile: true),
                                  const SizedBox(height: 20),
                                  buildPromoCard(isMobile: true),
                                ],
                              )
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        buildProfileCard(isMobile: false),
                                        const SizedBox(height: 32),
                                        buildStatsRow(isMobile: false),
                                        const SizedBox(height: 32),
                                        buildAvatarCard(isMobile: false),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 32),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        buildEventSection('Registered Events', [
                                          EventCard(
                                            title: 'Flutter Community Meetup',
                                            date: 'Sep 10, 2025 · 6:00 PM',
                                            location: 'Downtown Community Hall',
                                          ),
                                          EventCard(
                                            title: 'Yoga in the Park',
                                            date: 'Sep 12, 2025 · 8:00 AM',
                                            location: 'Central Park',
                                          ),
                                          EventCard(
                                            title: 'Startup Pitch Night',
                                            date: 'Sep 15, 2025 · 7:30 PM',
                                            location: 'Tech Hub Auditorium',
                                          ),
                                        ], isMobile: false),
                                        const SizedBox(height: 32),
                                        buildEventSection('Joined Groups', [
                                          EventCard(
                                            title: 'Art & Wine Evening',
                                            date: 'Sep 18, 2025 · 5:00 PM',
                                            location: 'Vineyard Art Space',
                                          ),
                                          EventCard(
                                            title: 'AI Conference',
                                            date: 'Sep 20, 2025 · 9:00 AM',
                                            location: 'Tech Hub Auditorium',
                                          ),
                                        ], isMobile: false),
                                        const SizedBox(height: 32),
                                        buildEventSection('Attending Events', [
                                          EventCard(
                                            title: 'Hackathon Spring',
                                            date: 'Sep 22, 2025 · 10:00 AM',
                                            location: 'Central Park',
                                          ),
                                          EventCard(
                                            title: 'Flutter Meetup 2025',
                                            date: 'Sep 25, 2025 · 6:00 PM',
                                            location: 'Downtown Community Hall',
                                          ),
                                        ], isMobile: false),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 32),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        buildPromoCard(isMobile: false),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    );
                  },
                ),
      // Footer (reuse from landing page)
      bottomNavigationBar: Container(
        width: double.infinity,
        color: AppColors.primary,
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
    );
  }
}

// Stats column widget
class _StatColumn extends StatelessWidget {
  final String label;
  final String value;
  final double? fontSize;
  const _StatColumn({Key? key, required this.label, required this.value, this.fontSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
      child: Column(
        children: [
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize ?? 20, color: AppColors.primary)),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(color: AppColors.text, fontSize: fontSize != null ? fontSize! * 0.8 : null)),
        ],
      ),
    );
  }
}

// Footer link widget for footer section
class _FooterLink extends StatelessWidget {
  final String label;
  const _FooterLink({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(label, style: const TextStyle(color: Colors.white70)),
    );
  }
}


