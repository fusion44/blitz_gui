import 'package:common/common.dart';

class HardwareInfo {
  final double cpuOverallPercent;
  final List<double> cpuPerCpuPercent;
  final int vramTotalBytes;
  final int vramAvailableBytes;
  final int vramUsedBytes;
  final double vramUsagePercent;
  final int swapRamTotalBytes;
  final int swapUsedBytes;
  final int swapUsageBytes;
  final List<Temperature> temperaturesCelsius;
  final int bootTimeTimestamp;
  final int diskIoReadCount;
  final int diskIoWriteCount;
  final int diskIoReadBytes;
  final int diskIoWriteBytes;
  final List<Disk> disks;
  final List<Network> networks;
  final int networksBytesSent;
  final int networksBytesReceived;

  HardwareInfo({
    required this.cpuOverallPercent,
    this.cpuPerCpuPercent = const [],
    required this.vramTotalBytes,
    required this.vramAvailableBytes,
    required this.vramUsedBytes,
    required this.vramUsagePercent,
    required this.swapRamTotalBytes,
    required this.swapUsedBytes,
    required this.swapUsageBytes,
    this.temperaturesCelsius = const [],
    required this.bootTimeTimestamp,
    required this.diskIoReadCount,
    required this.diskIoWriteCount,
    required this.diskIoReadBytes,
    required this.diskIoWriteBytes,
    this.disks = const [],
    this.networks = const [],
    required this.networksBytesSent,
    required this.networksBytesReceived,
  });

  static HardwareInfo fromJson(Map<String, dynamic> json) {
    final temps = <Temperature>[];
    if (json['temperatures_celsius'] != null) {
      final v = json['temperatures_celsius'];
      if (v is Map && v.containsKey('coretemp')) {
        v['coretemp'].forEach((v) {
          temps.add(Temperature.fromJson(v));
        });
      }
    }

    final disks = <Disk>[];
    if (json['disks'] != null) {
      json['disks'].forEach((d) {
        disks.add(Disk.fromJson(d));
      });
    }

    final networks = <Network>[];
    if (json['networks'] != null) {
      json['networks'].forEach((v) {
        networks.add(Network.fromJson(v));
      });
    }

    return HardwareInfo(
      cpuOverallPercent: forceDouble(json['cpu_overall_percent']),
      cpuPerCpuPercent: json['cpu_per_cpu_percent'].cast<double>(),
      vramTotalBytes: forceInt(json['vram_total_bytes']),
      vramAvailableBytes: forceInt(json['vram_available_bytes']),
      vramUsedBytes: forceInt(json['vram_used_bytes']),
      vramUsagePercent: forceDouble(json['vram_usage_percent']),
      swapRamTotalBytes: forceInt(json['swap_ram_total_bytes']),
      swapUsedBytes: forceInt(json['swap_used_bytes']),
      swapUsageBytes: forceInt(json['swap_usage_bytes']),
      temperaturesCelsius: temps,
      bootTimeTimestamp: forceInt(json['boot_time_timestamp']),
      diskIoReadCount: forceInt(json['disk_io_read_count']),
      diskIoWriteCount: forceInt(json['disk_io_write_count']),
      diskIoReadBytes: forceInt(json['disk_io_read_bytes']),
      diskIoWriteBytes: forceInt(json['disk_io_write_bytes']),
      disks: disks,
      networks: networks,
      networksBytesSent: forceInt(json['networks_bytes_sent']),
      networksBytesReceived: forceInt(json['networks_bytes_received']),
    );
  }
}

class Temperature {
  final String name;
  final double currentTemp;
  final double warnTemp;
  final double maxTemp;

  Temperature(this.name, this.currentTemp, this.warnTemp, this.maxTemp);

  static Temperature fromJson(List values) => Temperature(
        forceString(values.first),
        forceDouble(values[1]),
        forceDouble(values[2]),
        forceDouble(values[3]),
      );
}

class Disk {
  final String device;
  final String mountpoint;
  final String filesystemType;
  final int partitionTotalBytes;
  final int partitionUsedBytes;
  final int partitionFreeBytes;
  final double partitionPercent;

  Disk({
    required this.device,
    required this.mountpoint,
    required this.filesystemType,
    required this.partitionTotalBytes,
    required this.partitionUsedBytes,
    required this.partitionFreeBytes,
    required this.partitionPercent,
  });

  static Disk fromJson(Map<String, dynamic> json) => Disk(
        device: forceString(json['device']),
        mountpoint: forceString(json['mountpoint']),
        filesystemType: forceString(json['filesystem_type']),
        partitionTotalBytes: forceInt(json['partition_total_bytes']),
        partitionUsedBytes: forceInt(json['partition_used_bytes']),
        partitionFreeBytes: forceInt(json['partition_free_bytes']),
        partitionPercent: forceDouble(json['partition_percent']),
      );
}

class Network {
  final String interfaceName;
  final String address;
  final String macAddress;

  Network({
    required this.interfaceName,
    required this.address,
    required this.macAddress,
  });

  static Network fromJson(Map<String, dynamic> json) => Network(
        interfaceName: forceString(json['interface_name']),
        address: forceString(json['address']),
        macAddress: forceString(json['mac_address']),
      );
}
