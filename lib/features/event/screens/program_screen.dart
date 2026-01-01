import '../../common/models/screen_args_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/widgets/common_gradient_header_widget.dart';
import '../providers/event_service_provider.dart';
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
                _buildDateWiseTab(),

                // Session Wise Tab
                _buildSessionWiseTab(),

                // Speaker Wise Tab (using SpeakersScreen)
                _buildSpeakerWiseTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateWiseTab() {
    final dateWiseAsync = ref.watch(programDateWiseProvider);

    return dateWiseAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text('Error: $err')),
      data: (response) {
        if (!response.isSuccess) {
          return Center(child: Text(response.message));
        }

        final _data = response.data;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Program by Date',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF333333),
                      ),
                ),
                const SizedBox(height: 16.0),
                // TODO: Implement date-wise program display
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Text('Date-wise program content will be displayed here'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSessionWiseTab() {
    final sessionWiseAsync = ref.watch(programSessionWiseProvider);

    return sessionWiseAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text('Error: $err')),
      data: (response) {
        if (!response.isSuccess) {
          return Center(child: Text(response.message));
        }

        final _data = response.data;
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Program by Session',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF333333),
                      ),
                ),
                const SizedBox(height: 16.0),
                // TODO: Implement session-wise program display
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Text('Session-wise program content will be displayed here'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSpeakerWiseTab() {
    // Use the existing SpeakersScreen as a reusable component without header
    return SpeakersScreen(
      args: ScreenArgsModel(
        routeName: 'speakers',
        name: 'Speakers',
        data: {},
      ),
      showHeader: false,
    );
  }
}
