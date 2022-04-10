import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../models/release_data.dart';

part 'fetch_release_data_event.dart';
part 'fetch_release_data_state.dart';

class FetchReleaseDataBloc
    extends Bloc<FetchReleaseDataEvent, FetchReleaseDataState> {
  FetchReleaseDataBloc() : super(FetchReleaseDataInitial()) {
    on<FetchReleaseDataEvent>((event, emit) async {
      final opt = BaseOptions(
        headers: {'Accept': 'application/vnd.github.inertia-preview+json'},
      );
      final data = await Dio(opt).get(
        'https://api.github.com/repos/rootzoll/raspiblitz/releases',
      );
      
      if (data.statusCode == 200) {
        final releases =
            (data.data as List).map((e) => ReleaseData.fromJson(e)).toList();
        emit(FetchReleaseDataSuccess(releases[0]));
      } else {
        emit(FetchReleaseDataFailure(data.statusMessage ?? 'Unknown error'));
      }
    });
  }
}
