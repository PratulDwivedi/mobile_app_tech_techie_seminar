class DelegateFilter {
  final int orderBy; // 1 = ASC, 2 = DESC
  final String searchKey;
  final String companies;
  final String alphaKey;
  final int delegateId;

  const DelegateFilter({
    this.orderBy = 1,
    this.searchKey = '',
    this.companies = '',
    this.alphaKey = '',
    this.delegateId = 0,
  });

  DelegateFilter copyWith({
    int? orderBy,
    String? searchKey,
    String? companies,
    String? alphaKey,
    int? delegateId,
  }) {
    return DelegateFilter(
      orderBy: orderBy ?? this.orderBy,
      searchKey: searchKey ?? this.searchKey,
      companies: companies ?? this.companies,
      alphaKey: alphaKey ?? this.alphaKey,
      delegateId: delegateId ?? this.delegateId,
    );
  }

  bool get hasFilters =>
      searchKey.isNotEmpty ||
      companies.isNotEmpty ||
      alphaKey.isNotEmpty ||
      delegateId != 0;
}