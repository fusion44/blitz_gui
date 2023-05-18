part of 'follow_logs_bloc.dart';

@immutable
abstract class FollowLogsState {}

class FollowLogsInitial extends FollowLogsState {}

class LogsUpdated extends FollowLogsState {
  final List<String> logs;

  LogsUpdated(this.logs);
}
