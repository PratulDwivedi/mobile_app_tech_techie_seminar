import 'package:mobile_app_tech_techie_seminar/features/event/services/supabase_event_service.dart';
import '../../../config/app_config.dart';
import '../../common/models/response_message_model.dart';
import '../models/delegate_filter.dart';

abstract class EventService {
  static EventService get instance {
    if (appConfig.serviceType == ServiceType.supabase) {
      return SupabaseEventService();
    } else {
      return SupabaseEventService();
    }
  }

  Future<ResponseMessageModel> getProgramDateWise();
  Future<ResponseMessageModel> getProgramSessionWise();
  Future<ResponseMessageModel> getProgramSpeakerWise();
  //
  Future<ResponseMessageModel> getSpeakers();
  Future<ResponseMessageModel> getSponsors();
  Future<ResponseMessageModel> getDelegates(int pageNo);
  Future<ResponseMessageModel> getDelegatesWithFilter(
    int pageNo,
    DelegateFilter? filter,
  );

  Future<ResponseMessageModel> getBanners();
  Future<ResponseMessageModel> getExhibitors();

  Future<ResponseMessageModel> getSummaryCount();
  Future<ResponseMessageModel> getHtmlContent(int pageId);
}
