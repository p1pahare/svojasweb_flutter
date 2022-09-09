import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:svojasweb/models/api_response.dart';
import 'package:svojasweb/models/quotec.dart';
import 'package:svojasweb/repositories/quotec_repostiory.dart';

part 'quotec_state.dart';

class QuotecCubit extends Cubit<QuotecState> {
  QuotecCubit() : super(QuotecInitial());
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
    emit(QuotecLoading());
    final ApiResponse apiResponse =
        await GetIt.I<QuotecRepository>().getAllQuotecs(pageNumber: pageNumber);
    if (apiResponse.status) {
      List<QuoteC> quotecs = (apiResponse.data as List<dynamic>)
          .map<QuoteC>((e) => QuoteC.fromJson(e))
          .toList();

      emit(QuotecSuccess(quotecs: quotecs));
    } else {
      emit(QuotecFailed(errorMessage: apiResponse.message));
    }
  }
}
