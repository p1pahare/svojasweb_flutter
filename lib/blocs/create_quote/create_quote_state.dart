part of 'create_quote_cubit.dart';

@immutable
abstract class CreateQuoteState {}

class CreateQuoteInitial extends CreateQuoteState {}

class CreateQuoteLoading extends CreateQuoteState {}

class CreateQuoteFailed extends CreateQuoteState {
  CreateQuoteFailed({this.errorMessage});
  final String? errorMessage;
}

class CreateQuoteSuccess extends CreateQuoteState {
  CreateQuoteSuccess({this.successMessage});

  final String? successMessage;
}

class CreatePageSuccess extends CreateQuoteState {
  CreatePageSuccess({
    this.id,
    this.date,
  });
  final String? id;
  final String? date;
}
