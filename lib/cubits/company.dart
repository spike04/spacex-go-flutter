import 'package:cherry/models/index.dart';
import 'package:cherry/repositories/index.dart';
import 'package:flutter_request_bloc/flutter_request_bloc.dart';

/// Cubit that holds information about SpaceX.
class CompanyCubit extends RequestCubit<CompanyRepository, CompanyInfo> {
  CompanyCubit(CompanyRepository repository) : super(repository);

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
}
