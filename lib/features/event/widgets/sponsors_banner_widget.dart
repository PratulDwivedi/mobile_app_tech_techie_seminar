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

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
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
                            return Column(
                              children: [
                                SizedBox(
                                  height: 200, // Adjust height as needed
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
                                      return Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          if (banner.bannerImage.isNotEmpty)
                                            Image.network(
                                              '${appConfig.storageUrl}/${banner.bannerImage}',
                                              height: 100,
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error, stackTrace) =>
                                                  const Icon(Icons.image_not_supported),
                                            ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    banners.length,
                                    (index) => Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 4),
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _currentPage == index
                                            ? const Color(0xFF1E3A8A)
                                            : Colors.grey.shade300,
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
