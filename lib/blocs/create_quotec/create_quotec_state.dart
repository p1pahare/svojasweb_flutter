part of 'create_quotec_cubit.dart';

@immutable
abstract class CreateQuotecState {}

class CreateQuotecInitial extends CreateQuotecState {}

class CreateQuotecLoading extends CreateQuotecState {}

class CreateQuotecFailed extends CreateQuotecState {
  CreateQuotecFailed({this.errorMessage});
  final String? errorMessage;
}

class CreateQuotecSuccess extends CreateQuotecState {
  CreateQuotecSuccess({this.successMessage});

  final String? successMessage;
}

class CreatePageSuccess extends CreateQuotecState {
  CreatePageSuccess({this.id, this.date, this.quoteC});
  final String? id;
  final String? date;
  final QuoteC? quoteC;
}
