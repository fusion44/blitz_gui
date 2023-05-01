// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:common_widgets/common_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:setup_app/new_node/prepare_sd_card/blocs/fetch_release_data/fetch_release_data_bloc.dart';

class ChoseReleasePage extends StatelessWidget {
  const ChoseReleasePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const TrText('setup.appbar_title')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: BlocBuilder<FetchReleaseDataBloc, FetchReleaseDataState>(
            bloc: FetchReleaseDataBloc()..add(FetchReleaseDataEvent()),
            builder: (context, state) {
              if (state is FetchReleaseDataSuccess) {
                return _buildShowReleases(theme, context, state.data.name);
              } else if (state is FetchReleaseDataFailure) {
                return Center(child: Text('Error: ${state.message}'));
              }

              return const Center(child: Text('loading'));
            },
          ),
        ),
      ),
    );
  }

  Widget _buildShowReleases(
    ThemeData theme,
    BuildContext context,
    String release,
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
          ..._buildTop(theme, 'Releases'),
          const SizedBox(height: 8.0),
          TrText(
            'setup.available_releases',
            style: theme.textTheme.headlineSmall!,
          ),
          const SizedBox(height: 8.0),
          TrText(
            'setup.latest_release',
            args: {'release': release},
          ),
          const SizedBox(height: 8.0),
          ElevatedButton.icon(
            icon: const Icon(Icons.download_rounded),
            onPressed: () => context.go('/new-node/download-release-image'),
            label: const TrText(
              'setup.btn.start_download_files',
              isButton: true,
            ),
          ),
        ],
      ),
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
          BreadCrumbItem(content: const Text('Chose Release')),
        ],
        divider: const Icon(Icons.chevron_right),
      ),
    ];
  }
}
