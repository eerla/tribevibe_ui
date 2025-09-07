import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../theme/app_text.dart';
import '../widgets/event_card.dart';
import '../screens/login_screen.dart';
import '../widgets/LandingAppBar.dart';
import '../widgets/HeroSection.dart';
import '../screens/signup_screen.dart';

// Category data model for responsive grid
class _CategoryData {
  final String label;
  final IconData icon;
  final Color color;
  const _CategoryData(this.label, this.icon, this.color);
}

const List<_CategoryData> categories = [
  _CategoryData('Travel and Outdoor', Icons.park, Colors.green),
  _CategoryData('Social Activities', Icons.groups, Colors.purple),
  _CategoryData('Hobbies & Passions', Icons.palette, Colors.orange),
  _CategoryData('Sports & Fitness', Icons.sports_soccer, Colors.blue),
  _CategoryData('Health & Wellbeing', Icons.spa, Colors.teal),
  _CategoryData('Technology', Icons.computer, Colors.pink),
  _CategoryData('Games', Icons.casino, Colors.cyan),
];

class LandingPage extends StatelessWidget {
  static const String _heroHeadline = 'This is the modern way to meet people';
  static const String _heroDescription = 'Find and join events of all types, connect with like-minded people, and share your passions. Flink makes it easy to discover new friendships and experiences in your city or online.';
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBreakpoints.builder(
      breakpoints: [
        const Breakpoint(start: 0, end: 450, name: MOBILE),
        const Breakpoint(start: 451, end: 800, name: TABLET),
        const Breakpoint(start: 801, end: 1920, name: DESKTOP),
        const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
      ],
      child: Scaffold(
        appBar: const LandingAppBar(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final breakpoints = ResponsiveBreakpoints.of(context);
                  final isMobile = breakpoints.isMobile;
                  final isTablet = breakpoints.isTablet;
                  final isDesktop = breakpoints.isDesktop;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (isMobile) ...[
                        HeroSection(
                          headline: _heroHeadline,
                          description: _heroDescription,
                          showSearchBar: true,
                        ),
                        const SizedBox(height: 32),
                      ] else ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Search bar row
                              HeroSection(
                                headline: '',
                                description: '',
                                showSearchBar: true,
                                padding: const EdgeInsets.only(bottom: 32),
                              ),
                              // Hero text and image row
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: HeroSection(
                                      headline: _heroHeadline,
                                      description: _heroDescription,
                                      showSearchBar: false,
                                      padding: const EdgeInsets.only(right: 32),
                                    ),
                                  ),
                                  const SizedBox(width: 40),
                                  Expanded(
                                    flex: 2,
                                    child: Center(
                                      child: Container(
                                        width: 440,
                                        height: 360,
                                        decoration: BoxDecoration(
                                          color: AppColors.secondary.withOpacity(0.08),
                                          borderRadius: BorderRadius.circular(48),
                                          image: const DecorationImage(
                                            image: AssetImage('assets/hero.jpg'),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                      // Add gap after hero section
                      const SizedBox(height: 40),
                        // Responsive Featured Events Section
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Explore Featured Events',
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).brightness == Brightness.dark
                                      ? Colors.white
                                      : AppColors.primary,
                                ),
                              ),
                              const SizedBox(height: 12),
                              LayoutBuilder(
                                builder: (context, constraints) {
                                  int crossAxisCount = constraints.maxWidth > 900
                                      ? 4
                                      : constraints.maxWidth > 600
                                          ? 2
                                          : 1;
                                  final List<String> eventTitles = [
                                    'Flutter Community Meetup',
                                    'Yoga in the Park',
                                    'Startup Pitch Night',
                                    'Art & Wine Evening',
                                  ];
                                  final List<String> eventDates = [
                                    'Sep 10, 2025 · 6:00 PM',
                                    'Sep 12, 2025 · 8:00 AM',
                                    'Sep 15, 2025 · 7:30 PM',
                                    'Sep 18, 2025 · 5:00 PM',
                                  ];
                                  final List<String> eventLocations = [
                                    'Downtown Community Hall',
                                    'Central Park',
                                    'Tech Hub Auditorium',
                                    'Vineyard Art Space',
                                  ];
                                  return GridView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: eventTitles.length,
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: crossAxisCount,
                                      crossAxisSpacing: 16,
                                      mainAxisSpacing: 16,
                                      childAspectRatio: isDesktop ? 0.75 : 1.0,
                                    ),
                                    itemBuilder: (context, index) {
                                      // Add fade-in animation using AnimatedOpacity
                                      return TweenAnimationBuilder<double>(
                                        tween: Tween(begin: 0, end: 1),
                                        duration: Duration(milliseconds: 400 + index * 120),
                                        builder: (context, value, child) {
                                          return Opacity(
                                            opacity: value,
                                            child: Transform.scale(
                                              scale: 0.98 + value * 0.02,
                                              child: EventCard(
                                                title: eventTitles[index],
                                                date: eventDates[index],
                                                location: eventLocations[index],
                                                imagePath: index == 0 ? 'assets/coffee.jpg' : null, // Show image for first event
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        // Add gap after featured events section
                        const SizedBox(height: 40),
                        // Explore Categories Section
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Explore Top Categories',
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).brightness == Brightness.dark
                                      ? Colors.white
                                      : AppColors.primary,
                                  fontSize: ResponsiveValue<double>(
                                    context,
                                    defaultValue: 22,
                                    conditionalValues: [
                                      Condition.smallerThan(name: TABLET, value: 18),
                                      Condition.largerThan(name: DESKTOP, value: 26),
                                    ],
                                  ).value,
                                ),
                              ),
                              const SizedBox(height: 12),
                              LayoutBuilder(
                                builder: (context, constraints) {
                                  final breakpoints = ResponsiveBreakpoints.of(context);
                                  int crossAxisCount = breakpoints.isMobile
                                      ? 2
                                      : constraints.maxWidth > 900
                                          ? 4
                                          : constraints.maxWidth > 600
                                              ? 2
                                              : 1;
                                  double cardAspect = constraints.maxWidth > 900
                                      ? 1.5
                                      : constraints.maxWidth > 600
                                          ? 1.7
                                          : 1.0;
                                  return GridView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: categories.length,
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: crossAxisCount,
                                      crossAxisSpacing: 16,
                                      mainAxisSpacing: 16,
                                      childAspectRatio: cardAspect,
                                    ),
                                    itemBuilder: (context, index) {
                                      final cat = categories[index];
                                      return TweenAnimationBuilder<double>(
                                        tween: Tween(begin: 0, end: 1),
                                        duration: Duration(milliseconds: 400 + index * 100),
                                        builder: (context, value, child) {
                                          return Opacity(
                                            opacity: value,
                                            child: Transform.scale(
                                              scale: 0.98 + value * 0.02,
                                              child: Card(
                                                elevation: 0,
                                                color: Theme.of(context).brightness == Brightness.dark
                                                    ? cat.color.withOpacity(0.18)
                                                    : cat.color.withOpacity(0.08),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: ResponsiveValue<double>(context, defaultValue: 24, conditionalValues: [Condition.smallerThan(name: TABLET, value: 16)]).value!,
                                                    horizontal: ResponsiveValue<double>(context, defaultValue: 16, conditionalValues: [Condition.smallerThan(name: TABLET, value: 10)]).value!,
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Container(
                                                        decoration: BoxDecoration(
                                                          color: cat.color.withOpacity(0.18),
                                                          shape: BoxShape.circle,
                                                        ),
                                                        padding: const EdgeInsets.all(12),
                                                        child: Icon(
                                                          cat.icon,
                                                          color: cat.color,
                                                          size: ResponsiveValue<double>(context, defaultValue: 36, conditionalValues: [Condition.smallerThan(name: TABLET, value: 28)]).value,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 12),
                                                      Text(
                                                        cat.label,
                                                        textAlign: TextAlign.center,
                                                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                                          fontWeight: FontWeight.bold,
                                                          color: Theme.of(context).brightness == Brightness.dark
                                                              ? Colors.white
                                                              : AppColors.primaryText,
                                                          fontSize: ResponsiveValue<double>(context, defaultValue: 16, conditionalValues: [Condition.smallerThan(name: TABLET, value: 13)]).value,
                                                        ),
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),

                      ],
                    );
                  },
              ),
            ),
          ),
        ),
      ),
    );
    }
  }

// Footer link widget for footer section
class _FooterLink extends StatelessWidget {
  final String label;
  const _FooterLink({required this.label});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(label, style: const TextStyle(color: Colors.white70)),
    );
  }
}
// Add this widget at the bottom of the file
class _HoverButton extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool isSignup;
  const _HoverButton({
    required this.label,
    required this.onPressed,
    this.icon,
    this.isSignup = false,
    Key? key,
  }) : super(key: key);

  @override
  State<_HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<_HoverButton> {
  bool _isHovered = false;

  Color get _baseColor => widget.isSignup ? AppColors.primary.withOpacity(0.85) : AppColors.primary.withOpacity(0.7);
  Color get _hoverColor => widget.isSignup ? AppColors.primary : AppColors.primary.withOpacity(1.0);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: _isHovered ? _hoverColor : _baseColor,
          elevation: widget.isSignup ? 2 : 6,
          shadowColor: AppColors.primary.withOpacity(_isHovered ? 0.4 : 0.2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(widget.isSignup ? 24 : 16)),
          padding: EdgeInsets.symmetric(horizontal: widget.isSignup ? 24 : 20, vertical: widget.isSignup ? 14 : 12),
          side: widget.isSignup ? BorderSide(color: AppColors.primary, width: 2) : BorderSide.none,
        ),
        child: widget.icon == null
            ? Text(widget.label, style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
                letterSpacing: 0.5,
              ))
            : Row(
                children: [
                  Icon(widget.icon, color: Colors.white, size: 18),
                  const SizedBox(width: 8),
                  Text(widget.label, style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    letterSpacing: 0.5,
                  )),
                ],
              ),
      ),
    );
  }
}