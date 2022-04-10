class InitialSetupInfo {
  final String setupPhase;
  final String migrationMode;
  final String hddGotMigrationData;
  final String hddGotBlockchain;
  final String sshLogin;
  final String torWebUi;

  InitialSetupInfo({
    required this.setupPhase,
    required this.migrationMode,
    required this.hddGotMigrationData,
    required this.hddGotBlockchain,
    required this.sshLogin,
    required this.torWebUi,
  });

  factory InitialSetupInfo.fromJson(Map<String, dynamic> json) =>
      InitialSetupInfo(
        setupPhase: json['setupPhase'] as String,
        migrationMode: json['migrationMode'] as String,
        hddGotMigrationData: json['hddGotMigrationData'] as String,
        hddGotBlockchain: json['hddGotBlockchain'] as String,
        sshLogin: json['ssh_login'] as String,
        torWebUi: json['tor_web_ui'] as String,
      );

  @override
  String toString() {
    return 'InitialSetupInfo{setupPhase: $setupPhase, migrationMode: $migrationMode, hddGotMigrationData: $hddGotMigrationData, hddGotBlockchain: $hddGotBlockchain, sshLogin: $sshLogin, torWebUi: $torWebUi}';
  }
}
