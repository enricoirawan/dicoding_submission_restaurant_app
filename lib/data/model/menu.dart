import 'dart:convert';
import 'package:submission_dicoding_app/data/model/dynamic_object.dart';

class Menu {
  final List<DynamicObject> foods;
  final List<DynamicObject> drinks;

  Menu({
    required this.foods,
    required this.drinks,
  });

  factory Menu.initial() {
    return Menu(
      foods: [],
      drinks: [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'foods': foods.map((x) => x.toMap()).toList(),
      'drinks': drinks.map((x) => x.toMap()).toList(),
    };
  }

  factory Menu.fromMap(Map<String, dynamic> map) {
    return Menu(
      foods: List<DynamicObject>.from(
          map['foods']?.map((x) => DynamicObject.fromMap(x))),
      drinks: List<DynamicObject>.from(
          map['drinks']?.map((x) => DynamicObject.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory Menu.fromJson(String source) => Menu.fromMap(json.decode(source));
}
