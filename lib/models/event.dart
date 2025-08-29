class Event {
  final int? id;
  final String title;
  final String? description;
  final String date;
  final String time;
  final String location;
  final Map<String, dynamic>? organizer;
  final String? createdAt;

  Event({
    this.id,
    required this.title,
    this.description,
    required this.date,
    required this.time,
    required this.location,
    this.organizer,
    this.createdAt,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: json['date'],
      time: json['time'],
      location: json['location'],
      organizer: json['organizer'],
      createdAt: json['created_at']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'time': time,
      'location': location,
      // Do not send organizer or createdAt when creating event
    };
  }
}
