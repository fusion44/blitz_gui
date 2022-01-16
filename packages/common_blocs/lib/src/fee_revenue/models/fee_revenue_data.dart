class FeeRevenueData {
  final int day;
  final int week;
  final int month;
  final int? year;
  final int? total;

  FeeRevenueData({
    required this.day,
    required this.week,
    required this.month,
    this.year,
    this.total,
  });

  FeeRevenueData.fromJson(Map<String, dynamic> json)
      : day = json['day'],
        week = json['week'],
        month = json['month'],
        year = json['year'],
        total = json['total'];
}
