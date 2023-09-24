class FoodPreference {
  final String? id;
  final List cuisines;
  final bool isVegan;
  final String planOption;
  final List beverages;

  FoodPreference(
      {this.id,
      required this.cuisines,
      required this.isVegan,
      required this.planOption,
      required this.beverages});

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id.toString(),
        'cuisines': cuisines.map((e) => e.toString()).toList(),
        'isVegan': isVegan.toString(),
        'planOption': planOption.toString(),
        'beverages': beverages.map((e) => e.toString()).toList()
      };

  static FoodPreference fromJson(Map<dynamic, dynamic> json) => FoodPreference(
      id: json['id'].toString(),
      cuisines: (json['cuisines'] as List).toList(),
      isVegan: bool.parse(json['isVegan'].toString()),
      planOption: json['planOption'].toString(),
      beverages: (json['beverages'] as List).toList());
}
