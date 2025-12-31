import 'delegate_filter.dart';

class DelegatesProviderParams {
  final int pageNo;
  final DelegateFilter filter;

  const DelegatesProviderParams({required this.pageNo, required this.filter});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DelegatesProviderParams &&
        other.pageNo == pageNo &&
        other.filter.orderBy == filter.orderBy &&
        other.filter.searchKey == filter.searchKey &&
        other.filter.companies == filter.companies &&
        other.filter.alphaKey == filter.alphaKey &&
        other.filter.delegateId == filter.delegateId;
  }

  @override
  int get hashCode {
    return pageNo.hashCode ^
        filter.orderBy.hashCode ^
        filter.searchKey.hashCode ^
        filter.companies.hashCode ^
        filter.alphaKey.hashCode ^
        filter.delegateId.hashCode;
  }
}
