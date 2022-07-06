import 'dart:convert';
import 'package:submission_dicoding_app/data/model/customer_review.dart';
import 'package:submission_dicoding_app/data/model/dynamic_object.dart';
import 'package:submission_dicoding_app/data/model/menu.dart';

///NOTE: Disini saya menggunakan extension dari vscode yaitu "Dart Data Class Generator"

class RestaurantDetail {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final num rating;
  final Menu menus;
  final List<CustomerReview> customerReviews;
  final List<DynamicObject> categories;

  RestaurantDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
    required this.customerReviews,
    required this.categories,
  });

  factory RestaurantDetail.initial() {
    return RestaurantDetail(
      id: '',
      name: '',
      description: '',
      pictureId: '',
      city: '',
      rating: 0,
      menus: Menu.initial(),
      customerReviews: [],
      categories: [],
    );
  }

  Map<String, dynamic> toDBMap() {
    return {
      'id': id,
      'name': name,
      'pictureId': pictureId,
      'city': city,
      'rating': rating,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'pictureId': pictureId,
      'city': city,
      'rating': rating,
      'menus': menus.toMap(),
      'customerReviews': customerReviews.map((x) => x.toMap()).toList(),
      'categories': categories.map((x) => x.toMap()).toList(),
    };
  }

  factory RestaurantDetail.fromMap(Map<String, dynamic> map) {
    return RestaurantDetail(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      pictureId: map['pictureId'] ?? '',
      city: map['city'] ?? '',
      rating: map['rating'] ?? 0,
      menus: Menu.fromMap(map['menus']),
      customerReviews: List<CustomerReview>.from(
          map['customerReviews']?.map((x) => CustomerReview.fromMap(x))),
      categories: List<DynamicObject>.from(
          map['categories']?.map((x) => DynamicObject.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory RestaurantDetail.fromJson(String source) =>
      RestaurantDetail.fromMap(json.decode(source));
}
