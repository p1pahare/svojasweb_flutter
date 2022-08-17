import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:svojasweb/models/api_response.dart';
import 'package:svojasweb/models/party.dart';
import 'package:svojasweb/repositories/network_calls.dart';

part 'party_state.dart';

class PartyCubit extends Cubit<PartyState> {
  PartyCubit() : super(PartyInitial());
  int pageNumber = 1;

  bool isPrevious() => pageNumber != 1;
  prviousPage() {
    if (pageNumber != 1) {
      pageNumber -= 1;
    }
    load();
  }

  nextPage() {
    pageNumber += 1;

    load();
  }

  load() async {
    emit(PartyLoading());
    final ApiResponse apiResponse =
        await GetIt.I<NetworkCalls>().getAllParties(pageNumber: pageNumber);
    if (apiResponse.status) {
      List<Party> parties = (apiResponse.data as List<dynamic>)
          .map<Party>((e) => Party.fromJson(e))
          .toList();

      emit(PartySuccess(parties: parties));
    } else {
      emit(PartyFailed(errorMessage: apiResponse.message));
    }
  }
}
