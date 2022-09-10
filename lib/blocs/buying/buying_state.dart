part of 'buying_cubit.dart';

@immutable
abstract class BuyingState {}

class BuyingInitial extends BuyingState {}

class BuyingLoading extends BuyingState {}

class BuyingFailed extends BuyingState {
  BuyingFailed({this.errorMessage});
  final String? errorMessage;
}

class CreatePageSuccess extends BuyingState {
  CreatePageSuccess({this.buying, this.quotec, this.quote});
  final Quote? quote;
  final QuoteC? quotec;
  final Buying? buying;
}
