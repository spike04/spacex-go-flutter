import 'package:cherry/models/index.dart';
import 'package:cherry/repositories/index.dart';
import 'package:cherry/utils/index.dart';
import 'package:flutter_request_bloc/flutter_request_bloc.dart';

/// Cubit that holds a list of launches.
class LaunchesCubit
    extends RequestCubit<LaunchesRepository, List<List<Launch>>> {
  LaunchesCubit(LaunchesRepository repository) : super(repository);

  @override
  Future<void> loadData() async {
    emit(RequestState.loading(state.value));

    try {
      final data = await repository.fetchData();

      emit(RequestState.loaded(data));
    } catch (e) {
      emit(RequestState.error(e.toString()));
    }
  }

  Launch getLaunch(String id) {
    if (state.status == RequestStatus.loaded) {
      return LaunchUtils.getAllLaunches(state.value)
          .where((l) => l.id == id)
          .single;
    } else {
      return null;
    }
  }
}
