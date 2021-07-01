import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../models/release_data.dart';

part 'fetch_release_data_event.dart';
part 'fetch_release_data_state.dart';

class FetchReleaseDataBloc
    extends Bloc<FetchReleaseDataEvent, FetchReleaseDataState> {
  FetchReleaseDataBloc() : super(FetchReleaseDataInitial());

  @override
  Stream<FetchReleaseDataState> mapEventToState(
    FetchReleaseDataEvent event,
  ) async* {
    if (event is FetchReleaseDataEvent) {
      final opt = BaseOptions(
        headers: {'Accept': 'application/vnd.github.inertia-preview+json'},
      );
      final data = await Dio(opt).get(
        'https://api.github.com/repos/rootzoll/raspiblitz/releases',
      );
      var latestRelease = data.data[0];
      var currentPublishedAt = DateTime.parse(data.data[0]['published_at']);

      for (var r in data.data) {
        if (r['draft'] || r['prerelease']) continue;
        final publishedAt = DateTime.parse(r['published_at']);
        if (publishedAt.isAfter(currentPublishedAt)) {
          latestRelease = r;
          currentPublishedAt = publishedAt;
        }
      }

      yield ReleaseDataFetched(ReleaseData.fromJson(latestRelease));
    }
  }
}
