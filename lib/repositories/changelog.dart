import 'package:cherry/services/index.dart';
import 'package:flutter_request_bloc/flutter_request_bloc.dart';

/// Handles retrieve and transformation of the changelog of the app.
class ChangelogRepository extends BaseRepository<ChangelogService, String> {
  const ChangelogRepository(ChangelogService service) : super(service);

  @override
  Future<String> fetchData() async {
    final response = await service.getChangelog();

    return response.data;
  }
}
