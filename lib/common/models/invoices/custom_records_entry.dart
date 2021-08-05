class CustomRecordsEntry {
  final int? key;

  final String? value;

  CustomRecordsEntry({
    this.key,
    this.value,
  });

  CustomRecordsEntry.fromJson(Map json)
      : key = json['key'],
        value = json['value'];
}
