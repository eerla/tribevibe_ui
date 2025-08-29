import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_colors.dart';

class ModernCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final double elevation;
  final double borderRadius;
  final Duration animationDelay;

  const ModernCard({
    Key? key,
    required this.child,
    this.onTap,
    this.margin,
    this.color,
    this.elevation = 4.0,
    this.borderRadius = 20.0,
    this.animationDelay = Duration.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final card = Material(
      color: color ?? AppColors.card,
      elevation: elevation,
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        onTap: onTap,
        child: child,
      ),
    );
    return Animate(
      effects: [
        FadeEffect(duration: 400.ms, delay: animationDelay),
        SlideEffect(
          begin: const Offset(0, 0.1),
          end: Offset.zero,
          duration: 400.ms,
          delay: animationDelay,
        ),
      ],
      child: Container(
        margin: margin ?? const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: card,
      ),
    );
  }
}
