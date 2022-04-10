import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';

enum DlFile { pubKey, image, etcher }
enum DlFileStatus { queued, downloading, finished }

@immutable
class FileData extends Equatable {
  final DlFile id;
  final String path;
  final String url;
  final String fileName;

  final DlFileStatus status;
  final int downloadedMiB;
  final int totalMiB;
  final double percent;

  const FileData(
    this.id,
    this.path,
    this.url,
    this.fileName, [
    this.status = DlFileStatus.queued,
    this.downloadedMiB = 0,
    this.totalMiB = 0,
    this.percent = 0,
  ]);

  FileData copyWith({
    DlFileStatus? status,
    int? downloadedMiB,
    int? totalMiB,
    double? percent,
  }) {
    return FileData(
      id,
      path,
      url,
      fileName,
      status ?? this.status,
      downloadedMiB ?? this.downloadedMiB,
      totalMiB ?? this.totalMiB,
      percent ?? this.percent,
    );
  }

  @override
  List<Object?> get props =>
      [id, path, url, fileName, status, downloadedMiB, totalMiB, percent];
}
