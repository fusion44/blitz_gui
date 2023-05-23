// custom exception called DockerException
class DockerException implements Exception {
  final String message;

  DockerException(this.message);
}
