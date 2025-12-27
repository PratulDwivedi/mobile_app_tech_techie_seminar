import '../../../config/app_constants.dart';
import '../../common/models/response_message_model.dart';
import '../../common/services/supabase_api_helper.dart';
import 'event_service.dart';

class SupabaseEventService implements EventService {
  @override
  Future<ResponseMessageModel> getProgramDateWise() async {
    final authResponse = await SupabaseApiHelper.post(ApiRoutes.signIn, null);
    return authResponse;
  }

  @override
  Future<ResponseMessageModel> getProgramSessionWise() async {
    final authResponse = await SupabaseApiHelper.post(ApiRoutes.signIn, null);
    return authResponse;
  }

  @override
  Future<ResponseMessageModel> getProgramSpeakerWise() async {
    final authResponse = await SupabaseApiHelper.post(ApiRoutes.signIn, null);
    return authResponse;
  }
}
