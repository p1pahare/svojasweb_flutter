import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:svojasweb/models/api_response.dart';
import 'package:svojasweb/models/quotec.dart';
import 'package:svojasweb/repositories/network_calls.dart';

part 'quotec_state.dart';

class QuotecCubit extends Cubit<QuotecState> {
  QuotecCubit() : super(QuotecInitial());

  load() async {
    emit(QuotecLoading());
    final ApiResponse apiResponse =
        await GetIt.I<NetworkCalls>().getAllQuotecs();
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
