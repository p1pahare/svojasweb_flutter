import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:svojasweb/models/api_response.dart';
import 'package:svojasweb/models/buying.dart';
import 'package:svojasweb/models/cquote.dart';
import 'package:svojasweb/models/quote.dart';
import 'package:svojasweb/models/quotec.dart';
import 'package:svojasweb/repositories/buying_repository.dart';
import 'dart:developer' as d;

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
      final Buying? buying = Buying.fromJson(apiResponse.data['ops'][0]);
      emit(CreateBuyingSuccess(
          buying: buying,
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
      final Buying? buying = Buying.fromJson(apiResponse.data['ops'][0]);
      emit(CreateBuyingSuccess(
          buying: buying,
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
    d.log(state.toString());
    final ApiResponse apiResponse =
        await GetIt.I<BuyingRepository>().getBuyingByQuoteID(quoteId);
    if (apiResponse.status) {
      final Map<String, List<dynamic>> finalMap = {};
      final entries = (apiResponse.data as Map<String, dynamic>);
      Quote? quote;
      QuoteC? quoteC;
      Buying? buying;
      Cquote? cquote;
      entries.forEach((key, value) {
        List<dynamic> newValue = [];
        for (final element in value) {
          if (element['type'] == 'quote') {
            quote = Quote.fromJson(element);
            newValue.add(quote);
          }
          if (element['type'] == 'quotec') {
            quoteC = QuoteC.fromJson(element);
            newValue.add(quoteC);
          }
          if (element['type'] == 'buying') {
            buying = Buying.fromJson(element);
            newValue.add(buying);
          }
          if (element['type'] == 'cquote') {
            cquote = Cquote.fromJson(element);
            newValue.add(cquote);
          }
        }
        finalMap[key] = newValue;
      });
      emit(CreatePageSuccess(buying: buying, quote: quote, quotec: quoteC));
      return finalMap;
    } else {
      return {};
    }
  }
}
