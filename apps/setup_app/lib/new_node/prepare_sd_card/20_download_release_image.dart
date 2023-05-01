// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:common_widgets/common_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';

import 'blocs/download_image/download_image_bloc.dart';
import 'models/file_data.dart';
import 'models/setup_info_box.dart';

class DownloadReleasePage extends StatefulWidget {
  const DownloadReleasePage({Key? key}) : super(key: key);

  @override
  State<DownloadReleasePage> createState() => _DownloadReleasePageState();
}

class _DownloadReleasePageState extends State<DownloadReleasePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const TrText('setup.appbar_title')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: BlocBuilder<DlImageBloc, DlImageBaseState>(
            bloc: DlImageBloc()..add(StartDlEvent()),
            builder: (context, state) {
              if (state is DlImageProgressState) {
                return _buildDownloadingUI(theme, context, state);
              } else if (state is DlImageAllFinishedState) {
                return _buildFinishedUI(theme, context, state);
              }

              return const Center(child: Text('loading'));
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFinishedUI(
    ThemeData theme,
    BuildContext context,
    DlImageAllFinishedState state,
  ) {
    return Column(
      children: AnimationConfiguration.toStaggeredList(
        duration: const Duration(milliseconds: 375),
        childAnimationBuilder: (widget) => SlideAnimation(
          horizontalOffset: 50.0,
          child: FadeInAnimation(
            child: widget,
          ),
        ),
        children: [
          ..._buildTop(theme, 'Download finished'),
          const SizedBox(height: 16.0),
          const SetupInfoBox(
            text: 'setup.download_finished_text',
            icon: Icons.download_done,
          ),
          const SizedBox(height: 16.0),
          const SetupInfoBox(text: 'setup.sd_card_ready_to_flash_explanation'),
          const SizedBox(height: 24.0),
          ElevatedButton(
            child: const TrText('setup.btn.open_etcher_btn'),
            onPressed: () => context.go(
              '/new-node/actually-flash-card',
              extra: state.files.toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDownloadingUI(
    ThemeData theme,
    BuildContext context,
    DlImageProgressState state,
  ) {
    return Column(
      children: AnimationConfiguration.toStaggeredList(
        duration: const Duration(milliseconds: 375),
        childAnimationBuilder: (widget) => SlideAnimation(
          horizontalOffset: 50.0,
          child: FadeInAnimation(child: widget),
        ),
        children: [
          ..._buildTop(theme, 'Downloading'),
          const SizedBox(height: 8.0),
          ..._buildDlStateRows(state),
        ],
      ),
    );
  }

  List<Widget> _buildDlStateRows(DlImageProgressState state) {
    final tiles = state.files.map((p) {
      double normalized;
      if (p.status == DlFileStatus.queued) {
        normalized = 0.0;
      } else if (p.status == DlFileStatus.downloading) {
        normalized = p.downloadedMiB / p.totalMiB;
      } else if (p.status == DlFileStatus.finished) {
        normalized = 1.0;
      } else {
        throw StateError('Unknown status ${p.status}');
      }

      return _buildListTile(p, normalized);
    }).toList();
    return tiles;
  }

  Widget _buildListTile(
    FileData progress,
    double progressNormalized,
  ) {
    Widget icon;
    Color progressIndicatorColor = Colors.red;
    if (progress.status == DlFileStatus.queued) {
      icon = const Icon(Icons.file_download);
    } else if (progress.status == DlFileStatus.downloading) {
      icon = const SizedBox(
        height: 25,
        width: 25,
        child: SpinKitCircle(size: 25, color: Colors.orange),
      );
      progressIndicatorColor = Colors.orange;
    } else {
      icon = const Icon(Icons.file_download_done);
      progressIndicatorColor = Colors.green;
    }

    return ListTile(
      leading: icon,
      title: LinearProgressIndicator(
        value: progressNormalized,
        color: progressIndicatorColor,
      ),
      subtitle: Row(children: [
        Text(progress.fileName),
        const Spacer(),
        Text('${progress.percent.toStringAsFixed(2)}%'),
      ]),
    );
  }

  List<Widget> _buildTop(ThemeData theme, String step) {
    return [
      BreadCrumb(
        items: <BreadCrumbItem>[
          BreadCrumbItem(content: const Text('Blitz')),
          BreadCrumbItem(content: const Text('Setup')),
          BreadCrumbItem(content: const Text('New Node')),
          BreadCrumbItem(content: const Text('Prepare SD Card')),
          BreadCrumbItem(content: Text(step)),
        ],
        divider: const Icon(Icons.chevron_right),
      ),
    ];
  }
}
