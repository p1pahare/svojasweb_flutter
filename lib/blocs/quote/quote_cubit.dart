import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:svojasweb/models/api_response.dart';
import 'package:svojasweb/models/pagemd.dart';
import 'package:svojasweb/models/quote.dart';
import 'package:svojasweb/repositories/quote_repository.dart';

part 'quote_state.dart';

class QuoteCubit extends Cubit<QuoteState> {
  QuoteCubit() : super(QuoteInitial());

  load({int pageNumber = 1}) async {
    emit(QuoteLoading());
    final ApiResponse apiResponse =
        await GetIt.I<QuoteRepository>().getAllQuotes(pageNumber: pageNumber);
    if (apiResponse.status) {
      List<Quote> quotes = (apiResponse.data['data'] as List<dynamic>)
          .map<Quote>((e) => Quote.fromJson(e))
          .toList();
      final PageMD pageMD = PageMD.fromJson(apiResponse.data['page']);
      emit(QuoteSuccess(quotes: quotes, pageMD: pageMD));
    } else {
      emit(QuoteFailed(errorMessage: apiResponse.message));
    }
  }
}
