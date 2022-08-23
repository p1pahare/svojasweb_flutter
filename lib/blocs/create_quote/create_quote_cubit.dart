import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:svojasweb/models/api_response.dart';
import 'package:svojasweb/models/party.dart';
import 'package:svojasweb/repositories/network_calls.dart';

part 'create_quote_state.dart';

class CreateQuoteCubit extends Cubit<CreateQuoteState> {
  CreateQuoteCubit() : super(CreateQuoteInitial());

  load() async {
    emit(CreateQuoteLoading());
    final ApiResponse apiResponse =
        await GetIt.I<NetworkCalls>().getDateAndReference();
    if (apiResponse.status) {
      // GetIt.I<Preferences>().saveIsCreateQuote(isCreateQuote: true);
      final String id = apiResponse.data['reference'];
      final String date =
          DateTime.parse(apiResponse.data['date']).toLocal().toString();
      emit(CreatePagelSuccess(id: id, date: date));
    } else {
      emit(CreateQuoteFailed(errorMessage: apiResponse.message));
    }
  }

  create(Map<String, dynamic> quote) async {
    emit(CreateQuoteLoading());
    final ApiResponse apiResponse =
        await GetIt.I<NetworkCalls>().createQuote(quote);
    if (apiResponse.status) {
      // GetIt.I<Preferences>().saveIsCreateQuote(isCreateQuote: true);

      emit(CreateQuoteSuccess(
          successMessage:
              "Quote Was Created Successfully. You can close the page now."));
    } else {
      emit(CreateQuoteFailed(errorMessage: apiResponse.message));
    }
  }

  edit(Map<String, dynamic> quote) async {
    emit(CreateQuoteLoading());
    final ApiResponse apiResponse =
        await GetIt.I<NetworkCalls>().editQuote(quote);
    if (apiResponse.status) {
      // GetIt.I<Preferences>().saveIsCreateQuote(isCreateQuote: true);

      emit(CreateQuoteSuccess(
          successMessage:
              "Quote Was Updated Successfully. You can close the page now."));
    } else {
      emit(CreateQuoteFailed(errorMessage: apiResponse.message));
    }
  }

  Future<Iterable<Party>> getParties(String partyName) async {
    if (partyName.isEmpty) {
      return [];
    }
    final ApiResponse apiResponse =
        await GetIt.I<NetworkCalls>().getPartyByName(partyName);
    if (apiResponse.status) {
      return (apiResponse.data as List<dynamic>)
          .map((e) => Party.fromJson(e))
          .toList();
    } else {
      return [];
    }
  }
}
