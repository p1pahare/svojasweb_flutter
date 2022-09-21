part of 'party_cubit.dart';

@immutable
abstract class PartyState {}

class PartyInitial extends PartyState {}

class PartyLoading extends PartyState {}

class PartyFailed extends PartyState {
  PartyFailed({this.errorMessage});
  final String? errorMessage;
}

class PartySuccess extends PartyState {
  PartySuccess({this.parties, this.pageMD});
  final PageMD? pageMD;
  final List<Party>? parties;
}
