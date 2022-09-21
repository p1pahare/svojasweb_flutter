import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:svojasweb/models/api_response.dart';
import 'package:svojasweb/models/pagemd.dart';
import 'package:svojasweb/models/party.dart';
import 'package:svojasweb/repositories/party_repository.dart';

part 'party_state.dart';

class PartyCubit extends Cubit<PartyState> {
  PartyCubit() : super(PartyInitial());

  load({int pageNumber = 1, String port = '', String type = ''}) async {
    emit(PartyLoading());
    final ApiResponse apiResponse = port.isEmpty && type.isEmpty
        ? (await GetIt.I<PartyRepository>()
            .getAllParties(pageNumber: pageNumber))
        : (await GetIt.I<PartyRepository>()
            .getPartyByName(port: port, partyType: type));
    if (apiResponse.status) {
      List<Party> parties = (apiResponse.data['data'] as List<dynamic>)
          .map<Party>((e) => Party.fromJson(e))
          .toList();
      PageMD pageMD = PageMD.fromJson(apiResponse.data['page']);
      emit(PartySuccess(parties: parties, pageMD: pageMD));
    } else {
      emit(PartyFailed(errorMessage: apiResponse.message));
    }
  }
}
