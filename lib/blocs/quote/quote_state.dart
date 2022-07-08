part of 'quote_cubit.dart';

@immutable
abstract class QuoteState {}

class QuoteInitial extends QuoteState {}

class QuoteLoading extends QuoteState {}

class QuoteFailed extends QuoteState {
  QuoteFailed({this.errorMessage});
  final String? errorMessage;
}

class QuoteSuccess extends QuoteState {
  QuoteSuccess({this.quotes});

  final List<Quote>? quotes;
}
