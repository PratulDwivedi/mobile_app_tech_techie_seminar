import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../providers/event_service_provider.dart';
import '../models/program_session.dart';

class ProgramScreen extends ConsumerWidget {
  const ProgramScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(selectedTabProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF4CAF50),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Program',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Tab Bar
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF8BC34A),
                  Color(0xFF4CAF50),
                  Color(0xFF2E7D32),
                ],
              ),
            ),
            child: TabBar(
              selectedTab: selectedTab,
              onTabChanged: (index) {
                ref.read(selectedTabProvider.notifier).state = index;
              },
            ),
          ),
          // Content
          Expanded(
            child: IndexedStack(
              index: selectedTab,
              children: const [
                DateWiseView(),
                SessionWiseView(),
                SpeakerWiseView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== TAB BAR ====================

class TabBar extends StatelessWidget {
  final int selectedTab;
  final Function(int) onTabChanged;

  const TabBar({
    super.key,
    required this.selectedTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _TabItem(
              label: 'DATE',
              isSelected: selectedTab == 0,
              onTap: () => onTabChanged(0),
            ),
          ),
          Expanded(
            child: _TabItem(
              label: 'SESSION',
              isSelected: selectedTab == 1,
              onTap: () => onTabChanged(1),
            ),
          ),
          Expanded(
            child: _TabItem(
              label: 'SPEAKERS',
              isSelected: selectedTab == 2,
              onTap: () => onTabChanged(2),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabItem({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 3,
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== DATE WISE VIEW ====================

class DateWiseView extends ConsumerWidget {
  const DateWiseView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final programDates = ref.watch(programDateWiseProvider);
    final sessionsAsync = ref.watch(programSessionWiseProvider);

    return sessionsAsync.when(
      data: (_) {
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: 1,
          itemBuilder: (context, index) {
            return Container();
            // final programDate = programDates[index];
            // return DateCard(programDate: programDate);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text('Error: $error'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref.refresh(programSessionWiseProvider),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

class DateCard extends StatelessWidget {
  final ProgramDate programDate;

  const DateCard({super.key, required this.programDate});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50).withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_today, color: Color(0xFF4CAF50)),
                const SizedBox(width: 12),
                Text(
                  _formatDate(programDate.date),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                  ),
                ),
              ],
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: programDate.sessions.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final session = programDate.sessions[index];
              return SessionTile(session: session);
            },
          ),
        ],
      ),
    );
  }

  String _formatDate(String date) {
    try {
      final parsedDate = DateTime.parse(date);
      return parsedDate.toString();
      //return DateFormat('EEEE, d MMMM yyyy').format(parsedDate);
    } catch (e) {
      return date;
    }
  }
}

// ==================== SESSION TILE ====================

class SessionTile extends StatelessWidget {
  final ProgramSession session;

  const SessionTile({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _showSessionDetails(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Time
            Container(
              width: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    session.startTime,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF666666),
                    ),
                  ),
                  Text(
                    session.endTime,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF999999),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Session Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    session.sessionTitle,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF333333),
                    ),
                  ),
                  if (session.speakers.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    ...session.speakers.map(
                      (speaker) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.person,
                              size: 16,
                              color: Color(0xFF4CAF50),
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                speaker.name,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF4CAF50),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            // Calendar Icon
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFFFA726),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.calendar_month,
                color: Colors.white,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSessionDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SessionDetailsSheet(session: session),
    );
  }
}

// ==================== SESSION DETAILS SHEET ====================

class SessionDetailsSheet extends StatelessWidget {
  final ProgramSession session;

  const SessionDetailsSheet({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Column(
            children: [
              // Handle
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(24),
                  children: [
                    // Time
                    Row(
                      children: [
                        const Icon(Icons.access_time, color: Color(0xFF4CAF50)),
                        const SizedBox(width: 8),
                        Text(
                          '${session.startTime} - ${session.endTime}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF666666),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Title
                    Text(
                      session.sessionTitle,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    ),
                    if (session.sessionType != null) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4CAF50).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          session.sessionType!,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF4CAF50),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                    if (session.speakers.isNotEmpty) ...[
                      const SizedBox(height: 24),
                      const Text(
                        'Speakers',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF333333),
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...session.speakers.map(
                        (speaker) => SpeakerCard(speaker: speaker),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ==================== SPEAKER CARD ====================

class SpeakerCard extends StatelessWidget {
  final Speaker speaker;

  const SpeakerCard({super.key, required this.speaker});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: const Color(0xFF4CAF50),
              backgroundImage: speaker.profilePic != null
                  ? NetworkImage(speaker.profilePic!)
                  : null,
              child: speaker.profilePic == null
                  ? Text(
                      speaker.name[0].toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    speaker.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  if (speaker.designation != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      speaker.designation!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF666666),
                      ),
                    ),
                  ],
                  if (speaker.company != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      speaker.company!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF999999),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== SESSION WISE VIEW ====================

class SessionWiseView extends ConsumerWidget {
  const SessionWiseView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionsAsync = ref.watch(programSessionWiseProvider);

    return sessionsAsync.when(
      data: (sessions) {
        if (sessions.isEmpty) {
          return const Center(child: Text('No sessions available'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: 1,
          itemBuilder: (context, index) {
            return Container();
            // return Card(
            //   margin: const EdgeInsets.only(bottom: 16),
            //   child: SessionTile(session: sortedSessions[index]),
            // );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}

// ==================== SPEAKER WISE VIEW ====================

class SpeakerWiseView extends ConsumerWidget {
  const SpeakerWiseView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final speakersAsync = ref.watch(programSpeakerWiseProvider);

    return speakersAsync.when(
      data: (speakers) {
        if (speakers.isEmpty) {
          return const Center(child: Text('No speakers available'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: 1,
          itemBuilder: (context, index) {
            return Container();
            //return SpeakerListCard(speaker: speakers[index]);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}

class SpeakerListCard extends StatelessWidget {
  final Speaker speaker;

  const SpeakerListCard({super.key, required this.speaker});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          _showSpeakerDetails(context);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: const Color(0xFF4CAF50),
                backgroundImage: speaker.profilePic != null
                    ? NetworkImage(speaker.profilePic!)
                    : null,
                child: speaker.profilePic == null
                    ? Text(
                        speaker.name[0].toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      speaker.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    ),
                    if (speaker.designation != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        speaker.designation!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF666666),
                        ),
                      ),
                    ],
                    if (speaker.company != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        speaker.company!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF999999),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Color(0xFF999999)),
            ],
          ),
        ),
      ),
    );
  }

  void _showSpeakerDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(speaker.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (speaker.designation != null)
              Text('Designation: ${speaker.designation}'),
            if (speaker.company != null) Text('Company: ${speaker.company}'),
            if (speaker.biography != null) ...[
              const SizedBox(height: 12),
              Text(speaker.biography!),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
