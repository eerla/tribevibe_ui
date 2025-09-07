import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';

class HeroSection extends StatelessWidget {
  final String headline;
  final String description;
  final bool showSearchBar;
  final EdgeInsetsGeometry? padding;
  const HeroSection({
    super.key,
    required this.headline,
    required this.description,
    this.showSearchBar = true,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
  final breakpoints = ResponsiveBreakpoints.of(context);
  final isMobile = breakpoints.isMobile;
  final isTablet = breakpoints.isTablet;
  // Removed unused isDesktop
    double headlineFontSize;
    double bodyFontSize;
    double verticalPadding;
    double horizontalPadding;
    double spacing1;
    double spacing2;
    double searchSpacing;
    double headlineLineHeight;

    if (isMobile) {
      headlineFontSize = 28;
      bodyFontSize = 16;
      verticalPadding = 32;
      horizontalPadding = 16;
      spacing1 = 12;
      spacing2 = 20;
      searchSpacing = 8;
      headlineLineHeight = 1.2;
    } else if (isTablet) {
      headlineFontSize = 32;
      bodyFontSize = 17;
      verticalPadding = 40;
      horizontalPadding = 20;
      spacing1 = 16;
      spacing2 = 24;
      searchSpacing = 10;
      headlineLineHeight = 1.2;
    } else {
      // Desktop: further reduce font size, increase line height, and adjust spacing for visual balance
      headlineFontSize = 48;
      bodyFontSize = 22;
      verticalPadding = 24;
      horizontalPadding = 20;
      spacing1 = 8;
      spacing2 = 14;
      searchSpacing = 8;
      headlineLineHeight = 1.35;
    }

    return Padding(
      padding: padding ?? EdgeInsets.symmetric(
        vertical: verticalPadding,
        horizontal: horizontalPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showSearchBar) ...[
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                vertical: isMobile ? 40 : 70,
                horizontal: isMobile ? 8 : 32,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary.withOpacity(1), AppColors.primary.withOpacity(1)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(32),
                boxShadow: [BoxShadow(blurRadius: 24, color: Colors.black12)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Find your Tribe, Join the Vibe.',
                    style: TextStyle(
                      fontSize: isMobile ? 24 : 72,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 15, 15, 15).withOpacity(0.9),
                      shadows: [const Shadow(blurRadius: 8, color: Colors.black26)],
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Discover and join local groups, meet new people, and explore your interests.',
                    style: TextStyle(
                      fontSize: isMobile ? 15 : 26,
                      color: const Color.fromARGB(255, 15, 15, 15).withOpacity(0.85),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          style: TextStyle(
                            fontSize: isMobile ? 22 : 28,
                            color: AppColors.primary.withOpacity(0.7),
                          ),
                          decoration: InputDecoration(
                            hintText: 'Search events, groups, or interests',
                            hintStyle: TextStyle(
                              fontSize: isMobile ? 22 : 28,
                              color: AppColors.primary.withOpacity(0.3),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Icon(Icons.search, color: AppColors.primary, size: isMobile ? 24 : 28),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: searchSpacing),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.button,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          elevation: 4,
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 18 : 22,
                            vertical: isMobile ? 10 : 14,
                          ),
                        ),
                        child: Text('Search', style: TextStyle(
                          color: Colors.white,
                          fontSize: isMobile ? 16 : 18,
                          fontWeight: FontWeight.w600,
                        )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: spacing2),
          ],
          Text(
            headline,
            style: TextStyle(
              fontSize: headlineFontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
              height: headlineLineHeight,
              letterSpacing: isMobile ? 0.5 : 0.2,
            ),
            textAlign: TextAlign.left,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: spacing1),
          Text(
            description,
            style: TextStyle(
              fontSize: bodyFontSize,
              color: AppColors.secondaryText,
            ),
          ),
        ],
      ),
    );
  }
}
