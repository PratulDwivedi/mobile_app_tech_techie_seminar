class Exhibitor {
  final int exhibitorId;
  final String exhibitorName;
  final String shortName;
  final String? exhibitorDescr;
  final String? contactPerson;
  final String? contactPersonNo;
  final String? emailId;
  final String? exhibitorAddress;
  final int? exhibitorCity;
  final String? exhibitorWebUrl;
  final String? filePath;
  final int showInOrder;
  final String? geoLat;
  final String? geoLong;
  final String? exhibitorFromDate;
  final String? exhibitorToDate;

  Exhibitor({
    required this.exhibitorId,
    required this.exhibitorName,
    required this.shortName,
    this.exhibitorDescr,
    this.contactPerson,
    this.contactPersonNo,
    this.emailId,
    this.exhibitorAddress,
    this.exhibitorCity,
    this.exhibitorWebUrl,
    this.filePath,
    required this.showInOrder,
    this.geoLat,
    this.geoLong,
    this.exhibitorFromDate,
    this.exhibitorToDate,
  });

  factory Exhibitor.fromJson(Map<String, dynamic> json) {
    return Exhibitor(
      exhibitorId: json['exhibitor_id'] ?? 0,
      exhibitorName: json['exhibitor_name'] ?? '',
      shortName: json['short_name'] ?? '',
      exhibitorDescr: json['exhibitor_descr'],
      contactPerson: json['contact_person'],
      contactPersonNo: json['contact_person_no'],
      emailId: json['email_id'],
      exhibitorAddress: json['exhibitor_address'],
      exhibitorCity: json['exhibitor_city'],
      exhibitorWebUrl: json['exhibitor_web_url'],
      filePath: json['file_path'],
      showInOrder: json['show_in_order'] ?? 0,
      geoLat: json['geo_lat'],
      geoLong: json['geo_long'],
      exhibitorFromDate: json['exhibitor_from_date'],
      exhibitorToDate: json['exhibitor_to_date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exhibitor_id': exhibitorId,
      'exhibitor_name': exhibitorName,
      'short_name': shortName,
      'exhibitor_descr': exhibitorDescr,
      'contact_person': contactPerson,
      'contact_person_no': contactPersonNo,
      'email_id': emailId,
      'exhibitor_address': exhibitorAddress,
      'exhibitor_city': exhibitorCity,
      'exhibitor_web_url': exhibitorWebUrl,
      'file_path': filePath,
      'show_in_order': showInOrder,
      'geo_lat': geoLat,
      'geo_long': geoLong,
      'exhibitor_from_date': exhibitorFromDate,
      'exhibitor_to_date': exhibitorToDate,
    };
  }
}