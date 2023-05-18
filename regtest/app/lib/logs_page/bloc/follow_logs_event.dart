part of 'follow_logs_bloc.dart';

@immutable
abstract class FollowLogsEvent {}

@immutable
class FollowLogsError extends FollowLogsEvent {
  final String message;

  FollowLogsError(this.message);
}

@immutable
class _NewLogEntry extends FollowLogsEvent {
  final String entry;

  _NewLogEntry(this.entry);
}

@immutable
class _InitialLoadFinished extends FollowLogsEvent {
  final List<String> entries;

  _InitialLoadFinished(this.entries);
}
