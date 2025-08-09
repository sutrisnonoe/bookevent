class Event {
  final int id;
  final String title;
  final String description;
  final String startDate;
  final String endDate;
  final String location;
  final int maxAttendees;
  final int price;
  final String category;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.maxAttendees,
    required this.price,
    required this.category,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'] ?? '',
      location: json['location'] ?? '',
      maxAttendees: json['max_attendees'] ?? 0,
      price: json['price'] ?? 0,
      category: json['category'] ?? '',
    );
  }

  String get formattedDateRange {
    try {
      final start = DateTime.parse(startDate);
      final end = DateTime.parse(endDate);
      final startStr =
          "${start.day.toString().padLeft(2, '0')}-${start.month.toString().padLeft(2, '0')}-${start.year}";
      final endStr =
          "${end.day.toString().padLeft(2, '0')}-${end.month.toString().padLeft(2, '0')}-${end.year}";
      return "$startStr sampai $endStr";
    } catch (_) {
      return "$startDate sampai $endDate";
    }
  }

  String get formattedTimeRange {
    try {
      final start = DateTime.parse(startDate);
      final end = DateTime.parse(endDate);
      final startTime =
          "${start.hour.toString().padLeft(2, '0')}:${start.minute.toString().padLeft(2, '0')}";
      final endTime =
          "${end.hour.toString().padLeft(2, '0')}:${end.minute.toString().padLeft(2, '0')}";
      return "$startTime - $endTime";
    } catch (_) {
      return "-";
    }
  }
}
