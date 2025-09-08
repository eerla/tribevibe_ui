import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import './_landing_page_extras.dart';
import '../theme/app_text.dart';
import '../widgets/event_card.dart';
import '../screens/login_screen.dart';
import '../widgets/LandingAppBar.dart';
import '../widgets/HeroSection.dart';
import '../screens/signup_screen.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
  static const String _heroDescription =
      'Find and join events of all types, connect with like-minded people, and share your passions. Flink makes it easy to discover new friendships and experiences in your city or online.';
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 32, horizontal: 16),
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
                                          color: AppColors.secondary
                                              .withOpacity(0.08),
                                          borderRadius:
                                              BorderRadius.circular(48),
                                          image: const DecorationImage(
                                            image:
                                                AssetImage('assets/hero.jpg'),
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
                      const SizedBox(height: 10),
                      // Responsive Featured Events Section
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Explore Featured Events',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : AppColors.primary,
                                      fontSize: ResponsiveValue<double>(
                                        context,
                                        defaultValue: 32,
                                        conditionalValues: [
                                          Condition.smallerThan(
                                              name: TABLET, value: 18),
                                          Condition.largerThan(
                                              name: DESKTOP, value: 26),
                                        ],
                                      ).value,
                                    )),
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
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: crossAxisCount,
                                    crossAxisSpacing: 16,
                                    mainAxisSpacing: 16,
                                    childAspectRatio: isDesktop ? 0.75 : 1.0,
                                  ),
                                  itemBuilder: (context, index) {
                                    // Add fade-in animation using AnimatedOpacity
                                    return TweenAnimationBuilder<double>(
                                      tween: Tween(begin: 0, end: 1),
                                      duration: Duration(
                                          milliseconds: 400 + index * 120),
                                      builder: (context, value, child) {
                                        return Opacity(
                                          opacity: value,
                                          child: Transform.scale(
                                            scale: 0.98 + value * 0.02,
                                            child: EventCard(
                                              title: eventTitles[index],
                                              date: eventDates[index],
                                              location: eventLocations[index],
                                              imagePath: index == 0
                                                  ? 'assets/coffee.jpg'
                                                  : null, // Show image for first event
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
                      const SizedBox(height: 10),

                      // promo
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 32, horizontal: 16),
                        child: Center(
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 900),
                            decoration: BoxDecoration(
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? const Color(0xFF232323)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(40),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.black.withOpacity(0.12)
                                      : Colors.grey.withOpacity(0.18),
                                  blurRadius: 32,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                // Decorative shapes (left)
                                Positioned(
                                  left: 0,
                                  bottom: 0,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(40),
                                        topLeft: Radius.circular(40)),
                                    child: Container(
                                      width: 180,
                                      height: 180,
                                      color:
                                          Colors.purpleAccent.withOpacity(0.12),
                                    ),
                                  ),
                                ),
                                // Decorative shapes (right)
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(40),
                                        bottomRight: Radius.circular(40)),
                                    child: Container(
                                      width: 160,
                                      height: 160,
                                      color:
                                          Colors.pinkAccent.withOpacity(0.12),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 40, horizontal: 32),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'Get started!',
                                          style: TextStyle(
                                            color: Colors.pinkAccent,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            letterSpacing: 1.2,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Text(
                                        'Join Flink',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.dark
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontSize: 32,
                                            ),
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        'People use Flink to meet new people, learn new things, find support, get out of their comfort zones, and pursue their passions, together. Membership is free.',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.dark
                                                  ? Colors.white70
                                                  : Colors.black87,
                                              fontSize: 18,
                                            ),
                                      ),
                                      const SizedBox(height: 28),
                                      ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Theme.of(context).brightness ==
                                                      Brightness.dark
                                                  ? Colors.grey[900]
                                                  : Colors.black,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(24),
                                          ),
                                          elevation: 8,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 32, vertical: 18),
                                        ),
                                        child: const Text(
                                          'Sign up for free',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Add gap after featured events section
                      const SizedBox(height: 10),
                      // Explore Categories Section
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 24, horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Explore Top Categories',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : AppColors.primary,
                                    fontSize: ResponsiveValue<double>(
                                      context,
                                      defaultValue: 32,
                                      conditionalValues: [
                                        Condition.smallerThan(
                                            name: TABLET, value: 18),
                                        Condition.largerThan(
                                            name: DESKTOP, value: 26),
                                      ],
                                    ).value,
                                  ),
                            ),
                            const SizedBox(height: 12),
                            LayoutBuilder(
                              builder: (context, constraints) {
                                final breakpoints =
                                    ResponsiveBreakpoints.of(context);
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
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: crossAxisCount,
                                    crossAxisSpacing: 16,
                                    mainAxisSpacing: 16,
                                    childAspectRatio: cardAspect,
                                  ),
                                  itemBuilder: (context, index) {
                                    final cat = categories[index];
                                    return TweenAnimationBuilder<double>(
                                      tween: Tween(begin: 0, end: 1),
                                      duration: Duration(
                                          milliseconds: 400 + index * 100),
                                      builder: (context, value, child) {
                                        return Opacity(
                                          opacity: value,
                                          child: Transform.scale(
                                            scale: 0.98 + value * 0.02,
                                            child: Card(
                                              elevation: 0,
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.dark
                                                  ? cat.color.withOpacity(0.18)
                                                  : cat.color.withOpacity(0.08),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  vertical:
                                                      ResponsiveValue<double>(
                                                          context,
                                                          defaultValue: 24,
                                                          conditionalValues: [
                                                        Condition.smallerThan(
                                                            name: TABLET,
                                                            value: 16)
                                                      ]).value!,
                                                  horizontal:
                                                      ResponsiveValue<double>(
                                                          context,
                                                          defaultValue: 16,
                                                          conditionalValues: [
                                                        Condition.smallerThan(
                                                            name: TABLET,
                                                            value: 10)
                                                      ]).value!,
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: cat.color
                                                            .withOpacity(0.18),
                                                        shape: BoxShape.circle,
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12),
                                                      child: Icon(
                                                        cat.icon,
                                                        color: cat.color,
                                                        size: ResponsiveValue<
                                                                double>(context,
                                                            defaultValue: 36,
                                                            conditionalValues: [
                                                              Condition
                                                                  .smallerThan(
                                                                      name:
                                                                          TABLET,
                                                                      value: 28)
                                                            ]).value,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 12),
                                                    Text(
                                                      cat.label,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleMedium
                                                          ?.copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Theme.of(context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .dark
                                                                ? Colors.white
                                                                : AppColors
                                                                    .primaryText,
                                                            fontSize:
                                                                ResponsiveValue<
                                                                        double>(
                                                                    context,
                                                                    defaultValue:
                                                                        16,
                                                                    conditionalValues: [
                                                                  Condition.smallerThan(
                                                                      name:
                                                                          TABLET,
                                                                      value: 13)
                                                                ]).value,
                                                          ),
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                      // Add gap after categories section
                      const SizedBox(height: 40),
                      // Popular Cities & How Flink Works Side by Side
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final breakpoints = ResponsiveBreakpoints.of(context);
                          bool isWide = constraints.maxWidth > 900;
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 32, horizontal: 8),
                            child: SizedBox(
                              width: constraints.maxWidth,
                              child: Flex(
                                direction:
                                    isWide ? Axis.horizontal : Axis.vertical,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Popular Cities
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeOut,
                                    width: isWide
                                        ? (constraints.maxWidth / 2) - 24
                                        : null,
                                    margin: EdgeInsets.only(
                                        right: isWide ? 32 : 0,
                                        bottom: isWide ? 0 : 32),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: ResponsiveValue<double>(
                                          context,
                                          defaultValue: 16,
                                          conditionalValues: [
                                            Condition.smallerThan(
                                                name: TABLET, value: 8)
                                          ]).value!,
                                      vertical: ResponsiveValue<double>(context,
                                          defaultValue: 18,
                                          conditionalValues: [
                                            Condition.smallerThan(
                                                name: TABLET, value: 10)
                                          ]).value!,
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? [
                                                AppColors.primary
                                                    .withOpacity(0.8),
                                                AppColors.primary
                                                    .withOpacity(0.8)
                                              ]
                                            : [
                                                AppColors.primary
                                                    .withOpacity(0.8),
                                                AppColors.primary
                                                    .withOpacity(0.8)
                                              ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(28),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? AppColors.primary
                                                  .withOpacity(0.10)
                                              : AppColors.primary
                                                  .withOpacity(0.08),
                                          blurRadius: 18,
                                          offset: const Offset(0, 8),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Popular cities on Flink',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall
                                              ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.dark
                                                    ? const Color.fromARGB(
                                                        255, 26, 26, 26)
                                                    : const Color.fromARGB(
                                                        255, 26, 26, 26),
                                                fontSize:
                                                    ResponsiveValue<double>(
                                                        context,
                                                        defaultValue: 32,
                                                        conditionalValues: [
                                                      Condition.smallerThan(
                                                          name: TABLET,
                                                          value: 18)
                                                    ]).value,
                                              ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          "Looking for fun things to do near you? See what Flink organizers are planning in cities around the country.",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.dark
                                                    ? const Color.fromARGB(
                                                        255, 46, 46, 46)
                                                    : const Color.fromARGB(
                                                        255, 46, 46, 46),
                                                fontSize:
                                                    ResponsiveValue<double>(
                                                        context,
                                                        defaultValue: 18,
                                                        conditionalValues: [
                                                      Condition.smallerThan(
                                                          name: TABLET,
                                                          value: 13)
                                                    ]).value,
                                              ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 24),
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: [
                                              for (final city in [
                                                {
                                                  'name': 'Hyderabad',
                                                  'image': 'assets/hyd.jpg'
                                                },
                                                {
                                                  'name': 'Bangalore',
                                                  'image': 'assets/blr.jpg'
                                                },
                                                {
                                                  'name': 'New Delhi',
                                                  'image': 'assets/nd.jpg'
                                                },
                                                {
                                                  'name': 'Chennai',
                                                  'image': 'assets/che.jpg'
                                                },
                                                {
                                                  'name': 'Kolkata',
                                                  'image': 'assets/kol.png'
                                                },
                                              ])
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 8),
                                                  child: Column(
                                                    children: [
                                                      AnimatedContainer(
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    400),
                                                        curve: Curves.easeOut,
                                                        width: 72,
                                                        height: 72,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          gradient:
                                                              LinearGradient(
                                                            colors: Theme.of(
                                                                            context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .dark
                                                                ? [
                                                                    AppColors
                                                                        .primary
                                                                        .withOpacity(
                                                                            0.22),
                                                                    Colors.white
                                                                        .withOpacity(
                                                                            0.18)
                                                                  ]
                                                                : [
                                                                    AppColors
                                                                        .primary
                                                                        .withOpacity(
                                                                            0.18),
                                                                    Colors.white
                                                                        .withOpacity(
                                                                            0.9)
                                                                  ],
                                                            begin: Alignment
                                                                .topLeft,
                                                            end: Alignment
                                                                .bottomRight,
                                                          ),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Theme.of(context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .dark
                                                                  ? AppColors
                                                                      .primary
                                                                      .withOpacity(
                                                                          0.18)
                                                                  : AppColors
                                                                      .primary
                                                                      .withOpacity(
                                                                          0.10),
                                                              blurRadius: 12,
                                                              offset:
                                                                  const Offset(
                                                                      0, 4),
                                                            ),
                                                          ],
                                                        ),
                                                        child: ClipOval(
                                                          child: Image.asset(
                                                            city['image']!,
                                                            fit: BoxFit.cover,
                                                            width: 72,
                                                            height: 72,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Text(
                                                        city['name']!,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium
                                                            ?.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Theme.of(context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .dark
                                                                  ? const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      46,
                                                                      46,
                                                                      46)
                                                                  : AppColors
                                                                      .primaryText,
                                                              fontSize: ResponsiveValue<
                                                                      double>(
                                                                  context,
                                                                  defaultValue:
                                                                      15,
                                                                  conditionalValues: [
                                                                    Condition.smallerThan(
                                                                        name:
                                                                            TABLET,
                                                                        value:
                                                                            13)
                                                                  ]).value,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // How Flink Works
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeOut,
                                    width: isWide
                                        ? (constraints.maxWidth / 2) - 24
                                        : null,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: ResponsiveValue<double>(
                                          context,
                                          defaultValue: 12,
                                          conditionalValues: [
                                            Condition.smallerThan(
                                                name: TABLET, value: 6)
                                          ]).value!,
                                      vertical: ResponsiveValue<double>(context,
                                          defaultValue: 18,
                                          conditionalValues: [
                                            Condition.smallerThan(
                                                name: TABLET, value: 10)
                                          ]).value!,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? AppColors.card.withOpacity(0.12)
                                          : AppColors.card.withOpacity(0.04),
                                      borderRadius: BorderRadius.circular(22),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? AppColors.primary
                                                  .withOpacity(0.12)
                                              : AppColors.primary
                                                  .withOpacity(0.07),
                                          blurRadius: 14,
                                          offset: const Offset(0, 6),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'How Flink works',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall
                                              ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.dark
                                                    ? Colors.white
                                                    : AppColors.primary,
                                                fontSize:
                                                    ResponsiveValue<double>(
                                                        context,
                                                        defaultValue: 22,
                                                        conditionalValues: [
                                                      Condition.smallerThan(
                                                          name: TABLET,
                                                          value: 18)
                                                    ]).value,
                                              ),
                                        ),
                                        const SizedBox(height: 18),
                                        HowItWorksCard(
                                          icon: Icons.search,
                                          title: 'Discover events and groups',
                                          description:
                                              "See who's hosting local events for all the things you love",
                                          linkText: 'Search events and groups',
                                          onTap: () {},
                                        ),
                                        const SizedBox(height: 18),
                                        HowItWorksCard(
                                          icon: Icons.add,
                                          title: 'Start a group to host events',
                                          description:
                                              'Create your own Flink group, and draw from a community of millions',
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
                      // Call to Action Section
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 32, horizontal: 24),
                        child: Column(
                          children: [
                            Text(
                              'Ready to start your own group or event?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 32, vertical: 16),
                                elevation: 6,
                                shadowColor:
                                    AppColors.primary.withOpacity(0.18),
                              ),
                              child: const Text('Start a Group',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),

                      // Footer (full width)
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? [
                                      Color(0xFF232323),
                                      AppColors.primary.withOpacity(0.12)
                                    ]
                                  : [
                                      Colors.white,
                                      AppColors.primary.withOpacity(0.08)
                                    ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.black.withOpacity(0.18)
                                    : AppColors.primary.withOpacity(0.10),
                                blurRadius: 24,
                                offset: const Offset(0, -8),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: ResponsiveValue<double>(context,
                                  defaultValue: 32,
                                  conditionalValues: [
                                    Condition.smallerThan(
                                        name: TABLET, value: 20)
                                  ]).value!,
                              horizontal: ResponsiveValue<double>(context,
                                  defaultValue: 24,
                                  conditionalValues: [
                                    Condition.smallerThan(
                                        name: TABLET, value: 12)
                                  ]).value!,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Animated logo/title
                                Text('Flink',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall
                                            ?.copyWith(
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.dark
                                                  ? Colors.white
                                                  : AppColors.secondaryText,
                                              fontWeight: FontWeight.bold,
                                              fontSize: ResponsiveValue<double>(
                                                  context,
                                                  defaultValue: 24,
                                                  conditionalValues: [
                                                    Condition.smallerThan(
                                                        name: TABLET, value: 18)
                                                  ]).value,
                                            ))
                                    .animate()
                                    .fadeIn(duration: 600.ms)
                                    .slideY(
                                        begin: 0.3, end: 0, duration: 600.ms),
                                const SizedBox(height: 12),
                                // Animated links
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
                                  ]
                                      .animate(interval: 120.ms)
                                      .fadeIn(duration: 400.ms)
                                      .slideY(
                                          begin: 0.2, end: 0, duration: 400.ms),
                                ),
                                const SizedBox(height: 16),
                                // Animated copyright
                                Text('© 2025 Flink. All rights reserved.',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: Theme.of(context)
                                                          .brightness ==
                                                      Brightness.dark
                                                  ? Colors.white70
                                                  : AppColors.secondaryText,
                                              fontSize: ResponsiveValue<double>(
                                                  context,
                                                  defaultValue: 14,
                                                  conditionalValues: [
                                                    Condition.smallerThan(
                                                        name: TABLET, value: 12)
                                                  ]).value,
                                            ))
                                    .animate()
                                    .fadeIn(duration: 800.ms)
                                    .slideY(
                                        begin: 0.2, end: 0, duration: 800.ms),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // Add gap after footer section
                      const SizedBox(height: 40),
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
      child: Text(
        label,
        style: TextStyle(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : AppColors.secondaryText,
          fontSize: ResponsiveValue<double>(
            context,
            defaultValue: 14,
            conditionalValues: [
              Condition.smallerThan(name: TABLET, value: 12),
            ],
          ).value,
          fontWeight: FontWeight.w500,
        ),
      ),
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

  Color get _baseColor => widget.isSignup
      ? AppColors.primary.withOpacity(0.85)
      : AppColors.primary.withOpacity(0.7);
  Color get _hoverColor =>
      widget.isSignup ? AppColors.primary : AppColors.primary.withOpacity(1.0);

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
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.isSignup ? 24 : 16)),
          padding: EdgeInsets.symmetric(
              horizontal: widget.isSignup ? 24 : 20,
              vertical: widget.isSignup ? 14 : 12),
          side: widget.isSignup
              ? BorderSide(color: AppColors.primary, width: 2)
              : BorderSide.none,
        ),
        child: widget.icon == null
            ? Text(widget.label,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  letterSpacing: 0.5,
                ))
            : Row(
                children: [
                  Icon(widget.icon, color: Colors.white, size: 18),
                  const SizedBox(width: 8),
                  Text(widget.label,
                      style: GoogleFonts.poppins(
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
