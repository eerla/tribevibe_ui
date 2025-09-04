import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import './_landing_page_extras.dart';
import '../widgets/event_card.dart';
import '../screens/login_screen.dart';
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
  _CategoryData('Art & Culture', Icons.theater_comedy, Colors.amber),
  _CategoryData('Games', Icons.casino, Colors.cyan),
];

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.card,
              child: Icon(Icons.people, color: AppColors.primary),
            ),
            const SizedBox(width: 12),
            Text('Flink', style: GoogleFonts.poppins(
              color: AppColors.primaryText,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            )),
          ],
        ),
        actions: [
          _HoverButton(
            label: 'Log in',
            onPressed: () => LoginSheet.show(context),
            icon: null,
            isSignup: false,
          ),
          const SizedBox(width: 8),
          _HoverButton(
            label: 'Sign up',
            onPressed: () => SignupSheet.show(context),
            icon: Icons.person_add,
            isSignup: true,
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isMobile = constraints.maxWidth < 600;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Hero Section
                    SizedBox(height: isMobile ? 8 : 32),
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      padding: EdgeInsets.symmetric(
                        vertical: isMobile ? 24 : 48,
                        horizontal: isMobile ? 12 : 24,
                      ),
                      // Decoration removed for a plain background
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Find your tribe. Join amazing events.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              color: AppColors.primaryText,
                              fontSize: isMobile ? 22 : 32,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                          SizedBox(height: isMobile ? 8 : 16),
                          Text(
                            'Discover and join local groups, meet new people, and explore your interests.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              color: AppColors.secondaryText,
                              fontSize: isMobile ? 14 : 18,
                            ),
                          ),
                          SizedBox(height: isMobile ? 16 : 32),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Search events, groups, or interests',
                                    filled: true,
                                    fillColor: AppColors.card,
                                    prefixIcon: Icon(Icons.search, color: AppColors.primary),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: isMobile ? 8 : 12),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.button,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                ),
                                child: const Text('Search', style: TextStyle(color: AppColors.buttonText)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Modern Two-Column Intro Section
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: isMobile ? 16 : 40,
                        horizontal: isMobile ? 8 : 16,
                      ),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          bool isWide = constraints.maxWidth > 700;
                          if (isWide) {
                            return Flex(
                              direction: Axis.horizontal,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Left: Text and Button
                                Flexible(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'This is the modern way to meet people',
                                        style: GoogleFonts.poppins(
                                          fontSize: isMobile ? 18 : 28,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primary,
                                          letterSpacing: 1.1,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      SizedBox(height: isMobile ? 10 : 18),
                                      Text(
                                        'Find and join events of all types, connect with like-minded people, and share your passions. Flink makes it easy to discover new friendships and experiences in your city or online.',
                                        style: GoogleFonts.inter(
                                          fontSize: isMobile ? 13 : 17,
                                          color: AppColors.secondaryText,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      SizedBox(height: isMobile ? 16 : 28),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: ElevatedButton(
                                          onPressed: () => SignupSheet.show(context),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors.button,
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                                            padding: EdgeInsets.symmetric(horizontal: isMobile ? 18 : 32, vertical: isMobile ? 10 : 16),
                                          ),
                                          child: Text('Join Flink', style: GoogleFonts.inter(
                                            color: AppColors.buttonText,
                                            fontSize: isMobile ? 14 : 18,
                                          )),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 40),
                                // Right: Hero Image (desktop only)
                                Flexible(
                                  flex: 2,
                                  child: Center(
                                    child: Container(
                                      width: 440, // doubled from 220
                                      height: 360, // doubled from 180
                                      decoration: BoxDecoration(
                                        color: AppColors.secondary.withOpacity(0.08),
                                        borderRadius: BorderRadius.circular(48), // doubled from 24
                                        image: DecorationImage(
                                          image: AssetImage('assets/hero.jpg'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Left: Text and Button
                                Text(
                                  'This is the modern way to meet people',
                                  style: GoogleFonts.poppins(
                                    fontSize: isMobile ? 18 : 28,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                    letterSpacing: 1.1,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: isMobile ? 10 : 18),
                                Text(
                                  'Find and join events of all types, connect with like-minded people, and share your passions. Flink makes it easy to discover new friendships and experiences in your city or online.',
                                  style: GoogleFonts.inter(
                                    fontSize: isMobile ? 13 : 17,
                                    color: AppColors.secondaryText,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: isMobile ? 16 : 28),
                                Align(
                                  alignment: Alignment.center,
                                  child: ElevatedButton(
                                    onPressed: () => SignupSheet.show(context),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.button,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                                      padding: EdgeInsets.symmetric(horizontal: isMobile ? 18 : 32, vertical: isMobile ? 10 : 16),
                                    ),
                                    child: Text('Join Flink', style: GoogleFonts.inter(
                                      color: AppColors.buttonText,
                                      fontSize: isMobile ? 14 : 18,
                                    )),
                                  ),
                                ),
                                SizedBox(height: isMobile ? 16 : 40),
                                // No image in mobile view
                              ],
                            );
                          }
                        },
                      ),
                    ),
                // Popular Cities & How Flink Works Side by Side
                LayoutBuilder(
                  builder: (context, constraints) {
                    bool isWide = constraints.maxWidth > 900;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 8),
                      child: SizedBox(
                        width: constraints.maxWidth,
                        child: Flex(
                          direction: isWide ? Axis.horizontal : Axis.vertical,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Popular Cities
                            Container(
                              width: isWide ? (constraints.maxWidth / 2) - 24 : null,
                              margin: EdgeInsets.only(right: isWide ? 32 : 0, bottom: isWide ? 0 : 32),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withOpacity(0.01), // light orangish
                                borderRadius: BorderRadius.circular(18),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withOpacity(0.12),
                                    blurRadius: 16,
                                    offset: Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text('Popular cities on Flink', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Looking for fun things to do near you? See what Flink organizers are planning in cities around the country.",
                                    style: TextStyle(color: AppColors.secondaryText, fontSize: 15),
                                  ),
                                  const SizedBox(height: 24),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        CityCircle(name: 'Hyderabad', imageUrl: '/assets/hyd.jpg', isBold: true),
                                        CityCircle(name: 'Bangalore', imageUrl: '/assets/blr.jpg', isBold: true),
                                        CityCircle(name: 'New Delhi', imageUrl: '/assets/nd.jpg', isBold: true),
                                        CityCircle(name: 'Chennai', imageUrl: '/assets/che.jpg', isBold: true),
                                        CityCircle(name: 'Kolkata', imageUrl: '/assets/kol.png', isBold: true),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // How Flink Works
                            Container(
                              width: isWide ? (constraints.maxWidth / 2) - 24 : null,
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text('How Flink works', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 18),
                                  HowItWorksCard(
                                    icon: Icons.search,
                                    title: 'Discover events and groups',
                                    description: "See who's hosting local events for all the things you love",
                                    linkText: 'Search events and groups',
                                    onTap: () {},
                                  ),
                                  const SizedBox(height: 18),
                                  HowItWorksCard(
                                    icon: Icons.add,
                                    title: 'Start a group to host events',
                                    description: 'Create your own Flink group, and draw from a community of millions',
                                    linkText: 'Start a group',
                                    onTap: () {},
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                // Explore Featured Events
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('Explore top categories', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          int crossAxisCount = constraints.maxWidth > 900
                              ? 4
                              : constraints.maxWidth > 600
                                  ? 2
                                  : 1;
                          return GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: categories.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 1.8, // Even more vertical space
                            ),
                            itemBuilder: (context, index) {
                              final cat = categories[index];
                              return SizedBox(
                                child: Card(
                                  color: Colors.grey[100],
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                  child: Center(
                                    child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(cat.icon, color: cat.color, size: 36),
                                      const SizedBox(height: 8),
                                      Text(
                                      cat.label,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryText),
                                      ),
                                    ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                // Responsive Featured Events Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('Featured Events', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          int crossAxisCount = constraints.maxWidth > 900
                              ? 4
                              : constraints.maxWidth > 600
                                  ? 2
                                  : 1;
                          // Define event data arrays here
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
                              childAspectRatio: 1.0,
                            ),
                            itemBuilder: (context, index) {
                              return EventCard(
                                title: eventTitles[index],
                                date: eventDates[index],
                                location: eventLocations[index],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                // Call to Action Section
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                  child: Column(
                    children: [
                      Text(
                        'Ready to start your own group or event?',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primary),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          elevation: 6,
                          shadowColor: AppColors.primary.withOpacity(0.18),
                        ),
                        child: const Text('Start a Group', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                // Footer (full width)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    color: const Color(0xFF232323), // Charcoal black
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Flink', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                          const SizedBox(height: 12),
                          Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 24,
                            children: [
                              _FooterLink(label: 'About'),
                              _FooterLink(label: 'Careers'),
                              _FooterLink(label: 'Blog'),
                              _FooterLink(label: 'Help'),
                              _FooterLink(label: 'Privacy'),
                              _FooterLink(label: 'Terms'),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text('© 2025 Flink. All rights reserved.', style: TextStyle(color: Colors.white70)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
              }
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