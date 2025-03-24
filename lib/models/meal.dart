import 'package:intl/intl.dart';

class Meal {
  final String id;
  final String name;
  final int calories;
  final DateTime time;
  final String? imageUrl;

  Meal({
    required this.id,
    required this.name,
    required this.calories,
    required this.time,
    this.imageUrl,
  });

  String get formattedTime => DateFormat('hh:mm a').format(time);


}