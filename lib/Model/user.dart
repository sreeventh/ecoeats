import 'foodpreference.dart';
import 'kitchenitem.dart';

class User {
  final String? id;
  final String userName;
  final String password;
  final String mailId;
  final String dob;
  final String location;
  final double height;
  final double weight;
  final double caloriesRequired;
  final List diseases;
  final List allergies;
  final List<KitchenItem> kitchenItems;
  final FoodPreference foodPreference;

  User(
      {this.id,
      required this.userName,
      required this.password,
      required this.mailId,
      required this.dob,
      required this.location,
      required this.height,
      required this.weight,
      required this.caloriesRequired,
      required this.allergies,
      required this.diseases,
      required this.foodPreference,
      required this.kitchenItems});

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'id': id.toString(),
        'userName': userName,
        'password': password,
        'mailId': mailId,
        'dob': dob,
        'location': location,
        'height': height.toString(),
        'weight': weight.toString(),
        'caloriesRequired': caloriesRequired.toString(),
        'allergies': allergies.map((e) => e.toString()).toList(),
        'diseases': diseases.map((e) => e.toString()).toList(),
        'foodPreference': foodPreference.toJson(),
        'kitchenItems': kitchenItems.map((e) => e.toJson()).toList()
      };
  static User fromJson(Map<dynamic, dynamic> json) => User(
      id: json['id'].toString(),
      userName: json['userName'].toString(),
      password: json['password'].toString(),
      mailId: json['mailId'].toString(),
      dob: json['dob'].toString(),
      location: json['location'].toString(),
      height: double.parse(json['height'].toString()),
      weight: double.parse(json['weight'].toString()),
      caloriesRequired: double.parse(json['caloriesRequired'].toString()),
      allergies: (json['allergies'] as List).toList(),
      diseases: (json['diseases'] as List).toList(),
      foodPreference: FoodPreference.fromJson(json['foodPreference']),
      kitchenItems: (json['kitchenItems'] as List)
          .map((e) => KitchenItem.fromJson(e))
          .toList());
}
