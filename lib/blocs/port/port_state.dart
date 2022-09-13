part of 'port_cubit.dart';

@immutable
abstract class PortState {}

class PortInitial extends PortState {}

class CreatePortLoading extends PortState {}

class CreatePortFailed extends PortState {
  CreatePortFailed({this.errorMessage});
  final String? errorMessage;
}

class ListSuccess extends PortState {
  ListSuccess({this.ports});
  final List<Port>? ports;
}

class CreatePortSuccess extends PortState {
  CreatePortSuccess({this.successMessage});

  final String? successMessage;
}
