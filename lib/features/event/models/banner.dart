class BannerModel {
  final String bannerDescr;
  final String bannerImage;
  final String bannerTitle;
  final String bannerRedirectUrl;

  BannerModel({
    required this.bannerDescr,
    required this.bannerImage,
    required this.bannerTitle,
    required this.bannerRedirectUrl,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      bannerDescr: json['banner_descr'] ?? '',
      bannerImage: json['banner_image'] ?? '',
      bannerTitle: json['banner_title'] ?? '',
      bannerRedirectUrl: json['banner_redirect_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'banner_descr': bannerDescr,
      'banner_image': bannerImage,
      'banner_title': bannerTitle,
      'banner_redirect_url': bannerRedirectUrl,
    };
  }
}