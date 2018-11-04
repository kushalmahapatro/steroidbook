import 'package:meta/meta.dart';
import 'package:vod/sdk/Api.dart';

class LoginController {
  final LoginListener listener;

  LoginController({@required this.listener});
}

abstract class LoginListener {
  void onFailure();

  void onLoginSuccess();
}