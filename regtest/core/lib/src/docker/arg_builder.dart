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

  List<String> build() => _args;

  String debugCommand() => 'docker ${_args.join(" ")}';
}
