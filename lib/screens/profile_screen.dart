import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../widgets/profile_card.dart';
import '../widgets/custom_button.dart';
import '../theme/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
              : Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 32),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Column 1: Profile, Stats, Avatar
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Profile Card
                                    Container(
                                      width: 340,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        gradient: LinearGradient(
                                          colors: [AppColors.primary, AppColors.accent.withOpacity(0.95)],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
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
                                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                                    textStyle: const TextStyle(fontSize: 13),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 24),
                                            Text(
                                              user!['name'] ?? 'User',
                                              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              user!['email'] ?? '',
                                              style: const TextStyle(fontSize: 16, color: Colors.white70),
                                            ),
                                            const SizedBox(height: 12),
                                            Row(
                                              children: [
                                                Icon(Icons.location_on, color: AppColors.limeGreen, size: 18),
                                                const SizedBox(width: 6),
                                                Text('Manchester, CT', style: TextStyle(color: Colors.white, fontSize: 15)),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              children: [
                                                Icon(Icons.calendar_today, color: AppColors.vibrantCoral, size: 16),
                                                const SizedBox(width: 6),
                                                Text('Joined TribeVibe on Aug 2025', style: TextStyle(color: Colors.white70, fontSize: 14)),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 32),
                                    // Stats Row
                                    Container(
                                      width: 340,
                                      decoration: BoxDecoration(
                                        color: AppColors.card,
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2))],
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          _StatColumn(label: 'Groups', value: '0'),
                                          _StatColumn(label: 'Interests', value: '0'),
                                          _StatColumn(label: 'RSVPs', value: '0'),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 32),
                                    // User avatar, name, and edit profile
                                    Container(
                                      width: 340,
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        color: AppColors.card,
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2))],
                                      ),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 24,
                                            backgroundColor: AppColors.secondary,
                                            child: Text(
                                              (user!['name'] ?? 'U').substring(0, 1).toUpperCase(),
                                              style: const TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(user!['name'] ?? '', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.text)),
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
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 32),
                              // Column 2: Registered events, joined groups, attending events (dummy data)
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Registered Events
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(24),
                                      margin: const EdgeInsets.only(bottom: 24),
                                      decoration: BoxDecoration(
                                        color: AppColors.card,
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2))],
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text('Registered Events', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                          const SizedBox(height: 8),
                                          Text('Flutter Meetup 2025'),
                                          Text('AI Conference'),
                                          Text('Hackathon Spring'),
                                        ],
                                      ),
                                    ),
                                    // Joined Groups
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(24),
                                      margin: const EdgeInsets.only(bottom: 24),
                                      decoration: BoxDecoration(
                                        color: AppColors.card,
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2))],
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text('Joined Groups', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                          const SizedBox(height: 8),
                                          Text('Flutter Devs'),
                                          Text('AI Enthusiasts'),
                                        ],
                                      ),
                                    ),
                                    // Attending Events
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(24),
                                      decoration: BoxDecoration(
                                        color: AppColors.card,
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2))],
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text('Attending Events', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                          const SizedBox(height: 8),
                                          Text('AI Conference'),
                                          Text('Hackathon Spring'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 32),
                              // Column 3: Promo card
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: 400,
                                      padding: const EdgeInsets.all(24),
                                      decoration: BoxDecoration(
                                        color: AppColors.secondary.withOpacity(0.12),
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Join over 10k members on TribeVibe', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.accent)),
                                          const SizedBox(height: 8),
                                          Text('Subscribers are more likely to meet people with similar goals and interests.', style: TextStyle(color: AppColors.text)),
                                          const SizedBox(height: 18),
                                          ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: AppColors.vibrantCoral,
                                              foregroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                                            ),
                                            child: const Text('Start your journey now!'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Footer (reuse from landing page)
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
    );
  }
}

// Stats column widget
class _StatColumn extends StatelessWidget {
  final String label;
  final String value;
  const _StatColumn({Key? key, required this.label, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
      child: Column(
        children: [
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: AppColors.primary)),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(color: AppColors.text)),
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
