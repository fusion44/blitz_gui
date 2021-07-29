import 'package:blitz_gui/common/utils.dart';

class SystemInfo {
  final double? cpuOverallPercent;
  final List<double> cpuPerCpuPercent;
  final int? vramTotalBytes;
  final int? vramAvailableBytes;
  final int? vramUsedBytes;
  final double? vramUsagePercent;
  final int? swapRamTotalBytes;
  final int? swapUsedBytes;
  final double? swapUsageBytes;
  final List<Temperature> temperaturesCelsius;
  final int? bootTimeTimestamp;
  final int? diskIoReadCount;
  final int? diskIoWriteCount;
  final int? diskIoReadBytes;
  final int? diskIoWriteBytes;
  final List<Network> networks;
  final int? networksBytesSent;
  final int? networksBytesReceived;

  SystemInfo({
    this.cpuOverallPercent,
    this.cpuPerCpuPercent = const [],
    this.vramTotalBytes,
    this.vramAvailableBytes,
    this.vramUsedBytes,
    this.vramUsagePercent,
    this.swapRamTotalBytes,
    this.swapUsedBytes,
    this.swapUsageBytes,
    this.temperaturesCelsius = const [],
    this.bootTimeTimestamp,
    this.diskIoReadCount,
    this.diskIoWriteCount,
    this.diskIoReadBytes,
    this.diskIoWriteBytes,
    this.networks = const [],
    this.networksBytesSent,
    this.networksBytesReceived,
  });

  static SystemInfo fromJson(Map<String, dynamic> json) {
    final temps = <Temperature>[];
    if (json['temperatures_celsius'] != null) {
      final v = json['temperatures_celsius'];
      if (v is Map && v.containsKey('coretemp')) {
        v['coretemp'].forEach((v) {
          temps.add(Temperature.fromJson(v));
        });
      }
    }
    final networks = <Network>[];
    if (json['networks'] != null) {
      json['networks'].forEach((v) {
        networks.add(Network.fromJson(v));
      });
    }
    return SystemInfo(
      cpuOverallPercent: json['cpu_overall_percent'],
      cpuPerCpuPercent: json['cpu_per_cpu_percent'].cast<double>(),
      vramTotalBytes: json['vram_total_bytes'],
      vramAvailableBytes: json['vram_available_bytes'],
      vramUsedBytes: json['vram_used_bytes'],
      vramUsagePercent: json['vram_usage_percent'],
      swapRamTotalBytes: json['swap_ram_total_bytes'],
      swapUsedBytes: json['swap_used_bytes'],
      swapUsageBytes: json['swap_usage_bytes'],
      temperaturesCelsius: temps,
      bootTimeTimestamp: forceInt(json['boot_time_timestamp']),
      diskIoReadCount: json['disk_io_read_count'],
      diskIoWriteCount: json['disk_io_write_count'],
      diskIoReadBytes: json['disk_io_read_bytes'],
      diskIoWriteBytes: json['disk_io_write_bytes'],
      networks: networks,
      networksBytesSent: json['networks_bytes_sent'],
      networksBytesReceived: json['networks_bytes_received'],
    );
  }
}

class Temperature {
  final String name;
  final double currentTemp;
  final double warnTemp;
  final double maxTemp;

  Temperature(this.name, this.currentTemp, this.warnTemp, this.maxTemp);

  static Temperature fromJson(List values) =>
      Temperature(values[0], values[1], values[2], values[3]);
}

class Network {
  final String? interfaceName;
  final String? address;
  final String? macAddress;

  Network({this.interfaceName, this.address, this.macAddress});

  static Network fromJson(Map<String, dynamic> json) => Network(
        interfaceName: json['interface_name'],
        address: json['address'],
        macAddress: json['mac_address'],
      );
}
