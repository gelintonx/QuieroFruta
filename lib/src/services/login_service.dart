import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

class LoginService {
  Future signIn(String email, String password) async {
    await Amplify.Auth.signOut();
    try {
      final res =
          await Amplify.Auth.signIn(username: email, password: password);

      return res.isSignedIn;
    } on AuthException catch (e) {
      return e.message;
    }
  }

  confirmSignIn(String confirmationCode) async {
    try {
      SignInResult res =
          await Amplify.Auth.confirmSignIn(confirmationValue: confirmationCode);

      if (res.isSignedIn == true) {
        return res.isSignedIn;
      } else
        return false;
    } on AuthException catch (e) {
      print(e.message);
    }
  }

  Future<bool> checkLoggedIn() async {
    //final session = await Amplify.Auth.fetchAuthSession();
    final x = await Amplify.Auth.getCurrentUser();
    print(x.userId);
    return true;
  }
}
