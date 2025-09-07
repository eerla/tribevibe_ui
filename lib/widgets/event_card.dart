import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../theme/app_colors.dart';

class EventCard extends StatelessWidget {
  final String title;
  final String date;
  final String location;
  final String? imagePath;

  const EventCard({
    Key? key,
    required this.title,
    required this.date,
    required this.location,
    this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final breakpoint = ResponsiveBreakpoints.of(context);
    final isMobile = breakpoint.isMobile;
    final isTablet = breakpoint.isTablet;
    final cardPadding = isMobile
        ? EdgeInsets.fromLTRB(10, 10, 10, 8)
        : isTablet
            ? EdgeInsets.fromLTRB(16, 16, 16, 12)
            : EdgeInsets.fromLTRB(20, 20, 20, 16);
    final titleFontSize = isMobile
        ? 18.0
        : isTablet
            ? 17.0
            : 16.0;
    final detailFontSize = isMobile
        ? 12.0
        : isTablet
            ? 14.0
            : 12.0;
    return Material(
      color: isDark ? AppColors.darkCard : AppColors.card,
      elevation: 4,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {},
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: isDark ? Colors.black26 : Colors.grey.withOpacity(0.12),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 2,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  child: imagePath != null
                      ? Image.asset(
                          imagePath!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        )
                      : Container(
                          color: isDark
                              ? AppColors.primary.withOpacity(0.08)
                              : AppColors.secondaryCard,
                          child: Center(
                            child: Icon(
                              Icons.event,
                              size: isMobile ? 32 : 48,
                              color: isDark ? AppColors.primary : Colors.grey,
                            ),
                          ),
                        ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: cardPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: isDark
                                  ? AppColors.darkPrimaryText
                                  : AppColors.primaryText,
                              fontSize: titleFontSize,
                            ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: isMobile ? 4.0 : 8.0),
                      Row(
                        children: [
                          Icon(Icons.calendar_today,
                              size: isMobile ? 13.0 : 16.0,
                              color: isDark
                                  ? AppColors.darkSecondaryText
                                  : AppColors.secondaryText),
                          SizedBox(width: isMobile ? 4.0 : 6.0),
                          Expanded(
                            child: Text(
                              date,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: isDark
                                        ? AppColors.darkSecondaryText
                                        : AppColors.secondaryText,
                                    fontSize: detailFontSize,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: isMobile ? 2.0 : 6.0),
                      Row(
                        children: [
                          Icon(Icons.location_on,
                              size: isMobile ? 13.0 : 16.0,
                              color: isDark
                                  ? AppColors.darkAccentText
                                  : AppColors.accentText),
                          SizedBox(width: isMobile ? 4.0 : 6.0),
                          Expanded(
                            child: Text(
                              location,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: isDark
                                        ? AppColors.darkSecondaryText
                                        : AppColors.secondaryText,
                                    fontSize: detailFontSize,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}