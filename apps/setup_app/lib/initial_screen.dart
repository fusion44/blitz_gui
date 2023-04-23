import 'package:flutter/material.dart';

import 'package:common/common.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'common.dart';
import 'widgets/big_button.dart';
import 'widgets/setup_type_switch.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const TrText('setup.appbar_title')),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 375),
            childAnimationBuilder: (widget) => SlideAnimation(
              horizontalOffset: 50.0,
              child: FadeInAnimation(
                child: widget,
              ),
            ),
            children: [
              BreadCrumb(
                items: <BreadCrumbItem>[
                  BreadCrumbItem(content: const Text('Blitz')),
                  BreadCrumbItem(content: const Text('Setup')),
                ],
                divider: const Icon(Icons.chevron_right),
              ),
              TrText(
                'setup.choose_setup_type',
                style: theme.textTheme.displayMedium!,
                isButton: true,
              ),
              const SizedBox(height: 16),
              SetupTypeSwitch(
                2,
                [
                  BigButton(
                    icon: MdiIcons.bitcoin,
                    label: 'setup.btn.new_node_from_scratch',
                    description: 'setup.btn.new_node_from_scratch_desc',
                    id: SetupPaths.newNode.toString(),
                    onPressed: (choice) => onChoosePath(context, choice),
                  ),
                  BigButton(
                    icon: Icons.update,
                    label: 'setup.btn.update',
                    description: 'setup.btn.update_desc',
                    id: SetupPaths.update.toString(),
                    onPressed: (choice) => onChoosePath(context, choice),
                  ),
                  BigButton(
                    icon: MdiIcons.wrench,
                    label: 'setup.btn.migrate',
                    description: 'setup.btn.migrate_desc',
                    id: SetupPaths.migration.toString(),
                    onPressed: (choice) => onChoosePath(context, choice),
                  ),
                  BigButton(
                    icon: Icons.import_export,
                    label: 'setup.btn.recover',
                    description: 'setup.btn.recover_desc',
                    id: SetupPaths.recover.toString(),
                    onPressed: (choice) => onChoosePath(context, choice),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onChoosePath(BuildContext context, String choice) {
    if (choice == SetupPaths.newNode.toString()) {
      context.push('/new-node');
    } else {
      debugPrint(choice);
      const snackBar = SnackBar(content: Text('Not yet implemented :('));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
