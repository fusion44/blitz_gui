import 'package:flutter/material.dart';

import 'package:common_widgets/common_widgets.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../common.dart';
import '../widgets/big_button.dart';
import '../widgets/setup_type_switch.dart';

class ChoseSDCardStateScreen extends StatelessWidget {
  const ChoseSDCardStateScreen({Key? key}) : super(key: key);

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
                  BreadCrumbItem(content: const Text('New Node')),
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
                    icon: MdiIcons.sd,
                    label: 'setup.btn.flash_sd_card',
                    description: 'setup.btn.flash_sd_card_desc',
                    id: NewNodeSteps.flashSDCard.toString(),
                    onPressed: (choice) => onChoosePath(context, choice),
                  ),
                  BigButton(
                    icon: MdiIcons.network,
                    label: 'setup.btn.connect_node',
                    description: 'setup.btn.connect_node_desc',
                    id: NewNodeSteps.connectNode.toString(),
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
    if (choice == NewNodeSteps.flashSDCard.toString()) {
      context.go('/new-node/chose-release');
    } else if (choice == NewNodeSteps.connectNode.toString()) {
      context.go('/find-device');
    } else {
      debugPrint(choice);
      const snackBar = SnackBar(content: Text('Not yet implemented :('));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
