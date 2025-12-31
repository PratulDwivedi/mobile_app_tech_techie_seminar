import '../../common/models/screen_args_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/widgets/common_gradient_header_widget.dart';
import '../providers/event_service_provider.dart';
import 'delegate_info_screen.dart';

class DelegatesScreen extends ConsumerStatefulWidget {
  final ScreenArgsModel args;

  const DelegatesScreen({required this.args, super.key});

  @override
  ConsumerState<DelegatesScreen> createState() => _DelegatesScreenState();
}

class _DelegatesScreenState extends ConsumerState<DelegatesScreen> {
  int currentPage = 1;
  List<Map<String, dynamic>> allDelegates = [];
  bool isLoadingMore = false;
  bool hasMoreData = true;
  int totalRecords = 0;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    setState(() {
      currentPage = 1;
      allDelegates = [];
      hasMoreData = true;
    });
  }

  Future<void> _loadMoreDelegates() async {
    if (isLoadingMore || !hasMoreData) return;

    setState(() {
      isLoadingMore = true;
    });

    try {
      final nextPage = currentPage + 1;
      final response = await ref.read(delegatesProvider(nextPage).future);

      if (response.isSuccess) {
        final newDelegates = (response.data as List?)?.cast<Map<String, dynamic>>() ?? [];
        final paging = response.paging;
        final newTotalRecords = paging?.totalRecords ?? 0;

        setState(() {
          allDelegates.addAll(newDelegates);
          currentPage = nextPage;
          totalRecords = newTotalRecords;
          hasMoreData = newDelegates.length >= 10; // Assuming page size is 10
          isLoadingMore = false;
        });
      } else {
        setState(() {
          isLoadingMore = false;
          hasMoreData = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoadingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final delegatesAsync = ref.watch(delegatesProvider(currentPage));

    return Scaffold(
      body: Column(
        children: [
          // Gradient Header
          CommonGradientHeader(
            title: widget.args.name,
            onRefresh: () {
              _loadInitialData();
              ref.invalidate(delegatesProvider(currentPage));
            },
          ),

          // Delegates Content
          Expanded(
            child: delegatesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text('Error: $err')),
              data: (response) {
                if (!response.isSuccess) {
                  return Center(child: Text(response.message));
                }

                final currentPageDelegates = (response.data as List?)?.cast<Map<String, dynamic>>() ?? [];
                final paging = response.paging;
                totalRecords = paging?.totalRecords ?? 0;

                // Add current page delegates to all delegates if this is the first page
                if (currentPage == 1) {
                  allDelegates = List.from(currentPageDelegates);
                }

                if (allDelegates.isEmpty) {
                  return const Center(child: Text('No delegates available'));
                }

                return Column(
                  children: [
                    // Delegates List
                    Expanded(
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (ScrollNotification scrollInfo) {
                          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                            _loadMoreDelegates();
                          }
                          return true;
                        },
                        child: ListView.builder(
                          padding: const EdgeInsets.all(16.0),
                          itemCount: allDelegates.length + (isLoadingMore ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == allDelegates.length) {
                              return const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }

                            final delegate = allDelegates[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DelegateInfoScreen(delegate: delegate),
                                  ),
                                );
                              },
                              child: DelegateCard(delegate: delegate),
                            );
                          },
                        ),
                      ),
                    ),

                    // Bottom Chip
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFF2E7D32).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: const Color(0xFF2E7D32)),
                            ),
                            child: Text(
                              'Delegates: ${allDelegates.length} / $totalRecords',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF2E7D32),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DelegateCard extends StatelessWidget {
  final Map<String, dynamic> delegate;

  const DelegateCard({super.key, required this.delegate});

  @override
  Widget build(BuildContext context) {
    final delegateName = delegate['delegate_name']?.toString() ?? 'Unknown Delegate';
    final designation = delegate['designation']?.toString() ?? '';
    final companyName = delegate['company_name']?.toString() ?? '';
    final profilePic = delegate['profile_pic']?.toString();
    final isUsingApp = delegate['is_using_app']?.toString() ?? '';
    final openForAppointment = delegate['open_for_appointment'] as bool? ?? false;

    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Delegate Header with Photo and Basic Info
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Picture
                CircleAvatar(
                  radius: 40,
                  backgroundImage: profilePic != null && profilePic != 'delegate.png'
                      ? NetworkImage('https://your-api-base-url/$profilePic')
                      : null,
                  child: profilePic == null || profilePic == 'delegate.png'
                      ? const Icon(Icons.person, size: 40)
                      : null,
                ),
                const SizedBox(width: 16),
                // Delegate Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        delegateName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                      if (designation.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          designation,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF666666),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                      if (companyName.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          companyName,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF888888),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),

            // Status Indicators
            if (openForAppointment || isUsingApp.isNotEmpty) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  if (openForAppointment) ...[
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4CAF50).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFF4CAF50)),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.calendar_today, size: 12, color: Color(0xFF4CAF50)),
                          SizedBox(width: 4),
                          Text(
                            'Available for Appointment',
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFF4CAF50),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  if (isUsingApp.isNotEmpty && !isUsingApp.contains('not using')) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2196F3).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFF2196F3)),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.phone_android, size: 12, color: Color(0xFF2196F3)),
                          SizedBox(width: 4),
                          Text(
                            'Using App',
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFF2196F3),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
