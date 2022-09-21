import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:svojasweb/models/api_response.dart';
import 'package:svojasweb/models/pagemd.dart';
import 'package:svojasweb/models/quotec.dart';
import 'package:svojasweb/repositories/quotec_repostiory.dart';

part 'quotec_state.dart';

class QuotecCubit extends Cubit<QuotecState> {
  QuotecCubit() : super(QuotecInitial());

  load({int pageNumber = 1}) async {
    emit(QuotecLoading());
    final ApiResponse apiResponse =
        await GetIt.I<QuotecRepository>().getAllQuotecs(pageNumber: pageNumber);
    if (apiResponse.status) {
      List<QuoteC> quotecs = (apiResponse.data['data'] as List<dynamic>)
          .map<QuoteC>((e) => QuoteC.fromJson(e))
          .toList();
      PageMD pageMD = PageMD.fromJson(apiResponse.data['page']);
      emit(QuotecSuccess(quotecs: quotecs, pageMD: pageMD));
    } else {
      emit(QuotecFailed(errorMessage: apiResponse.message));
    }
  }
}
