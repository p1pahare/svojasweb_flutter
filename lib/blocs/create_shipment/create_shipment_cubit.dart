import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:svojasweb/models/api_response.dart';
import 'package:svojasweb/models/buying.dart';
import 'package:svojasweb/models/cquote.dart';
import 'package:svojasweb/models/quote.dart';
import 'package:svojasweb/models/quotec.dart';
import 'package:svojasweb/repositories/cquote_repository.dart';
import 'dart:developer' as d;
part 'create_shipment_state.dart';

class CreateShipmentCubit extends Cubit<CreateShipmentState> {
  CreateShipmentCubit() : super(CreateShipmentInitial());

  create(Map<String, dynamic> cquote) async {
    emit(CreateShipmentLoading());
    final ApiResponse apiResponse =
        await GetIt.I<CquoteRepository>().createCquote(cquote);
    if (apiResponse.status) {
      // GetIt.I<Preferences>().saveIsCreateQuote(isCreateQuote: true);

      emit(CreateShipmentSuccess(
          successMessage:
              "Shipment details were Updated Successfully. You can close the page now."));
    } else {
      emit(CreateShipmentFailed(errorMessage: apiResponse.message));
    }
  }

  edit(Map<String, dynamic> cquote) async {
    emit(CreateShipmentLoading());
    final ApiResponse apiResponse =
        await GetIt.I<CquoteRepository>().editCquote(cquote);
    if (apiResponse.status) {
      // GetIt.I<Preferences>().saveIsCreateQuote(isCreateQuote: true);

      emit(CreateShipmentSuccess(
          successMessage:
              "Quote Was Updated Successfully. You can close the page now."));
    } else {
      emit(CreateShipmentFailed(errorMessage: apiResponse.message));
    }
  }

  Future<Iterable<Object>> getBuyings(String quoteId) async {
    if (quoteId.isEmpty) {
      return {};
    }
    emit(CreateShipmentLoading());
    final ApiResponse apiResponse =
        await GetIt.I<CquoteRepository>().getCquoteByQuoteID(quoteId);
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
      d.log(cquote.toString());
      emit(CreatePageSuccess(
          buying: buying, quotec: quoteC, quote: quote, cquote: cquote));
      return newList;
    } else {
      emit(CreateShipmentFailed(errorMessage: apiResponse.message));
      return {};
    }
  }
}
