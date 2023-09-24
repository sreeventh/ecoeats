import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecoeats/Model/foodpreference.dart';
import 'package:ecoeats/Model/kitchenitem.dart';
import 'package:ecoeats/Model/user.dart';

final FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;

final CollectionReference _userReference =
    _firebaseFireStore.collection('Users');
final CollectionReference _kitchenInventoryRef =
    _firebaseFireStore.collection('Kitchen Inventory');
final CollectionReference _foodPreferenceRef =
    _firebaseFireStore.collection('Food Preference');

class FireBaseHelper {
  // CRUD operations for Users
  static Future insertUser(User user) async {
    String id = _userReference.doc().id;
    try {
      await _userReference.doc(id).set(<String, dynamic>{
        'id': id,
        'userName': user.userName,
        'password': user.password,
        'mailId': user.mailId,
        'dob': user.dob,
        'location': user.location,
        'height': user.height.toString(),
        'weight': user.weight.toString(),
        'caloriesRequired': user.caloriesRequired.toString(),
        'allergies': user.allergies.map((e) => e.toString()).toList(),
        'diseases': user.diseases.map((e) => e.toString()).toList(),
        'foodPreference': user.foodPreference.toJson(),
        'kitchenItems': user.kitchenItems.map((e) => e.toJson()).toList(),
      });
      return id;
    } catch (e) {
      throw (e.toString());
    }
  }

  static Future updateUser(User user) async {
    try {
      await _userReference.doc(user.id).update({
        'id': user.id.toString(),
        'userName': user.userName,
        'password': user.password,
        'mailId': user.mailId,
        'dob': user.dob,
        'location': user.location,
        'height': user.height.toString(),
        'weight': user.weight.toString(),
        'caloriesRequired': user.caloriesRequired.toString(),
        'allergies': user.allergies.map((e) => e.toString()).toList(),
        'diseases': user.diseases.map((e) => e.toString()).toList(),
        'foodPreference': user.foodPreference.toJson(),
        'kitchenItems': user.kitchenItems.map((e) => e.toJson()).toList()
      });
    } catch (e) {
      throw (e.toString());
    }
  }

  static Future<User?> readUser(String id) async {
    try {
      var doc = _userReference.doc(id).get();
      var user = doc.then((value) {
        if (value.data() != null) {
          return User.fromJson(value.data() as Map<String, dynamic>);
        } else {
          return null;
        }
      });
      return user;
    } catch (e) {
      throw (e.toString());
    }
  }

  static Future deleteUser(String id) async {
    try {
      await _userReference.doc(id).delete();
    } catch (e) {
      throw (e.toString());
    }
  }

  // CRUD operations for FoodPreference
  static Future insertFoodPreference(FoodPreference fp) async {
    String id = _foodPreferenceRef.doc().id;
    try {
      await _foodPreferenceRef.doc(id).set({
        'id': id,
        'cuisines': fp.cuisines.map((e) => e.toString()).toList(),
        'isVegan': fp.isVegan.toString(),
        'planOption': fp.planOption.toString(),
        'beverages': fp.beverages.map((e) => e.toString()).toList()
      });
      return id;
    } catch (e) {
      throw (e.toString());
    }
  }

  static Future updateFoodPreference(FoodPreference fp) async {
    try {
      await _foodPreferenceRef.doc(fp.id).update({
        'id': fp.id.toString(),
        'cuisines': fp.cuisines.map((e) => e.toString()).toList(),
        'isVegan': fp.isVegan.toString(),
        'planOption': fp.planOption.toString(),
        'beverages': fp.beverages.map((e) => e.toString()).toList()
      });
    } catch (e) {
      throw (e.toString());
    }
  }

  static Future deleteFoodPreference(String id) async {
    try {
      await _foodPreferenceRef.doc(id).delete();
    } catch (e) {
      throw (e.toString());
    }
  }

  static Future<FoodPreference?> readFoodPreference(String id) async {
    try {
      var doc = _foodPreferenceRef.doc(id).get();
      var fp = doc.then((value) {
        if (value.data() != null) {
          return FoodPreference.fromJson(value.data() as Map<String, dynamic>);
        } else {
          return null;
        }
      });
      return fp;
    } catch (e) {
      throw (e.toString());
    }
  }

  // CRUD operations for KitchenInventory
  static Future insertKitchenItem(KitchenItem ki) async {
    String id = _foodPreferenceRef.doc().id;
    try {
      await _kitchenInventoryRef.doc(id).set({
        'id': id,
        'name': ki.name.toString(),
        'isOrganic': ki.isOrganic.toString(),
        'expiryDate': ki.expiryDate.toString(),
        //'inputDate': ki.isOrganic ? ki.inputDate.toString() : '',
      });
      return id;
    } catch (e) {
      throw (e.toString());
    }
  }

  static Future updateKitchenItem(KitchenItem ki) async {
    try {
      await _kitchenInventoryRef.doc(ki.id).update({
        'id': ki.id.toString(),
        'name': ki.name.toString(),
        'isOrganic': ki.isOrganic.toString(),
        'expiryDate': ki.expiryDate.toString(),
        //'inputDate': ki.isOrganic ? ki.inputDate.toString() : ''
      });
    } catch (e) {
      throw (e.toString());
    }
  }

  static Future deleteKitchenItem(String id) async {
    try {
      await _kitchenInventoryRef.doc(id).delete();
    } catch (e) {
      throw (e.toString());
    }
  }

  static Future<KitchenItem?> readKitchenItem(String id) async {
    try {
      var doc = _kitchenInventoryRef.doc(id).get();
      var ki = doc.then((value) {
        if (value.data() != null) {
          return KitchenItem.fromJson(value.data() as Map<String, dynamic>);
        } else {
          return null;
        }
      });
      return ki;
    } catch (e) {
      throw (e.toString());
    }
  }
}
