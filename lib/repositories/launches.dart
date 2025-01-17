// ignore_for_file: avoid_dynamic_calls

import 'package:cherry/models/index.dart';
import 'package:cherry/services/index.dart';
import 'package:flutter_request_bloc/flutter_request_bloc.dart';

/// Handles retrieve and transformation of [Launch] from the API, both past & future ones.
class LaunchesRepository
    extends BaseRepository<LaunchesService, List<List<Launch>>> {
  LaunchesRepository(LaunchesService service) : super(service);

  @override
  Future<List<List<Launch>>> fetchData() async {
    final response = await service.getLaunches();
    final launches = [
      for (final item in response.data['docs']) Launch.fromJson(item)
    ]..sort();

    return [
      launches.where((l) => l.upcoming).toList(),
      launches.where((l) => !l.upcoming).toList().reversed.toList()
    ];
  }
}
