import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:svojasweb/models/api_response.dart';
import 'package:svojasweb/models/quote.dart';
import 'package:svojasweb/repositories/network_calls.dart';

part 'create_quotec_state.dart';

class CreateQuotecCubit extends Cubit<CreateQuotecState> {
  CreateQuotecCubit() : super(CreateQuotecInitial());

  load() async {
    emit(CreateQuotecLoading());
    final ApiResponse apiResponse =
        await GetIt.I<NetworkCalls>().getDateAndReference();
    if (apiResponse.status) {
      // GetIt.I<Preferences>().saveIsCreateQuote(isCreateQuote: true);
      final String id = apiResponse.data['reference'];
      final String date =
          DateTime.parse(apiResponse.data['date']).toLocal().toString();
      emit(CreatePageSuccess(id: id, date: date));
    } else {
      emit(CreateQuotecFailed(errorMessage: apiResponse.message));
    }
  }

  create(Map<String, dynamic> quotec) async {
    emit(CreateQuotecLoading());
    final ApiResponse apiResponse =
        await GetIt.I<NetworkCalls>().createQuoteC(quotec);
    if (apiResponse.status) {
      // GetIt.I<Preferences>().saveIsCreateQuote(isCreateQuote: true);

      emit(CreateQuotecSuccess(
          successMessage:
              "Quote Was Created Successfully. You can close the page now."));
    } else {
      emit(CreateQuotecFailed(errorMessage: apiResponse.message));
    }
  }

  edit(Map<String, dynamic> quotec) async {
    emit(CreateQuotecLoading());
    final ApiResponse apiResponse =
        await GetIt.I<NetworkCalls>().editQuoteC(quotec);
    if (apiResponse.status) {
      // GetIt.I<Preferences>().saveIsCreateQuote(isCreateQuote: true);

      emit(CreateQuotecSuccess(
          successMessage:
              "Quote Was Updated Successfully. You can close the page now."));
    } else {
      emit(CreateQuotecFailed(errorMessage: apiResponse.message));
    }
  }

  Future<Iterable<Quote>> getQuotes(String quoteId) async {
    if (quoteId.isEmpty) {
      return [];
    }
    final ApiResponse apiResponse =
        await GetIt.I<NetworkCalls>().getQuoteByQuoteID(quoteId);
    if (apiResponse.status) {
      return (apiResponse.data as List<dynamic>)
          .map((e) => Quote.fromJson(e))
          .toList();
    } else {
      return [];
    }
  }
}
