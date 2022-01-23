import 'raspiblitz_logo.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:common/common.dart';

import 'menu_button.dart';

enum Pages {
  apps,
  channels,
  dashboard,
  logout,
  reboot,
  settings,
  shutdown,
  transactions,
}

class HeaderBar extends StatelessWidget {
  final Function(Pages) onPressed;
  final minWidth = 150.0;
  final Pages currentPage;

  const HeaderBar(this.onPressed, this.currentPage, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 200),
              child: const RaspiBlitzLogo(),
            ),
            MenuButton(
              onPressed: () => onPressed(Pages.dashboard),
              icon: Icons.dashboard,
              labelText: 'dashboard.big_screen.headerbar.btn_dashboard',
              minWidth: minWidth,
              highlight: currentPage == Pages.dashboard,
            ),
            MenuButton(
              onPressed: () => onPressed(Pages.transactions),
              icon: Icons.account_balance_wallet,
              labelText: 'dashboard.big_screen.headerbar.btn_transactions',
              minWidth: minWidth,
              highlight: currentPage == Pages.transactions,
            ),
            MenuButton(
              onPressed: () => onPressed(Pages.channels),
              icon: Icons.scatter_plot,
              labelText: 'dashboard.big_screen.headerbar.btn_channels',
              minWidth: minWidth,
              highlight: currentPage == Pages.channels,
            ),
            MenuButton(
              onPressed: () => onPressed(Pages.apps),
              icon: Icons.apps,
              labelText: 'dashboard.big_screen.headerbar.btn_apps',
              minWidth: minWidth,
              highlight: currentPage == Pages.apps,
            ),
            const Spacer(),
            DropdownButtonHideUnderline(
              child: DropdownButton2(
                customButton: const Icon(
                  Icons.account_box,
                  color: Colors.amber,
                  size: 30,
                ),
                customItemsIndexes: const [3],
                customItemsHeight: 8,
                items: [
                  ..._MenuItems.firstItems.map(
                    (item) => DropdownMenuItem<_MenuItem>(
                      value: item,
                      child: _MenuItems.buildItem(item),
                    ),
                  ),
                  const DropdownMenuItem<Divider>(
                    enabled: false,
                    child: Divider(),
                  ),
                  ..._MenuItems.secondItems.map(
                    (item) => DropdownMenuItem<_MenuItem>(
                      value: item,
                      child: _MenuItems.buildItem(item),
                    ),
                  ),
                ],
                onChanged: (value) {
                  final item = value as _MenuItem;
                  if (item == _MenuItems.reboot) {
                    onPressed(Pages.reboot);
                  } else if (item == _MenuItems.settings) {
                    onPressed(Pages.settings);
                  } else if (item == _MenuItems.shutdown) {
                    onPressed(Pages.shutdown);
                  } else if (item == _MenuItems.logout) {
                    onPressed(Pages.logout);
                  }
                },
                itemHeight: 48,
                dropdownWidth: 160,
                itemPadding: const EdgeInsets.only(left: 16, right: 16),
                dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                ),
                dropdownElevation: 8,
                offset: const Offset(0, 8),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _MenuItem {
  final String text;
  final IconData icon;

  const _MenuItem({
    required this.text,
    required this.icon,
  });
}

class _MenuItems {
  static final reboot = _MenuItem(
    text: tr('settings.reboot_button'),
    icon: Icons.restart_alt,
  );
  static final shutdown = _MenuItem(
    text: tr('settings.shutdown_button'),
    icon: Icons.power_settings_new,
  );
  static final settings = _MenuItem(
    text: tr('settings.settings'),
    icon: Icons.settings,
  );
  static final logout = _MenuItem(
    text: tr('auth.logout_button'),
    icon: Icons.logout,
  );

  static final List<_MenuItem> firstItems = [settings, reboot, shutdown];
  static final List<_MenuItem> secondItems = [logout];

  static Widget buildItem(_MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.white, size: 22),
        const SizedBox(width: 10),
        Text(
          item.text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
