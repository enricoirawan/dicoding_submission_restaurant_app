import 'dart:convert';

import 'package:equatable/equatable.dart';

///NOTE: Disini saya menggunakan extension dari vscode yaitu "Dart Data Class Generator"

class Restaurant extends Equatable {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final num rating;

  const Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'pictureId': pictureId,
      'city': city,
      'rating': rating,
    };
  }

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      pictureId: map['pictureId'] ?? '',
      city: map['city'] ?? '',
      rating: map['rating'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Restaurant.fromJson(String source) =>
      Restaurant.fromMap(json.decode(source));

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        pictureId,
        city,
        rating,
      ];
}
