import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/app_config.dart';
import '../models/banner.dart';
import '../providers/event_service_provider.dart';

class SponsorsBannerWidget extends ConsumerStatefulWidget {
  const SponsorsBannerWidget({super.key});

  @override
  ConsumerState<SponsorsBannerWidget> createState() => _SponsorsBannerWidgetState();
}

class _SponsorsBannerWidgetState extends ConsumerState<SponsorsBannerWidget> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;
  int _bannerCount = 0;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients && _bannerCount > 0) {
        final nextPage = (_currentPage + 1) % _bannerCount;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bannersAsync = ref.watch(bannersProvider);

    return SizedBox(
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1E3A8A), // Deep Indigo Blue
              Color(0xFF0EA5A4), // Teal
            ],
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: bannersAsync.when(
                data: (response) {
                  if (response.isSuccess) {
                    final banners = response.data
                        .map((json) => BannerModel.fromJson(json))
                        .toList();
                    if (banners.isEmpty) {
                      return const Center(
                        child: Text('No banners available'),
                      );
                    }
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      setState(() {
                        _bannerCount = banners.length;
                      });
                    });
                    return Column(
                      children: [
                        SizedBox(
                          height: 120,
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: banners.length,
                            onPageChanged: (index) {
                              setState(() {
                                _currentPage = index;
                              });
                            },
                            itemBuilder: (context, index) {
                              final banner = banners[index];
                              return Center(
                                child: banner.bannerImage.isNotEmpty
                                    ? Image.network(
                                        '${appConfig.storageUrl}/${banner.bannerImage}',
                                        height: 100,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) =>
                                            const Icon(Icons.image_not_supported),
                                      )
                                    : const Icon(Icons.image_not_supported),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            banners.length,
                            (index) => Container(
                              margin: const EdgeInsets.symmetric(horizontal: 2),
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentPage == index
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.5),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: Text(response.message),
                    );
                  }
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, stack) => Center(
                  child: Text('Error: $error'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
