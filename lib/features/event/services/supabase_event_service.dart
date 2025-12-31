import 'package:shared_preferences/shared_preferences.dart';
import '../../../config/app_constants.dart';
import '../../common/models/response_message_model.dart';
import '../../common/services/supabase_api_helper.dart';
import 'event_service.dart';

class SupabaseEventService implements EventService {
  @override
  Future<ResponseMessageModel> getProgramDateWise() async {
    final response = await SupabaseApiHelper.post(ApiRoutes.signIn, null);
    return response;
  }

  @override
  Future<ResponseMessageModel> getProgramSessionWise() async {
    final response = await SupabaseApiHelper.post(ApiRoutes.signIn, null);
    return response;
  }

  @override
  Future<ResponseMessageModel> getProgramSpeakerWise() async {
    final response = await SupabaseApiHelper.post(ApiRoutes.signIn, null);
    return response;
  }

  @override
  Future<ResponseMessageModel> getHtmlContent(int pageId) async {
    print("getHtmlContent called for pageId: $pageId");
    final response = await SupabaseApiHelper.post(ApiRoutes.htmlContent, {
      "p_page_id": pageId,
    });
    print("getHtmlContent response: ${response.toJson()}");
    return response;
  }

  @override
  Future<ResponseMessageModel> getSummaryCount() async {
    final response = await SupabaseApiHelper.post(ApiRoutes.summaryCount, null);
    return response;
  }
}
