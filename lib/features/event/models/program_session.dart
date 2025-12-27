class ProgramSession {
  final int id;
  final String date;
  final String startTime;
  final String endTime;
  final String sessionTitle;
  final String? sessionType;
  final List<Speaker> speakers;
  final int? sortOrder;

  ProgramSession({
    required this.id,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.sessionTitle,
    this.sessionType,
    required this.speakers,
    this.sortOrder,
  });

  factory ProgramSession.fromJson(Map<String, dynamic> json) {
    return ProgramSession(
      id: json['id'] ?? 0,
      date: json['date'] ?? '',
      startTime: json['start_time'] ?? '',
      endTime: json['end_time'] ?? '',
      sessionTitle: json['session_title'] ?? '',
      sessionType: json['session_type'],
      speakers: (json['speakers'] as List?)
              ?.map((s) => Speaker.fromJson(s))
              .toList() ??
          [],
      sortOrder: json['sort_order'],
    );
  }
}

class Speaker {
  final int id;
  final String name;
  final String? designation;
  final String? company;
  final String? profilePic;
  final String? biography;

  Speaker({
    required this.id,
    required this.name,
    this.designation,
    this.company,
    this.profilePic,
    this.biography,
  });

  factory Speaker.fromJson(Map<String, dynamic> json) {
    return Speaker(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      designation: json['designation'],
      company: json['company'],
      profilePic: json['profile_pic'],
      biography: json['biography'],
    );
  }
}

class ProgramDate {
  final String date;
  final List<ProgramSession> sessions;

  ProgramDate({required this.date, required this.sessions});
}