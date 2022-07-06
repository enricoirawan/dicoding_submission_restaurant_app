import 'dart:convert';

class CustomerReview {
  final String name;
  final String review;
  final String date;

  CustomerReview({
    required this.name,
    required this.review,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'review': review,
      'date': date,
    };
  }

  factory CustomerReview.fromMap(Map<String, dynamic> map) {
    return CustomerReview(
      name: map['name'] ?? '',
      review: map['review'] ?? '',
      date: map['date'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerReview.fromJson(String source) =>
      CustomerReview.fromMap(json.decode(source));
}
