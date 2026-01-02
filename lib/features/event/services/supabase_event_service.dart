import '../../../config/app_constants.dart';
import '../../common/models/response_message_model.dart';
import '../../common/services/supabase_api_helper.dart';
import '../models/delegate_filter.dart';
import 'event_service.dart';

class SupabaseEventService implements EventService {
  @override
  Future<ResponseMessageModel> getProgramDateWise() async {
    final response = await SupabaseApiHelper.post(ApiRoutes.program, {"p_type" : "Dates"});
    return response;
  }

  @override
  Future<ResponseMessageModel> getProgramSessionWise() async {
    final response = await SupabaseApiHelper.post(ApiRoutes.program,  {"p_type" : "Sessions"});
    return response;
  }

  @override
  Future<ResponseMessageModel> getProgramSpeakerWise() async {
    final response = await SupabaseApiHelper.post(ApiRoutes.program, {"p_type" : "Speakers"});
    return response;
  }

  @override
  Future<ResponseMessageModel> getHtmlContent(int pageId) async {
    final response = await SupabaseApiHelper.post(ApiRoutes.htmlContent, {
      "p_page_id": pageId,
    });

    return response;
  }

  @override
  Future<ResponseMessageModel> getSummaryCount() async {
    final response = await SupabaseApiHelper.post(ApiRoutes.summaryCount, null);
    return response;
  }

  @override
  Future<ResponseMessageModel> getSpeakers() async {
    final response = await SupabaseApiHelper.post(ApiRoutes.speakers, null);
    return response;
  }

  @override
  Future<ResponseMessageModel> getSponsors() async {
    final response = await SupabaseApiHelper.post(ApiRoutes.sponsors, null);
    return response;
  }

  @override
  Future<ResponseMessageModel> getExhibitors() async {
    final response = await SupabaseApiHelper.post(ApiRoutes.exhibitors, null);
    return response;
  }

  @override
  Future<ResponseMessageModel> getDelegates(int pageNo) async {
    final response = await SupabaseApiHelper.post(ApiRoutes.delegates, {
      "p_page_no": pageNo,
    });
    return response;
  }


  @override
  Future<ResponseMessageModel> getBanners() async {
    final response = await SupabaseApiHelper.post(ApiRoutes.banners, null);
    return response;
  }


  @override
  Future<ResponseMessageModel> getDelegatesWithFilter(
    int pageNo,
    DelegateFilter? filter,
  ) async {
    final requestBody = {
      "p_page_no": pageNo,
      "p_order_by": filter?.orderBy ?? 1,
      "p_key": filter?.searchKey ?? '',
      "p_companies": filter?.companies ?? '',
      "p_alpha_key": filter?.alphaKey ?? '',
      "p_delegate_id": filter?.delegateId ?? 0,
    };
    final response = await SupabaseApiHelper.post(
      ApiRoutes.delegates,
      requestBody,
    );
    return response;
  }
}
