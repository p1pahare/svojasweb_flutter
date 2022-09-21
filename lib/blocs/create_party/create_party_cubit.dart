import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:svojasweb/models/api_response.dart';
import 'package:svojasweb/models/port.dart';
import 'package:svojasweb/repositories/basic_repository.dart';
import 'package:svojasweb/repositories/party_repository.dart';
import 'package:svojasweb/repositories/port_repository.dart';

part 'create_party_state.dart';

class CreatePartyCubit extends Cubit<CreatePartyState> {
  CreatePartyCubit() : super(CreatePartyInitial());

  load() async {
    emit(CreatePartyLoading());
    final ApiResponse apiResponse =
        await GetIt.I<BasicRepository>().getDateAndReference();
    if (apiResponse.status) {
      // GetIt.I<Preferences>().saveIsCreateParty(isCreateParty: true);
      final String id = apiResponse.data['reference'];
      final String date =
          DateTime.parse(apiResponse.data['date']).toLocal().toString();
      emit(CreatePageSuccess(id: id, date: date));
    } else {
      emit(CreatePartyFailed(errorMessage: apiResponse.message));
    }
  }

  create(Map<String, dynamic> party) async {
    emit(CreatePartyLoading());
    final ApiResponse apiResponse =
        await GetIt.I<PartyRepository>().createParty(party);
    if (apiResponse.status) {
      // GetIt.I<Preferences>().saveIsCreateParty(isCreateParty: true);

      emit(CreatePartySuccess(
          successMessage:
              "Party Was Created Successfully. You can close the page now."));
    } else {
      emit(CreatePartyFailed(errorMessage: apiResponse.message));
    }
  }

  edit(Map<String, dynamic> party) async {
    emit(CreatePartyLoading());
    final ApiResponse apiResponse =
        await GetIt.I<PartyRepository>().editParty(party);
    if (apiResponse.status) {
      // GetIt.I<Preferences>().saveIsCreateParty(isCreateParty: true);

      emit(CreatePartySuccess(
          successMessage:
              "Party Was Updated Successfully. You can close the page now."));
    } else {
      emit(CreatePartyFailed(errorMessage: apiResponse.message));
    }
  }

  Future<Iterable<Port>> getPorts(String portName) async {
    final ApiResponse apiResponse =
        await GetIt.I<PortRepository>().getPortByFields(portName: portName);
    if (apiResponse.status) {
      return (apiResponse.data['data'] as List<dynamic>)
          .map((e) => Port.fromJson(e))
          .toList();
    } else {
      return [];
    }
  }
}
