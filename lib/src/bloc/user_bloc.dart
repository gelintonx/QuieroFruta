import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:quiero_fruta/src/device/save_user.dart';
import 'package:quiero_fruta/src/models/User.dart';
import 'package:quiero_fruta/src/services/complete_user_service.dart';
import '../utils/parse_jwt.dart';
import 'package:flutter/material.dart';

class UserBloc extends ChangeNotifier {
  get phoneNumber async {
    final fetchSession = await Amplify.Auth.fetchAuthSession(
            options: CognitoSessionOptions(getAWSCredentials: true))
        as CognitoAuthSession;

    final parsed = parseJwt(fetchSession.userPoolTokens.idToken);
    final phoneNumber = await parsed['phone_number'] as String;
    notifyListeners();
    return phoneNumber;
  }

  addUser(Map<String, dynamic> userMap) async {
    final name = userMap['name'];
    final surname = userMap['surname'];
    final phone = '999147055'; //await phoneNumber;
    final ruc = userMap['ruc'];

    final user =
        User(nombres: name, apellidos: surname, telefono: phone, ruc: ruc);

    final userService = UserService();
    final response = await userService.createUser(user);
    final save = SaveUser();

    save.saveName(name);
    if (response != null) {
      save.saveCostumerId(response);
    } else {
      print('Error saving costumerID');
    }
  }
}
