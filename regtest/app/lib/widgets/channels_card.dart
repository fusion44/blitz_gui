import 'package:flutter/material.dart';

import 'package:regtest_core/core.dart';

import 'toolbox_buttons/open_channel_button.dart';

class ChannelsCard extends StatefulWidget {
  final LnNode node;
  const ChannelsCard(this.node, {super.key});

  @override
  State<ChannelsCard> createState() => _ChannelsCardState();
}

class _ChannelsCardState extends State<ChannelsCard> {
  List<RegtestChannel> _channels = [];

  @override
  void initState() {
    super.initState();
    _listChannels();
  }

  Future<void> _listChannels() async {
    final c = await widget.node.fetchChannels();
    setState(() => _channels = c.toList());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.network_check_sharp),
                const SizedBox(width: 8.0),
                Text(
                  "Channels",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            OpenChannelButton(widget.node),
            const SizedBox(height: 8.0),
            for (final c in _channels)
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: PopupMenuButton(
                  itemBuilder: (context) => [
                    _buildMenuItem("Close", () => _closeChannel(c)),
                    _buildMenuItem("Drain", () => _drainChannel(c)),
                  ],
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Material(
                      elevation: 2,
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text(
                          "to ${c.to.id}",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  _openChannel() {
    debugPrint("Open channel for node ${widget.node.id}");
    return null;
  }

  _closeChannel(RegtestChannel c) {
    widget.node.closeChannel(c);
  }

  _drainChannel(RegtestChannel c) {}

  PopupMenuItem _buildMenuItem(String text, Function() param1) {
    return PopupMenuItem(
      onTap: param1,
      child: Text(text),
    );
  }
}
