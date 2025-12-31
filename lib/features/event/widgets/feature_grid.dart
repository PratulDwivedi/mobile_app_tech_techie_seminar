import 'package:flutter/material.dart';
import '../../common/models/screen_args_model.dart';
import '../../common/services/navigation_service.dart';

class FeatureGrid extends StatelessWidget {
  const FeatureGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        // Program Card
        FeatureCard(
          icon: Icons.calendar_today,
          title: 'Program',
          subtitle: 'Day & Session wise',
          gradientColors: const [Color(0xFF06B6D4), Color(0xFF2563EB)],
          onTap: () {
            ScreenArgsModel screenArgsModel = ScreenArgsModel(
              routeName: "program", // or "webview" if it's a web page
              name: "Program",
              data: {},
            );
            NavigationService.navigateTo(
              screenArgsModel.routeName,
              arguments: screenArgsModel,
            );
          },
        ),

        // Speakers Card
        FeatureCard(
          icon: Icons.mic,
          title: 'Speakers',
          subtitle: 'Expert lineup',
          gradientColors: const [Color(0xFF9333EA), Color(0xFFEC4899)],
          onTap: () {
            ScreenArgsModel screenArgsModel = ScreenArgsModel(
              routeName: "speakers", // or your speakers route
              name: "Speakers",
              data: {},
            );
            NavigationService.navigateTo(
              screenArgsModel.routeName,
              arguments: screenArgsModel,
            );
          },
        ),

        // Sponsors Card
        FeatureCard(
          icon: Icons.speaker_notes,
          title: 'Sponsors',
          subtitle: 'Connect & chat',
          gradientColors: const [
            Color.fromARGB(255, 12, 132, 92),
            Color.fromARGB(255, 12, 149, 133),
          ],
          onTap: () {
            ScreenArgsModel screenArgsModel = ScreenArgsModel(
              routeName: "sponsors",
              name: "Sponsors",
              data: {},
            );
            NavigationService.navigateTo(
              screenArgsModel.routeName,
              arguments: screenArgsModel,
            );
          },
        ),

        // Exhibitors Card
        FeatureCard(
          icon: Icons.card_membership,
          title: 'Exhibitors',
          subtitle: 'Visit exhibitor stalls',
          gradientColors: const [Color(0xFFF97316), Color(0xFFEF4444)],
          onTap: () {
            ScreenArgsModel screenArgsModel = ScreenArgsModel(
              routeName: "exhibitors",
              name: "Exhibitors",
              data: {},
            );
            NavigationService.navigateTo(
              screenArgsModel.routeName,
              arguments: screenArgsModel,
            );
          },
        ),

        // Registrations Card
        FeatureCard(
          icon: Icons.receipt,
          title: 'Registrations',
          subtitle: 'Registrations and fees',
          gradientColors: const [
            Color.fromARGB(255, 6, 119, 139),
            Color.fromARGB(255, 21, 65, 161),
          ],
          onTap: () {
            ScreenArgsModel screenArgsModel = ScreenArgsModel(
              routeName: "webview",
              name: "Registrations",
              data: {"page_id": 62}, // Update with actual page ID
            );
            NavigationService.navigateTo(
              screenArgsModel.routeName,
              arguments: screenArgsModel,
            );
          },
        ),

        // Delegates Card
        FeatureCard(
          icon: Icons.person,
          title: 'Delegates',
          subtitle: 'Delegate information',
          gradientColors: const [
            Color.fromARGB(255, 115, 54, 173),
            Color.fromARGB(255, 219, 80, 149),
          ],
          onTap: () {
            ScreenArgsModel screenArgsModel = ScreenArgsModel(
              routeName: "delegates",
              name: "Delegates",
              data: {},
            );
            NavigationService.navigateTo(
              screenArgsModel.routeName,
              arguments: screenArgsModel,
            );
          },
        ),
      ],
    );
  }
}

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final List<Color> gradientColors;
  final VoidCallback onTap;

  const FeatureCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.gradientColors,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        splashColor: Colors.white.withOpacity(0.2),
        highlightColor: Colors.white.withOpacity(0.1),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: gradientColors,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: gradientColors[0].withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: Colors.white, size: 32),
                ),
                const Spacer(),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
