class KitchenItem {
  final String? id;
  final String name;
  final bool isOrganic;
  final String expiryDate;
  final String? inputDate;

  KitchenItem(
      {this.id,
      required this.name,
      required this.isOrganic,
      required this.expiryDate,
      this.inputDate});

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id.toString(),
        'name': name.toString(),
        'isOrganic': isOrganic.toString(),
        'expiryDate': expiryDate.toString(),
        'inputDate': isOrganic ? inputDate.toString() : '',
      };

  static KitchenItem fromJson(Map<String, dynamic> json) => KitchenItem(
      id: json['id'].toString(),
      name: json['name'].toString(),
      isOrganic: bool.parse(json['isOrgnaic'].toString()),
      expiryDate: json['expiryDate'].toString(),
      inputDate: bool.parse(json['isOrgnaic'].toString())
          ? json['inputDate'].toString()
          : null);
}
