// custom exception called DockerException

import '../constants.dart';

class DockerException implements Exception {
  final String message;

  DockerException(this.message);

  factory DockerException.containerNotFound(String containerName) {
    return DockerException('No such container: $containerName');
  }
}

class BitcoinCoreNotReadyException implements Exception {
  final String message;
  final String original;

  BitcoinCoreNotReadyException(this.message, {this.original = ""});

  factory BitcoinCoreNotReadyException.isStartingUp() {
    return BitcoinCoreNotReadyException('BTCC: Starting up, try again later');
  }
  factory BitcoinCoreNotReadyException.walletError(String original) {
    return BitcoinCoreNotReadyException(
      'BTCC: Wallet error',
      original: original,
    );
  }
}

class NodeNotRunningError implements Exception {
  final String message;

  NodeNotRunningError(this.message);

  factory NodeNotRunningError.fromContainerType(ContainerType t) =>
      NodeNotRunningError("No such node: $t");

  @override
  String toString() => message;
}

class RequirementsNotMetError implements Exception {
  final ContainerType type;
  final String message;
  final List<ContainerType> unmetRequirements;

  RequirementsNotMetError(this.type, this.message, this.unmetRequirements);

  factory RequirementsNotMetError.fromContainerType(
    ContainerType type,
    List<ContainerType> unmetRequirements,
  ) =>
      RequirementsNotMetError(
        type,
        "$type requires $unmetRequirements container(s) to run",
        unmetRequirements,
      );

  @override
  String toString() => message;
}
