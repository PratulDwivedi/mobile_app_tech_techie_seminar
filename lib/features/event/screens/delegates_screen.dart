import '../../common/models/screen_args_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/widgets/common_gradient_header_widget.dart';
import '../models/delegate_filter.dart';
import '../models/delegates_provider_params.dart';
import '../providers/event_service_provider.dart';
import '../widgets/delegate_card_widget.dart';
import '../widgets/delegate_filter_dialog.dart';
import 'delegate_info_screen.dart';

class DelegatesScreen extends ConsumerStatefulWidget {
  final ScreenArgsModel args;

  const DelegatesScreen({required this.args, super.key});

  @override
  ConsumerState<DelegatesScreen> createState() => _DelegatesScreenState();
}

class _DelegatesScreenState extends ConsumerState<DelegatesScreen> {
  int currentPage = 0; // Start with 0-based indexing to match API
  List<Map<String, dynamic>> allDelegates = [];
  bool isLoadingMore = false;
  bool hasMoreData = true;
  int totalRecords = 0;
  DelegateFilter currentFilter = const DelegateFilter();
  bool _hasInitialized = false; // Add initialization flag

  @override
  void initState() {
    super.initState();
    // Don't call _loadInitialData() here - ref is not available yet
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize only once when dependencies are ready
    if (!_hasInitialized) {
      _hasInitialized = true;
      // Provider will automatically load on first build, so we don't need to do anything here
      // If you want to trigger a load, uncomment the line below:
      // Future.microtask(() => _loadInitialData());
    }
  }

  Future<void> _loadInitialData() async {
    setState(() {
      currentPage = 0;
      allDelegates = [];
      hasMoreData = true;
    });
    // Invalidate the provider to trigger a reload
    ref.invalidate(
      delegatesProvider(
        DelegatesProviderParams(pageNo: currentPage, filter: currentFilter),
      ),
    );
  }

  Future<void> _applyFilter(DelegateFilter filter) async {
    setState(() {
      currentFilter = filter;
      currentPage = 0;
      allDelegates = [];
      hasMoreData = true;
    });
    // Invalidate the provider to trigger a reload with new filters
    ref.invalidate(
      delegatesProvider(
        DelegatesProviderParams(pageNo: currentPage, filter: currentFilter),
      ),
    );
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DelegateFilterDialog(
        currentFilter: currentFilter,
        onApplyFilter: _applyFilter,
      ),
    );
  }

  Future<void> _loadMoreDelegates() async {
    if (isLoadingMore || !hasMoreData) return;

    setState(() {
      isLoadingMore = true;
    });

    try {
      final nextPage = currentPage + 1;
      final response = await ref.read(
        delegatesProvider(
          DelegatesProviderParams(pageNo: nextPage, filter: currentFilter),
        ).future,
      );

      if (response.isSuccess) {
        final newDelegates =
            (response.data as List?)?.cast<Map<String, dynamic>>() ?? [];
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
    final delegatesAsync = ref.watch(
      delegatesProvider(
        DelegatesProviderParams(pageNo: currentPage, filter: currentFilter),
      ),
    );

    return Scaffold(
      body: Column(
        children: [
          // Gradient Header
          CommonGradientHeader(
            title: widget.args.name,
            onRefresh: () {
              _loadInitialData();
            },
            actionButton: IconButton(
              onPressed: _showFilterDialog,
              icon: Icon(
                Icons.filter_list,
                color: currentFilter.hasFilters ? Colors.yellow : Colors.white,
              ),
              style: IconButton.styleFrom(
                backgroundColor: Colors.white.withAlpha(51),
              ),
            ),
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

                final currentPageDelegates =
                    (response.data as List?)?.cast<Map<String, dynamic>>() ??
                        [];
                final paging = response.paging;
                totalRecords = paging?.totalRecords ?? 0;

                // Add current page delegates to all delegates if this is the first page
                if (currentPage == 0) {
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
                          if (scrollInfo.metrics.pixels ==
                              scrollInfo.metrics.maxScrollExtent) {
                            _loadMoreDelegates();
                          }
                          return true;
                        },
                        child: ListView.builder(
                          padding: const EdgeInsets.all(16.0),
                          itemCount:
                              allDelegates.length + (isLoadingMore ? 1 : 0),
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF2E7D32).withAlpha(25),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(0xFF2E7D32),
                              ),
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