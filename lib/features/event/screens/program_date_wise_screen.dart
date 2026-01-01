import '../../common/models/screen_args_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/widgets/common_gradient_header_widget.dart';
import '../providers/event_service_provider.dart';
import '../models/program_schedule.dart';

class ProgramDateWiseScreen extends ConsumerStatefulWidget {
  final ScreenArgsModel args;
  final bool showHeader;

  const ProgramDateWiseScreen({
    required this.args,
    this.showHeader = true,
    super.key,
  });

  @override
  ConsumerState<ProgramDateWiseScreen> createState() =>
      _ProgramDateWiseScreenState();
}

class _ProgramDateWiseScreenState extends ConsumerState<ProgramDateWiseScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final programsAsync = ref.watch(programDateWiseProvider);
    return Scaffold(
      body: Column(
        children: [
          // Gradient Header
          if (widget.showHeader)
            CommonGradientHeader(
              title: widget.args.name,
              onRefresh: () {
                ref.invalidate(programDateWiseProvider);
              },
            ),

          // Programs Content
          Expanded(
            child: programsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text('Error: $err')),
              data: (response) {
                if (!response.isSuccess) {
                  return Center(child: Text(response.message));
                }

                final programsData = (response.data as List?)
                    ?.map((item) => ProgramDateWise.fromJson(item))
                    .toList() ?? [];

                if (programsData.isEmpty) {
                  return const Center(child: Text('No Schedule available'));
                }

                return ListView.builder(
                  itemCount: programsData.length,
                  itemBuilder: (context, index) {
                    final programDate = programsData[index];
                    return _buildDateSection(programDate);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSection(ProgramDateWise programDate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Date Header
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          color: Theme.of(context).primaryColor.withAlpha(25),
          child: Text(
            programDate.date,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        // Schedules for this date
        ...programDate.schedules.map((schedule) => _buildScheduleItem(schedule)),
      ],
    );
  }

  Widget _buildScheduleItem(ProgramSchedule schedule) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Time and Title
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Time
                SizedBox(
                  width: 100,
                  child: Text(
                    schedule.programTime,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Title
                Expanded(
                  child: Text(
                    schedule.programTitle,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            // Speakers
            if (schedule.speakers != null && schedule.speakers!.isNotEmpty) ...[
              const SizedBox(height: 8),
              ...schedule.speakers!.map((speaker) => Padding(
                padding: const EdgeInsets.only(left: 112),
                child: Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 16,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        speaker.speakerName,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              )),
            ],
            // Description if available
            if (schedule.programDescr != null && schedule.programDescr!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 112),
                child: Text(
                  schedule.programDescr!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
