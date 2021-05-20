class DeviceInfo {
  String version;
  int setupStep;
  String baseImage;
  String cpu;
  bool isDocker;
  String state;
  String chain;
  String network;
  String message;
  String hostName;

  DeviceInfo({
    this.version,
    this.setupStep,
    this.baseImage,
    this.cpu,
    this.isDocker,
    this.state,
    this.chain,
    this.network,
    this.message,
    this.hostName,
  });

  DeviceInfo.fromJson(Map<String, dynamic> json) {
    version = json['version'];
    setupStep = json['setupStep'];
    baseImage = json['baseImage'];
    cpu = json['cpu'];
    isDocker = json['isDocker'];
    state = json['state'];
    chain = json['chain'];
    network = json['network'];
    message = json['message'];
    hostName = json['hostName'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['version'] = version;
    data['setupStep'] = setupStep;
    data['baseImage'] = baseImage;
    data['cpu'] = cpu;
    data['isDocker'] = isDocker;
    data['state'] = state;
    data['chain'] = chain;
    data['network'] = network;
    data['message'] = message;
    data['hostName'] = hostName;
    return data;
  }
}
