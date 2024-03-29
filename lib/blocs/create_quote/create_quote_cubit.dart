import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:svojasweb/models/api_response.dart';
import 'package:svojasweb/models/party.dart';
import 'package:svojasweb/models/port.dart';
import 'package:svojasweb/models/quote.dart';
import 'package:svojasweb/repositories/basic_repository.dart';
import 'package:svojasweb/repositories/party_repository.dart';
import 'package:svojasweb/repositories/port_repository.dart';
import 'package:svojasweb/repositories/quote_repository.dart';

part 'create_quote_state.dart';

class CreateQuoteCubit extends Cubit<CreateQuoteState> {
  CreateQuoteCubit() : super(CreateQuoteInitial());

  load() async {
    emit(CreateQuoteLoading());
    final ApiResponse apiResponse =
        await GetIt.I<BasicRepository>().getDateAndReference();
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
        await GetIt.I<QuoteRepository>().createQuote(quote);
    if (apiResponse.status) {
      // GetIt.I<Preferences>().saveIsCreateQuote(isCreateQuote: true);
      final Quote? quote = Quote.fromJson(apiResponse.data['ops'][0]);
      emit(CreateQuoteSuccess(
          quote: quote,
          successMessage:
              "Quote Was Created Successfully. You can close the page now."));
    } else {
      emit(CreateQuoteFailed(errorMessage: apiResponse.message));
    }
  }

  edit(Map<String, dynamic> quote) async {
    emit(CreateQuoteLoading());
    final ApiResponse apiResponse =
        await GetIt.I<QuoteRepository>().editQuote(quote);
    if (apiResponse.status) {
      // GetIt.I<Preferences>().saveIsCreateQuote(isCreateQuote: true);
      // final Quote? quote = Quote.fromJson(apiResponse.data['ops'][0]);
      emit(CreateQuoteSuccess(
          // quote: quote,
          successMessage:
              "Quote Was Updated Successfully. You can close the page now."));
    } else {
      emit(CreateQuoteFailed(errorMessage: apiResponse.message));
    }
  }

  Future<Iterable<Party>> getParties(
      String partyName, String partyType, String port) async {
    if (partyName.isEmpty) {
      return [];
    }
    final ApiResponse apiResponse = await GetIt.I<PartyRepository>()
        .getPartyByName(partyName: partyName, partyType: partyType, port: port);
    if (apiResponse.status) {
      return (apiResponse.data['data'] as List<dynamic>)
          .map((e) => Party.fromJson(e))
          .toList();
    } else {
      return [];
    }
  }

  Future<List<Party>> getTruckers(List<String>? truckers) async {
    if (truckers == null || truckers.isEmpty) {
      return [];
    }

    List<Party> realTruckers = [];

    for (final truckerId in truckers) {
      final ApiResponse apiResponse =
          await GetIt.I<PartyRepository>().getParty(truckerId);
      if (apiResponse.status) {
        realTruckers.add(Party.fromJson(apiResponse.data));
      }
    }
    return realTruckers;
  }

  Future<Iterable<Port>> getPorts(String portName, String portType) async {
    final ApiResponse apiResponse = await GetIt.I<PortRepository>()
        .getPortByFields(portName: portName, portType: portType);
    if (apiResponse.status) {
      return (apiResponse.data['data'] as List<dynamic>)
          .map((e) => Port.fromJson(e))
          .toList();
    } else {
      return [];
    }
  }
}
