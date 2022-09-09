part of 'create_buyings_cubit.dart';

@immutable
abstract class CreateBuyingsState {}

class CreateBuyingsInitial extends CreateBuyingsState {}

class CreateBuyingLoading extends CreateBuyingsState {}

class CreateBuyingFailed extends CreateBuyingsState {
  CreateBuyingFailed({this.errorMessage});
  final String? errorMessage;
}

class CreateBuyingSuccess extends CreateBuyingsState {
  CreateBuyingSuccess({this.successMessage});

  final String? successMessage;
}

class CreatePageSuccess extends CreateBuyingsState {
  CreatePageSuccess({this.buying});

  final Buying? buying;
}
