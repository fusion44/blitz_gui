part of 'new_block_watcher_cubit.dart';

@immutable
abstract class NewBlockWatcherState {}

class NewBlockWatcherInitial extends NewBlockWatcherState {}

class NewBlockAppended extends NewBlockWatcherState {
  final BlockData blockData;

  NewBlockAppended(this.blockData);
}
