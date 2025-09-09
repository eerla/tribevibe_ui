import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../theme/app_colors.dart';
import '../screens/login_screen.dart';
import '../screens/signup_screen.dart';

class LandingAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LandingAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    final breakpoints = ResponsiveBreakpoints.of(context);
    final isMobile = breakpoints.isMobile;
    final isTablet = breakpoints.isTablet;
    double fontSize;
    double horizontalPadding;
    double iconSize;
    double gap1;
    double gap2;
    double gap3;
    if (isMobile) {
      fontSize = 20;
      horizontalPadding = 12;
      iconSize = 22;
      gap1 = 8;
      gap2 = 4;
      gap3 = 8;
    } else if (isTablet) {
      fontSize = 22;
      horizontalPadding = 20;
      iconSize = 24;
      gap1 = 10;
      gap2 = 6;
      gap3 = 12;
    } else {
      fontSize = 22;
      horizontalPadding = 20;
      iconSize = 20;
      gap1 = 6;
      gap2 = 2;
      gap3 = 6;
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        boxShadow: [BoxShadow(blurRadius: 12, color: Colors.black12)],
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding, vertical: isMobile ? 4 : 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/logo1.png',
                    height: 48, // adjust as needed
                    fit: BoxFit.contain,
                  ),
                  // SizedBox(width: gap1),
                  Text('link',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: AppColors.primaryText,
                                fontSize: fontSize,
                              )),
                ],
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () => LoginSheet.show(context),
                    child: Text('Log in', style: TextStyle(fontSize: fontSize)),
                  ),
                  SizedBox(width: gap2),
                  TextButton.icon(
                    onPressed: () => SignupSheet.show(context),
                    icon: Icon(Icons.person_add, size: iconSize),
                    label:
                        Text('Sign up', style: TextStyle(fontSize: fontSize)),
                  ),
                  SizedBox(width: gap3),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
