part of 'fetch_release_data_bloc.dart';

@immutable
abstract class FetchReleaseDataState {}

class FetchReleaseDataInitial extends FetchReleaseDataState {}

class ReleaseDataFetched extends FetchReleaseDataState {
  final ReleaseData data;

  ReleaseDataFetched(this.data);
}
