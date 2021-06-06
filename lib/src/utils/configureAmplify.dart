import 'package:amplify_flutter/amplify.dart';
import '../../amplifyconfiguration.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

void configureAmplify() async {
  final amplifyAuth = AmplifyAuthCognito();
  Amplify.addPlugin(amplifyAuth);

  try {
    await Amplify.configure(amplifyconfig);
  } on AmplifyAlreadyConfiguredException {
    print('Amplify was already configured. Was the app restarted?');
  }
}
