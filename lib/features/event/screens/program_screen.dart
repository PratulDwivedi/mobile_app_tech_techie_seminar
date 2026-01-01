import '../../common/models/screen_args_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/widgets/common_gradient_header_widget.dart';
import '../providers/event_service_provider.dart';
import 'program_date_wise_screen.dart';
import 'program_session_wise_screen.dart';
import 'speakers_screen.dart';

class ProgramScreen extends ConsumerStatefulWidget {
  final ScreenArgsModel args;

  const ProgramScreen({required this.args, super.key});

  @override
  ConsumerState<ProgramScreen> createState() => _ProgramScreenState();
}

class _ProgramScreenState extends ConsumerState<ProgramScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Gradient Header
          CommonGradientHeader(
            title: widget.args.name,
            onRefresh: () {
              // Refresh all program providers
              ref.invalidate(programDateWiseProvider);
              ref.invalidate(programSessionWiseProvider);
              ref.invalidate(programSpeakerWiseProvider);
              ref.invalidate(speakersProvider);
            },
          ),

          // Tab Bar
          Container(
            color: const Color(0xFF4CAF50),
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white.withAlpha(179),
              tabs: const [
                Tab(text: 'Date Wise'),
                Tab(text: 'Session Wise'),
                Tab(text: 'Speaker Wise'),
              ],
            ),
          ),

          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Date Wise Tab
                ProgramDateWiseScreen(
                  args: ScreenArgsModel(
                    routeName: 'program-date-wise',
                    name: 'Date Wise',
                    data: {},
                  ),
                  showHeader: false,
                ),

                ProgramSessionWiseScreen(
                  args: ScreenArgsModel(
                    routeName: 'program-session-wise',
                    name: 'Session Wise',
                    data: {},
                  ),
                  showHeader: false,
                ),

                // Speaker Wise Tab (using SpeakersScreen)
                SpeakersScreen(
                  args: ScreenArgsModel(
                    routeName: 'speakers',
                    name: 'Speakers',
                    data: {},
                  ),
                  showHeader: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
