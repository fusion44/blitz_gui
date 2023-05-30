class DockerArgBuilder {
  final List<String> _args = [];

  DockerArgBuilder addArg(String arg) {
    _args.add(arg);

    return this;
  }

  DockerArgBuilder addOption(String option, [dynamic value]) {
    _args.add(option);
    if (value != null) _args.add(value.toString());

    return this;
  }

  /// Prepends '--environment' to the given value
  DockerArgBuilder addEnv(String val) => addOption('--environment', val);

  List<String> build() => _args;

  String debugCommand() => 'docker ${_args.join(" ")}';
}
