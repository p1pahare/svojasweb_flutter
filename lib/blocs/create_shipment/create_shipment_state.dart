part of 'create_shipment_cubit.dart';

@immutable
abstract class CreateShipmentState {}

class CreateShipmentInitial extends CreateShipmentState {}

class CreateShipmentLoading extends CreateShipmentState {}

class CreateShipmentFailed extends CreateShipmentState {
  CreateShipmentFailed({this.errorMessage});
  final String? errorMessage;
}

class CreateShipmentSuccess extends CreateShipmentState {
  CreateShipmentSuccess({this.successMessage});

  final String? successMessage;
}

class CreatePageSuccess extends CreateShipmentState {
  CreatePageSuccess({this.buying, this.quotec, this.quote, this.cquote});
  final Quote? quote;
  final QuoteC? quotec;
  final Buying? buying;
  final Cquote? cquote;
}
