class SetupStatusResponse {
  String setupPhase;
  String state;
  String message;
  String initialsync;

  SetupStatusResponse({
    required this.setupPhase,
    required this.state,
    required this.message,
    required this.initialsync,
  });

  // fromJson function
  factory SetupStatusResponse.fromJson(Map<String, dynamic> json) {
    return SetupStatusResponse(
      setupPhase: json['setupPhase'],
      state: json['state'],
      message: json['message'],
      initialsync: json['initialsync'],
    );
  }
}
