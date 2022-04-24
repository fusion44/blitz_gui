class FeeRevenueData {
  final int day;
  final int week;
  final int month;
  final int? year;
  final int? total;

  const FeeRevenueData({
    this.day = 0,
    this.week = 0,
    this.month = 0,
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
