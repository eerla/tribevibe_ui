import 'package:flutter/material.dart';
import '../services/auth_service.dart';

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
    final Color primaryColor = Color(0xFF22223B);
    final Color accentColor = Color(0xFF4A4E69);
    final Color backgroundColor = Color(0xFFF2E9E4);
    final Color cardColor = Colors.white;
    final Color buttonColor = Color(0xFF9A8C98);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Profile', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: _logout,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : user == null
              ? Center(child: Text('Failed to load profile'))
              : Center(
                  child: Card(
                    color: cardColor,
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Name:', style: TextStyle(color: accentColor, fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          Text(user!['name'] ?? '', style: TextStyle(fontSize: 22, color: primaryColor)),
                          SizedBox(height: 16),
                          Text('Email:', style: TextStyle(color: accentColor, fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          Text(user!['email'] ?? '', style: TextStyle(fontSize: 18, color: primaryColor)),
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }
}
