import 'package:cherry/utils/index.dart';
import 'package:dio/dio.dart';
import 'package:flutter_request_bloc/flutter_request_bloc.dart';

/// Services that retrieves information about the app's changelog.
class ChangelogService extends BaseService<Dio> {
  const ChangelogService(Dio client) : super(client);

  Future<Response> getChangelog() async {
    return client.get(Url.changelog);
  }
}
