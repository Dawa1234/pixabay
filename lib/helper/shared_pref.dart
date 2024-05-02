import 'package:pixabay/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late final SharedPreferences sharedPref;

  static init() async => sharedPref = await SharedPreferences.getInstance();

  static Future<bool> setFavImages(String value) async =>
      await sharedPref.setString(ConstantVariables.favortieIamges, value);

  static String getFavImages() =>
      sharedPref.getString(ConstantVariables.favortieIamges) ?? "";
}
