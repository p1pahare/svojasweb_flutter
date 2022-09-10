import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:svojasweb/models/api_response.dart';
import 'package:svojasweb/models/buying.dart';
import 'package:svojasweb/models/cquote.dart';
import 'package:svojasweb/models/quote.dart';
import 'package:svojasweb/models/quotec.dart';
import 'package:svojasweb/repositories/buying_repository.dart';

part 'create_buyings_state.dart';

class CreateBuyingsCubit extends Cubit<CreateBuyingsState> {
  CreateBuyingsCubit() : super(CreateBuyingsInitial());
  load() async {
    emit(CreatePageSuccess());
  }

  create(Map<String, dynamic> buying) async {
    emit(CreateBuyingLoading());
    final ApiResponse apiResponse =
        await GetIt.I<BuyingRepository>().createBuying(buying);
    if (apiResponse.status) {
      // GetIt.I<Preferences>().saveIsCreateQuote(isCreateQuote: true);

      emit(CreateBuyingSuccess(
          successMessage:
              "Buyings Was Updated Successfully. You can close the page now."));
    } else {
      emit(CreateBuyingFailed(errorMessage: apiResponse.message));
    }
  }

  edit(Map<String, dynamic> buying) async {
    emit(CreateBuyingLoading());
    final ApiResponse apiResponse =
        await GetIt.I<BuyingRepository>().editBuying(buying);
    if (apiResponse.status) {
      // GetIt.I<Preferences>().saveIsCreateQuote(isCreateQuote: true);

      emit(CreateBuyingSuccess(
          successMessage:
              "Quote Was Updated Successfully. You can close the page now."));
    } else {
      emit(CreateBuyingFailed(errorMessage: apiResponse.message));
    }
  }

  Future<Map<String, List<dynamic>>> getQuotecs(String quoteId) async {
    if (quoteId.isEmpty) {
      return {};
    }
    final ApiResponse apiResponse =
        await GetIt.I<BuyingRepository>().getBuyingByQuoteID(quoteId);
    if (apiResponse.status) {
      final Map<String, List<dynamic>> finalMap = {};
      final entries = (apiResponse.data as Map<String, dynamic>);
      entries.forEach((key, value) {
        List<dynamic> newValue = [];
        for (final element in value) {
          if (element['type'] == 'quote') {
            newValue.add(Quote.fromJson(element));
          }
          if (element['type'] == 'quotec') {
            newValue.add(QuoteC.fromJson(element));
          }
          if (element['type'] == 'buying') {
            newValue.add(Buying.fromJson(element));
          }
          if (element['type'] == 'cquote') {
            newValue.add(Cquote.fromJson(element));
          }
        }
        finalMap[key] = newValue;
      });
      return finalMap;
    } else {
      return {};
    }
  }
}
