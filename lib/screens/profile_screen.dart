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
  // Colors are now imported from AppColors

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
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
              : Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ProfileCard(
                        name: user!['name'] ?? '',
                        email: user!['email'] ?? '',
                      ),
                      const SizedBox(height: 24),
                      CustomButton(
                        text: 'Logout',
                        onPressed: _logout,
                        color: AppColors.button,
                        isFullWidth: false,
                      ),
                    ],
                  ),
                ),
    );
  }
}
