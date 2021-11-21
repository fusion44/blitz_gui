class HealthMessages {
  final int id;
  final String level;
  final String message;

  HealthMessages(this.id, this.level, this.message);

  static HealthMessages fromJson(Map<String, dynamic> json) => HealthMessages(
        json['id'],
        json['level'],
        json['message'],
      );
}

class SystemInfo {
  final String alias;
  final String color;
  final String version;
  final String health;
  final List<HealthMessages> healthMessages;
  final String torWebUi;
  final String torApi;
  final String lanWebUi;
  final String lanApi;
  final String sshAddress;
  final String chain;

  SystemInfo(
    this.alias,
    this.color,
    this.version,
    this.health,
    this.healthMessages,
    this.torWebUi,
    this.torApi,
    this.lanWebUi,
    this.lanApi,
    this.sshAddress,
    this.chain,
  );

  static SystemInfo fromJson(Map<String, dynamic> json) {
    final messages = <HealthMessages>[];
    if (json['health_messages'] != null) {
      json['health_messages'].forEach((v) {
        messages.add(HealthMessages.fromJson(v));
      });
    }

    return SystemInfo(
      json['alias'],
      json['color'],
      json['version'],
      json['health'],
      messages,
      json['tor_web_ui'],
      json['tor_api'],
      json['lan_web_ui'],
      json['lan_api'],
      json['ssh_address'],
      json['chain'],
    );
  }
}
