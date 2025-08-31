import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CityCircle extends StatelessWidget {
  final String name;
  final String? imageUrl;
  final bool isBold;
  const CityCircle({required this.name, this.imageUrl, this.isBold = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 18),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
            backgroundColor: Colors.grey[300],
            child: imageUrl == null ? const Icon(Icons.location_city, size: 38, color: Colors.white70) : null,
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: 15,
              decoration: isBold ? TextDecoration.underline : null,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class HowItWorksCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String linkText;
  final VoidCallback onTap;
  const HowItWorksCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.linkText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.button, size: 38),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                const SizedBox(height: 6),
                Text(description, style: const TextStyle(fontSize: 15, color: Colors.black87)),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    linkText,
                    style: TextStyle(color: AppColors.button, fontWeight: FontWeight.bold, fontSize: 15, decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
