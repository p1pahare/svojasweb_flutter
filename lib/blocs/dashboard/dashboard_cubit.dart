import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:svojasweb/models/api_response.dart';
import 'package:svojasweb/models/statistics.dart';
import 'package:svojasweb/repositories/network_calls.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardInitial());

  load() async {
    emit(DashboardLoading());
    final ApiResponse apiResponse =
        await GetIt.I<NetworkCalls>().getStatistics();
    if (apiResponse.status) {
      // GetIt.I<Preferences>().saveIsDashboard(isDashboard: true);
      final Statistics statistics = Statistics.fromJson(apiResponse.data);
      emit(DashboardSuccess(statistics: statistics));
    } else {
      emit(DashboardFailed(errorMessage: apiResponse.message));
    }
  }
}
