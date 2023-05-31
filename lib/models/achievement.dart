import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

/// Auxiliary model to storage specific SpaceX's achievments.
class Achievement extends Equatable {
  final String id;
  final String name;
  final String details;
  final String url;
  final DateTime date;

  const Achievement({
    this.id,
    this.name,
    this.details,
    this.url,
    this.date,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      id: json['id'],
      name: json['title'],
      details: json['details'],
      // ignore: avoid_dynamic_calls
      url: json['links']['article'],
      date: DateTime.parse(json['event_date_utc']),
    );
  }

  String get getDate => DateFormat.yMMMMd().format(date);

  bool get hasLink => url != null;

  @override
  List<Object> get props => [
        id,
        name,
        details,
        url,
        date,
      ];
}
