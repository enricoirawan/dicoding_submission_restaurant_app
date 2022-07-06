import 'dart:convert';

class DynamicObject {
  final String name;

  DynamicObject({
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  factory DynamicObject.fromMap(Map<String, dynamic> map) {
    return DynamicObject(
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DynamicObject.fromJson(String source) =>
      DynamicObject.fromMap(json.decode(source));
}
