import 'package:hive/hive.dart';

part 'users_model.g.dart';

@HiveType(typeId: 0)
class UsersModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String address;

  @HiveField(3)
  final String placeOfBirth;

  UsersModel({
    required this.id,
    required this.name,
    required this.address,
    required this.placeOfBirth,
  });

  // Create a copy with updated fields
  UsersModel copyWith({String? name, String? address, String? placeOfBirth}) {
    return UsersModel(
      id: id,
      name: name ?? this.name,
      address: address ?? this.address,
      placeOfBirth: placeOfBirth ?? this.placeOfBirth,
    );
  }

  // Convert JSON map to UsersModel
  factory UsersModel.fromJson(Map<String, dynamic> json) {
    return UsersModel(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      placeOfBirth: json['placeOfBirth'] ?? '',
    );
  }

  // Convert UsersModel to JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'placeOfBirth': placeOfBirth,
    };
  }
}
