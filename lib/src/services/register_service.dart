import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

class RegisterService {
  Future signUp(String email, String password, String phoneNumber) async {
    try {
      Map<String, String> userAttributes = {
        'phone_number': phoneNumber,
      };
      SignUpResult res = await Amplify.Auth.signUp(
          username: email,
          password: password,
          options: CognitoSignUpOptions(userAttributes: userAttributes));

      return res.isSignUpComplete;
    } on AuthException catch (e) {
      return e.message;
    }
  }

  confirmSignUp(String email, String confirmationCode) async {
    try {
      SignUpResult res = await Amplify.Auth.confirmSignUp(
          username: email, confirmationCode: confirmationCode);

      if (res.isSignUpComplete == true) {
        return res.isSignUpComplete;
      } else
        return false;
    } on AuthException catch (e) {
      print(e.message);
    }
  }
}
