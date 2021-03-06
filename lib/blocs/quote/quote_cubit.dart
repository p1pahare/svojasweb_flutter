import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:svojasweb/models/api_response.dart';
import 'package:svojasweb/models/quote.dart';
import 'package:svojasweb/repositories/network_calls.dart';

part 'quote_state.dart';

class QuoteCubit extends Cubit<QuoteState> {
  QuoteCubit() : super(QuoteInitial());

  load() async {
    emit(QuoteLoading());
    final ApiResponse apiResponse =
        await GetIt.I<NetworkCalls>().getAllQuotes();
    if (apiResponse.status) {
      List<Quote> quotes = (apiResponse.data as List<dynamic>)
          .map<Quote>((e) => Quote.fromJson(e))
          .toList();

      emit(QuoteSuccess(quotes: quotes));
    } else {
      emit(QuoteFailed(errorMessage: apiResponse.message));
    }
  }
}
