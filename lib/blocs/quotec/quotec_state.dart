part of 'quotec_cubit.dart';

@immutable
abstract class QuotecState {}

class QuotecInitial extends QuotecState {}

class QuotecLoading extends QuotecState {}

class QuotecFailed extends QuotecState {
  QuotecFailed({this.errorMessage});
  final String? errorMessage;
}

class QuotecSuccess extends QuotecState {
  QuotecSuccess({this.quotecs});

  final List<QuoteC>? quotecs;
}
