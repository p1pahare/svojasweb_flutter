part of 'dashboard_cubit.dart';

@immutable
abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardFailed extends DashboardState {
  DashboardFailed({this.errorMessage});
  final String? errorMessage;
}

class DashboardSuccess extends DashboardState {
  DashboardSuccess({this.statistics});
  final Statistics? statistics;
}
