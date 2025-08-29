import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_colors.dart';

class ModernAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool centerTitle;
  final Widget? leading;
  final double elevation;
  final Color? backgroundColor;

  const ModernAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.centerTitle = true,
    this.leading,
    this.elevation = 0.0,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? AppColors.primary,
      elevation: elevation,
      centerTitle: centerTitle,
      leading: leading,
      actions: actions,
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22,
          color: Colors.white,
          letterSpacing: 1.2,
        ),
      ).animate().fade(duration: 400.ms).slideY(begin: -0.2, end: 0, duration: 400.ms),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
