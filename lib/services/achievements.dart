import 'package:cherry/utils/index.dart';
import 'package:dio/dio.dart';
import 'package:flutter_request_bloc/flutter_request_bloc.dart';

/// Services that retrieves a list featuring the latest SpaceX acomplishments.
class AchievementsService extends BaseService<Dio> {
  const AchievementsService(Dio client) : super(client);

  Future<Response> getAchievements() async {
    return client.get(Url.companyAchievements);
  }
}
