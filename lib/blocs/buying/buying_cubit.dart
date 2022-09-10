import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:svojasweb/models/api_response.dart';
import 'package:svojasweb/models/buying.dart';
import 'package:svojasweb/models/cquote.dart';
import 'package:svojasweb/models/quote.dart';
import 'package:svojasweb/models/quotec.dart';
import 'package:svojasweb/repositories/buying_repository.dart';

part 'buying_state.dart';

class BuyingCubit extends Cubit<BuyingState> {
  BuyingCubit() : super(BuyingInitial());

  Future<Iterable<Object>> getQuotecs(String quoteId) async {
    if (quoteId.isEmpty) {
      return {};
    }
    emit(BuyingLoading());
    final ApiResponse apiResponse =
        await GetIt.I<BuyingRepository>().getBuyingByQuoteID(quoteId);
    if (apiResponse.status) {
      Quote? quote;
      QuoteC? quoteC;
      Buying? buying;
      Cquote? cquote;
      final List<Object> newList = [];
      final entries = (apiResponse.data as Map<String, dynamic>);
      entries.forEach((key, value) {
        for (final element in value) {
          if (element['type'] == 'quote') {
            quote = Quote.fromJson(element);
          }
          if (element['type'] == 'quotec') {
            quoteC = QuoteC.fromJson(element);
          }
          if (element['type'] == 'buying') {
            buying = Buying.fromJson(element);
            newList.add(buying as Object);
          }
          if (element['type'] == 'cquote') {
            cquote = Cquote.fromJson(element);
          }
        }
      });
      log(cquote.toString());
      emit(CreatePageSuccess(buying: buying, quotec: quoteC, quote: quote));
      return newList;
    } else {
      emit(BuyingFailed(errorMessage: apiResponse.message));
      return {};
    }
  }
}
