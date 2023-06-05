// custom exception called DockerException
import 'package:regtest_core/core.dart';

class DockerException implements Exception {
  final String message;

  DockerException(this.message);
}

class NodeNotRunningError implements Exception {
  final String message;

  NodeNotRunningError(this.message);

  factory NodeNotRunningError.fromContainerType(ContainerType t) =>
      NodeNotRunningError("No such node: $t");

  @override
  String toString() => message;
}
