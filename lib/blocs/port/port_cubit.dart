import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:svojasweb/models/api_response.dart';
import 'package:svojasweb/models/port.dart';
import 'package:svojasweb/repositories/port_repository.dart';
part 'port_state.dart';

class PortCubit extends Cubit<PortState> {
  PortCubit() : super(PortInitial());

  loadPorts() async {
    emit(CreatePortLoading());
    final ApiResponse apiResponse =
        await GetIt.I<PortRepository>().getPortByFields();
    if (apiResponse.status) {
      List<Port> ports = (apiResponse.data as List<dynamic>)
          .map<Port>((e) => Port.fromJson(e))
          .toList();

      emit(ListSuccess(ports: ports));
    } else {
      emit(CreatePortFailed(errorMessage: apiResponse.message));
    }
  }

  create(Map<String, dynamic> port) async {
    emit(CreatePortLoading());
    final ApiResponse apiResponse =
        await GetIt.I<PortRepository>().createPort(port);
    if (apiResponse.status) {
      // GetIt.I<Preferences>().saveIsCreateParty(isCreateParty: true);

      emit(CreatePortSuccess(
          successMessage:
              "Party Was Created Successfully. You can close the page now."));
    } else {
      emit(CreatePortFailed(errorMessage: apiResponse.message));
    }
  }
}
