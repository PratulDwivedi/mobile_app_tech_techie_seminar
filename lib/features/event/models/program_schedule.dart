class ProgramSchedule {
  final int eventScheduleId;
  final int eventInfoId;
  final String programTitle;
  final String? programDescr;
  final String programTime;
  final String? programFromTime;
  final String? programToTime;
  final String? programWebUrl;
  final int showInOrder;
  final int showReminderButton;
  final int? eventScheduleThemeId;
  final String? eventScheduleAddress;
  final String? smallIcon;
  final List<ProgramSpeaker>? speakers;
  final List<dynamic>? sponsors;

  ProgramSchedule({
    required this.eventScheduleId,
    required this.eventInfoId,
    required this.programTitle,
    this.programDescr,
    required this.programTime,
    this.programFromTime,
    this.programToTime,
    this.programWebUrl,
    required this.showInOrder,
    required this.showReminderButton,
    this.eventScheduleThemeId,
    this.eventScheduleAddress,
    this.smallIcon,
    this.speakers,
    this.sponsors,
  });

  factory ProgramSchedule.fromJson(Map<String, dynamic> json) {
    return ProgramSchedule(
      eventScheduleId: json['event_schedule_id'] ?? 0,
      eventInfoId: json['event_info_id'] ?? 0,
      programTitle: json['program_title'] ?? '',
      programDescr: json['program_descr'],
      programTime: json['program_time'] ?? '',
      programFromTime: json['program_from_time'],
      programToTime: json['program_to_time'],
      programWebUrl: json['program_web_url'],
      showInOrder: json['show_in_order'] ?? 0,
      showReminderButton: json['show_reminder_button'] ?? 0,
      eventScheduleThemeId: json['event_schedule_theme_id'],
      eventScheduleAddress: json['event_schedule_address'],
      smallIcon: json['small_icon'],
      speakers: (json['speakers'] as List?)
          ?.map((s) => ProgramSpeaker.fromJson(s))
          .toList(),
      sponsors: json['sponsors'] as List?,
    );
  }
}

class ProgramSpeaker {
  final int speakerId;
  final String speakerName;
  final String? speakerIcon;

  ProgramSpeaker({
    required this.speakerId,
    required this.speakerName,
    this.speakerIcon,
  });

  factory ProgramSpeaker.fromJson(Map<String, dynamic> json) {
    return ProgramSpeaker(
      speakerId: json['speaker_id'] ?? 0,
      speakerName: json['speaker_name'] ?? '',
      speakerIcon: json['speaker_icon'],
    );
  }
}

class ProgramDateWise {
  final String date;
  final String programDate;
  final List<ProgramSchedule> schedules;

  ProgramDateWise({
    required this.date,
    required this.programDate,
    required this.schedules,
  });

  factory ProgramDateWise.fromJson(Map<String, dynamic> json) {
    return ProgramDateWise(
      date: json['date'] ?? '',
      programDate: json['program_date'] ?? '',
      schedules: (json['schedules'] as List?)
          ?.map((s) => ProgramSchedule.fromJson(s))
          .toList() ?? [],
    );
  }
}

class ProgramSessionWise {
  final int sessionId;
  final String sessionName;
  final String sessionTitle;
  final String sessionDate;
  final String? themeImage;
  final List<ProgramSchedule> schedules;

  ProgramSessionWise({
    required this.sessionId,
    required this.sessionName,
    required this.sessionTitle,
    required this.sessionDate,
    this.themeImage,
    required this.schedules,
  });

  factory ProgramSessionWise.fromJson(Map<String, dynamic> json) {
    return ProgramSessionWise(
      sessionId: json['session_id'] ?? 0,
      sessionName: json['session_name'] ?? '',
      sessionTitle: json['session_title'] ?? '',
      sessionDate: json['session_date'] ?? '',
      themeImage: json['theme_image'],
      schedules: (json['schedules'] as List?)
          ?.map((s) => ProgramSchedule.fromJson(s))
          .toList() ?? [],
    );
  }
}