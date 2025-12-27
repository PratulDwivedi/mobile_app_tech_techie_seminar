class ResponseMessageModel {
  final bool isSuccess;
  final int statusCode;
  final String message;
  final List<Map<String, dynamic>> data;
  final Paging? paging;

  ResponseMessageModel({
    required this.isSuccess,
    required this.statusCode,
    required this.message,
    required this.data,
    this.paging,
  });

  factory ResponseMessageModel.fromJson(Map<String, dynamic> json) {
    return ResponseMessageModel(
      isSuccess: json['is_success'] ?? false,
      statusCode: json['status_code'] ?? 0,
      message: json['message'] ?? '',
      data:
          (json['data'] as List<dynamic>?)
              ?.map((item) => Map<String, dynamic>.from(item as Map))
              .toList() ??
          [],
      paging: json['paging'] != null
          ? Paging.fromJson(json['paging'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'is_success': isSuccess,
      'status_code': statusCode,
      'message': message,
      'data': data,
      'paging': paging?.toJson(),
    };
  }

  // Helper methods for accessing data
  Map<String, dynamic>? get firstOrNull => data.isNotEmpty ? data.first : null;
  bool get hasData => data.isNotEmpty;
  bool get isEmpty => data.isEmpty;
  int get dataCount => data.length;

  // Get value from first data item
  T? getFromFirst<T>(String key) {
    if (data.isEmpty) return null;
    return data.first[key] as T?;
  }

  // Get value with default
  T getFromFirstOrDefault<T>(String key, T defaultValue) {
    if (data.isEmpty) return defaultValue;
    return data.first[key] as T? ?? defaultValue;
  }
}

// ==================== PAGING MODEL ====================

class Paging {
  final int pageSize;
  final int pageIndex;
  final int totalRecords;

  Paging({
    required this.pageSize,
    required this.pageIndex,
    required this.totalRecords,
  });

  factory Paging.fromJson(Map<String, dynamic> json) {
    return Paging(
      pageSize: json['page_size'] ?? 0,
      pageIndex: json['page_index'] ?? 0,
      totalRecords: json['total_records'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page_size': pageSize,
      'page_index': pageIndex,
      'total_records': totalRecords,
    };
  }

  // Computed properties
  int get totalPages => pageSize > 0 ? (totalRecords / pageSize).ceil() : 0;
  bool get hasNextPage => pageIndex < totalPages;
  bool get hasPreviousPage => pageIndex > 1;
  int get startRecord => pageSize > 0 ? ((pageIndex - 1) * pageSize) + 1 : 0;
  int get endRecord => (pageIndex * pageSize).clamp(0, totalRecords);
}
