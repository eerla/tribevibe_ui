import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ProfileCard extends StatelessWidget {
  final String name;
  final String email;

  const ProfileCard({
    super.key,
    required this.name,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.card,
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
            Text('Name:', style: TextStyle(color: AppColors.accentText, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text(name, style: TextStyle(fontSize: 22, color: AppColors.primary)),
            SizedBox(height: 16),
            Text('Email:', style: TextStyle(color: AppColors.accentText, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Text(email, style: TextStyle(fontSize: 18, color: AppColors.primary)),
          ],
        ),
      ),
    );
  }
}
