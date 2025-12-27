import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/action_tiles_section.dart';
import '../widgets/app_sidebar_drawer.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/feature_grid.dart';
import '../widgets/gradient_header.dart';
import '../widgets/info_cards_section.dart';
import '../widgets/live_update_section.dart';
import '../widgets/sponsors_banner_widget.dart';
import '../widgets/dg_message_card.dart';

class SeminarHomeScreen extends ConsumerWidget {
  const SeminarHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Color(0xFF4CAF50), // Dark background
      child: Scaffold(
        drawer: const AppSidebarDrawer(),
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              const GradientHeader(),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const DGMessageCard(),
                        const SizedBox(height: 20),
                        const SponsorsBannerWidget(),
                        const SizedBox(height: 20),
                        const FeatureGrid(),
                        const SizedBox(height: 20),
                        const ActionTilesSection(),
                        const SizedBox(height: 20),
                        const LiveUpdateSection(),
                        const SizedBox(height: 20),
                        const InfoCardsSection(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const BottomNavBar(),
      ),
    );
  }
}
