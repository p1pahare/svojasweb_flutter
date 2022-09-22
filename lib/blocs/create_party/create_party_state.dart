part of 'create_party_cubit.dart';

@immutable
abstract class CreatePartyState {}

class CreatePartyInitial extends CreatePartyState {}

class CreatePartyLoading extends CreatePartyState {}

class CreatePartyFailed extends CreatePartyState {
  CreatePartyFailed({this.errorMessage});
  final String? errorMessage;
}

class CreatePageSuccess extends CreatePartyState {
  CreatePageSuccess({
    this.id,
    this.date,
  });
  final String? id;
  final String? date;
}

class CreatePartySuccess extends CreatePartyState {
  CreatePartySuccess({this.successMessage, this.party});
  final Party? party;
  final String? successMessage;
}
