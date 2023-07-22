class DockerArgBuilder {
  final List<String> _args = [];

  DockerArgBuilder addArg(String arg, {bool omit = false}) {
    if (!omit) _args.add(arg);

    return this;
  }

  DockerArgBuilder addOption(
    String option,
    dynamic value, {
    bool omit = false,
  }) {
    if (omit) return this;

    _args.add(option);
    _args.add(value.toString());

    return this;
  }

  /// Prepends '--environment' to the given value
  DockerArgBuilder addEnv(String val) => addOption('-e', val);

  List<String> build() => _args;

  String debugCommand() => 'docker ${_args.join(" ")}';
}
