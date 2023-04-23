part of 'fetch_release_data_bloc.dart';

@immutable
abstract class FetchReleaseDataState {}

class FetchReleaseDataInitial extends FetchReleaseDataState {}

class FetchReleaseDataSuccess extends FetchReleaseDataState {
  final ReleaseData data;

  FetchReleaseDataSuccess(this.data);
}

class FetchReleaseDataFailure extends FetchReleaseDataState {
  final String message;

  FetchReleaseDataFailure(this.message);
}
