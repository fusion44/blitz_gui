class SetupStatus {
  final String setupPhase;
  final String state;
  final String message;
  final String initialsync;

  SetupStatus({
    required this.setupPhase,
    required this.state,
    required this.message,
    required this.initialsync,
  });

  factory SetupStatus.fromJson(Map<String, dynamic> json) => SetupStatus(
        setupPhase: json['setupPhase'] as String,
        state: json['state'] as String,
        message: json['message'] as String,
        initialsync: json['initialsync'] as String,
      );

  @override
  String toString() {
    return 'SetupStatus{setupPhase: $setupPhase, state: $state, message: $message, initialsync: $initialsync}';
  }
}
