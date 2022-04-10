// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:common/common.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:setup_app/new_node/bloc/models/initial_setup_info.dart';
import 'package:setup_app/new_node/prepare_sd_card/models/setup_info_box.dart';

import '../bloc/setup_bloc.dart';

class ConnectPage extends StatefulWidget {
  final String url;

  const ConnectPage(this.url, {Key? key}) : super(key: key);

  @override
  _ConnectPageState createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage> {
  bool _acceptedMigrationSkip = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const TrText('setup.appbar_title')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: BlocBuilder<NewNodeSetupBloc, SetupState>(
            builder: (context, state) {
              if (state is SetupInitial) {
                return SpinKitCubeGrid(color: theme.primaryColor, size: 50);
              } else if (state is ConnectingNodeSuccess) {
                return _buildBody([
                  const SizedBox(height: 8),
                  TrText(
                    'setup.success_message_header',
                    style: theme.textTheme.headline5,
                  ),
                  const SizedBox(height: 16),
                  TrText('URL: ${state.url}'),
                  const SizedBox(height: 4),
                  const TrText('setup.success_message_body'),
                  const SizedBox(height: 16),
                  if (state.setupInfo.hddGotMigrationData.isNotEmpty)
                    _buildMigrationInfoBox(state.setupInfo),
                  const SizedBox(height: 16),
                  const SetupInfoBox(
                    text: 'setup.on_connect_success_info_box_body',
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _acceptedMigrationSkip
                        ? () => context.go('/get-passwords')
                        : null,
                    child: const TrText('setup.btn.next_step'),
                  )
                ]);
              } else if (state is ConnectingNodeError) {
                if (state.errorMessage.contains('SocketException')) {
                  return _buildBody([
                    const SizedBox(height: 8),
                    TrText(
                      'setup.errors.that_didnt_work',
                      style: theme.textTheme.displaySmall,
                    ),
                    const SizedBox(height: 16),
                    SetupInfoBox(
                      isError: true,
                      icon: Icons.error_outline,
                      text: 'setup.errors.cant_connect_to_url',
                      args: {'url': widget.url},
                    ),
                  ]);
                }

                return _buildBody(
                  [Text('Error ${state.errorMessage}/${state.status}')],
                );
              }
              return Center(child: Text('Unknown $state'));
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBody(List<Widget> children) {
    return Column(
      children: AnimationConfiguration.toStaggeredList(
        duration: const Duration(milliseconds: 375),
        childAnimationBuilder: (widget) => SlideAnimation(
          horizontalOffset: 50.0,
          child: FadeInAnimation(
            child: widget,
          ),
        ),
        children: children,
      ),
    );
  }

  _buildMigrationInfoBox(InitialSetupInfo info) {
    return SetupInfoBox(
      icon: Icons.warning_amber_rounded,
      text: 'setup.migration_data_found_warning',
      args: {
        'hddGotMigrationData': info.hddGotMigrationData,
        'sshLogin': info.sshLogin,
      },
      action: InkWell(
        onTap: () =>
            setState(() => _acceptedMigrationSkip = !_acceptedMigrationSkip),
        child: Row(children: [
          Checkbox(
            value: _acceptedMigrationSkip,
            onChanged: (value) => setState(
                () => _acceptedMigrationSkip = !_acceptedMigrationSkip),
          ),
          TrText(
            'setup.migration_data_found_warning_checkbox_text',
            overflow: TextOverflow.ellipsis,
            args: {'hddGotMigrationData': info.hddGotMigrationData},
          )
        ]),
      ),
    );
  }
}
