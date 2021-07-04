import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../common/utils.dart';
import '../../../common/widgets/translated_text.dart';
import 'blocs/download_image/download_image_bloc.dart';
import 'blocs/fetch_release_data/fetch_release_data_bloc.dart';

class FlashSDCardPage extends StatefulWidget {
  const FlashSDCardPage({Key? key}) : super(key: key);

  @override
  _FlashSDCardPageState createState() => _FlashSDCardPageState();
}

class _FlashSDCardPageState extends State<FlashSDCardPage> {
  final _releaseBloc = FetchReleaseDataBloc();
  final _dlBloc = DlImageBloc();

  bool _finished = false;
  bool _etcherWorking = false;

  @override
  void initState() {
    super.initState();
    _releaseBloc.add(FetchReleaseDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      body: _finished ? _buildFinishedUI(theme) : _buildDownloadUI(theme),
    );
  }

  Widget _buildDownloadUI(ThemeData theme) {
    return BlocBuilder<FetchReleaseDataBloc, FetchReleaseDataState>(
      bloc: _releaseBloc,
      builder: (context, releaseState) {
        if (releaseState is FetchReleaseDataInitial) {
          return Center(child: Text('loading'));
        } else if (releaseState is ReleaseDataFetched) {
          return BlocBuilder<DlImageBloc, DlFilesState>(
            buildWhen: (oldState, newState) {
              if (newState is DlFileProgressState) return false;
              return true;
            },
            bloc: _dlBloc,
            builder: (context, state) {
              if (state is DlFilesInitial) {
                return _buildShowReleases(
                  theme,
                  releaseState.data.tagName ?? '',
                );
              } else if (state is DlFileStartState) {
                return _buildDlUI(state, _dlBloc, theme);
              } else if (state is DlFilesErrorFileExistsState) {
                _showFileExistsAlert(state, _dlBloc);
                return _buildEmptyDlUI();
              } else if (state is DlFileErrorState) {
                return Center(child: Text(state.message));
              } else if (state is DlFileCanceledState) {
                return Center(child: Text('Canceled'));
              } else if (state is DlFileAllFinishedState) {
                return _buildMakeSDCardUI(theme, state);
              } else {
                return Center(child: Text('Unknown: $state'));
              }
            },
          );
        } else {
          return Center(child: Text('Unkown $releaseState'));
        }
      },
    );
  }

  Widget _buildShowReleases(ThemeData theme, String release) {
    return Center(
      child: Container(
        width: 500,
        child: Column(
          children: [
            SizedBox(height: 8.0),
            TrText(
              'Available Releases',
              style: theme.textTheme.headline5!,
            ),
            SizedBox(height: 8.0),
            Text('Release $release'),
            SizedBox(height: 8.0),
            ElevatedButton.icon(
              icon: Icon(Icons.download_rounded),
              onPressed: () => _dlBloc.add(StartDlEvent(version: release)),
              label: TrText(
                'setup.btn.start_download_files',
                isButton: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinishedUI(ThemeData theme) {
    return Center(
      child: Container(
        width: 500,
        child: Column(
          children: [
            SizedBox(height: 8.0),
            TrText(
              'setup.sd_card_is_ready_header',
              style: theme.textTheme.headline5!,
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/RaspiBlitz_Logo_Icon_Negative.png',
                  width: 40,
                ),
                SizedBox(width: 8.0),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: TrText('setup.sd_card_ready_next_steps_message'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(Icons.delete_sweep_sharp, size: 90),
                Flexible(
                  child: Column(
                    children: [
                      TrText('setup.sd_card_ready_delete_downloaded_files'),
                      SizedBox(height: 8.0),
                      ElevatedButton(
                        onPressed: () {
                          final snackBar = SnackBar(content: Text('TODO :('));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueGrey,
                        ),
                        child: TrText(
                          'setup.btn.delete_downloaded_files',
                          isButton: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: TrText('setup.btn.finish_step', isButton: true),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyDlUI() {
    return Column(
      children: [
        ElevatedButton(onPressed: null, child: Text('Cancel')),
        Text('0 / 0 / 0%'),
        LinearProgressIndicator(value: 0),
      ],
    );
  }

  Widget _buildDlUI(
      DlFileStartState state, DlImageBloc dlBloc, ThemeData theme) {
    final file = state.dlFile == DlFile.image ? 'Image (1/2)' : 'Etcher (2/2)';

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            tr('setup.downloading_file', {'file': file}),
            style: theme.textTheme.headline5!,
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 500,
                child: Column(
                  children: [
                    BlocBuilder<DlImageBloc, DlFilesState>(
                      bloc: dlBloc,
                      builder: (context, state) {
                        if (state is DlFileProgressState) {
                          return Text(
                            tr(
                              'setup.downloading_file_progress_next',
                              {
                                'downloadedMiB': state.downloadedMiB,
                                'totalMiB': state.totalMiB,
                                'percent': state.percent.toStringAsFixed(2)
                              },
                            ),
                          );
                        }
                        return Text('0 / 0 / 0%');
                      },
                    ),
                    SizedBox(height: 8.0),
                    BlocBuilder<DlImageBloc, DlFilesState>(
                      bloc: dlBloc,
                      builder: (context, state) {
                        if (state is DlFileProgressState) {
                          final normalized =
                              (1 / state.totalMiB) * state.downloadedMiB;
                          return LinearProgressIndicator(value: normalized);
                        }
                        return LinearProgressIndicator(value: 0);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.0),
              ElevatedButton(
                onPressed: () => dlBloc.add(CancelDlImageEvent()),
                child: Text('Cancel'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showFileExistsAlert(
      DlFilesErrorFileExistsState state, DlImageBloc dlBloc) async {
    SchedulerBinding.instance?.addPostFrameCallback((_) async {
      var result = await showDialog<bool>(
        context: context,
        builder: (BuildContext c) {
          return AlertDialog(
            title: TrText('alert_dialog.confirm_overwrite_file_title'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TrText('alert_dialog.confirm_overwrite_file_body'),
                Text('${state.path}'),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: TrText('alert_dialog.cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: TrText('alert_dialog.overwrite'),
              ),
            ],
          );
        },
      );

      if (result != null && result is bool && result) {
        if (state.dlFile == DlFile.image) {
          dlBloc.add(
            StartDlEvent(
              dlFile: DlFile.image,
              version: 'v1.7.0',
              overwrite: true,
            ),
          );
        } else if (state.dlFile == DlFile.etcher) {
          dlBloc.add(
            StartDlEvent(dlFile: DlFile.etcher, overwrite: true),
          );
        }
      }
    });
  }

  Widget _buildMakeSDCardUI(ThemeData theme, DlFileAllFinishedState state) {
    return Center(
      child: Container(
        width: 500,
        child: Column(
          children: [
            SizedBox(height: 8.0),
            TrText(
              'setup.sd_card_ready_to_flash_header',
              style: theme.textTheme.headline5!,
            ),
            TrText('setup.sd_card_ready_to_flash_explanation'),
            SizedBox(height: 16.0),
            if (_etcherWorking) ...[
              TrText('setup.sd_cart_waiting_for_etcher'),
              SizedBox(height: 16.0),
              SpinKitFoldingCube(color: Colors.blueAccent)
            ] else
              ElevatedButton.icon(
                icon: Icon(Icons.open_in_new),
                onPressed: () => _launchEtcher(state),
                label: TrText(
                  'setup.btn.open_etcher_application',
                  isButton: true,
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _launchEtcher(DlFileAllFinishedState state) async {
    setState(() {
      _etcherWorking = true;
    });

    // Make Etcher executable
    await Process.run('chmod', ['+x', state.etcherPath]);

    // Execute Etcher
    await Process.run(state.etcherPath, [state.imagePath]);
    // TODO: Check return code

    _showSDCardFlashAlert();
  }

  void _showSDCardFlashAlert() {
    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      var result = await showDialog<bool>(
        context: context,
        builder: (BuildContext c) {
          return AlertDialog(
            title: TrText('SD-card OK?'),
            content: TrText(
                'Was the SD-card flashed correctly? If there was a problem hit retry.'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: TrText('alert_dialog.retry', isButton: true),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: TrText('alert_dialog.ok', isButton: true),
              ),
            ],
          );
        },
      );
      if (result != null && result is bool && result) {
        setState(() {
          _etcherWorking = false;
          _finished = true;
        });
      }
    });
  }
}
