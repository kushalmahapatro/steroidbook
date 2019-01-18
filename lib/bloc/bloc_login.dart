import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:vod/sdk/Api.dart';
import 'package:vod/sdk/api/LoginUser.dart';
import 'package:vod/utils/Utils.dart';
import 'package:connectivity/connectivity.dart';

class BlocLogin extends Object {
  LoginData data;
  final PreferenceManager preferenceManager = PreferenceManager();

  //Extended Object cause we can't add Mixing without inheritance
  final _email = BehaviorSubject<LoginData>(); //Email StreamController
  final _password = BehaviorSubject<LoginData>(); //Password StreamController
  final _loginClick = BehaviorSubject<bool>(); //Password StreamController
  final _loginApi = BehaviorSubject<LoginData>(); //Password StreamController

  Stream<LoginData> get email => _email.stream;

  Stream<LoginData> get password => _password.stream;

  Stream<bool> get loginClick => _loginClick.stream;

  Stream<LoginData> get loginApi => _loginApi.stream;

  get changeEmail => _email.sink.add;

  get changePassword => _password.sink.add;

  get changeLoginClick => _loginClick.sink.add;

  get loginApiValue => _loginApi.sink.add;

  dispose()  async {
    await _email.drain();
    _email.close();

    await _password.drain();
    _password.close();

    await _loginApi.drain();
    _loginApi.close();

    await _loginClick.drain();
    _loginClick.close();
  }

  void callApi(String email, String password) async {
    _loginClick.add(true);
    _email.sink.add(LoginData(false, null, null));
    _password.sink.add(LoginData(false, null, null));
    validate(email, password);
  }

  void validate(String email, String password) {
    if (email.isEmpty) {
      data = LoginData(true, "Please enter email address", null);
      _email.add(data);
      _password.add(LoginData(true, null, null));
      _loginClick.add(false);
    } else if (password.isEmpty) {
      data = LoginData(true, "Please enter password", null);
      _password.add(data);
      _email.add(LoginData(true, null, null));
      _loginClick.add(false);
    } else {
      if (Utils.isValidMail(email)) {
        if (password.length >= 6) {
          apiCall(email, password);
        } else {
          data =
              LoginData(true, "The password should be minimum 6 digits", null);
          _password.add(data);
          _email.add(LoginData(true, null, null));
          _loginClick.add(false);
        }
      } else {
        data = LoginData(true, "Please enter valid email address", null);
        _email.add(data);
        _password.add(LoginData(true, null, null));
        _loginClick.add(false);
      }
    }
  }

  void apiCall(String email, String password) async {
    var connectivityResult = await (new Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a mobile network or wifi
      LoginModel loginUser = await loginUserApi({
        "authToken": AUTH_TOKEN,
        "countryCode": await preferenceManager.getCountryCodePrefs(),
        "email": email,
        "password": password,
        "device_id": "1",
        "lang_code": "",
        "google_id": "",
      });

      if (loginUser.code == 200) {
        data = LoginData(true, loginUser.msg, loginUser);
        _loginApi.add(data);
        _email.add(LoginData(true, null, null));
        _password.add(LoginData(true, null, null));
        _loginClick.add(false);
      } else {
        data = LoginData(false, loginUser.msg, null);
        _loginApi.add(data);
        _email.add(LoginData(true, null, null));
        _password.add(LoginData(true, null, null));
        _loginClick.add(false);
      }
    } else {
      data = LoginData(false, "No Internet Connection", null);
      _loginApi.add(data);
      _email.add(LoginData(true, null, null));
      _password.add(LoginData(true, null, null));
      _loginClick.add(false);
    }
  }
}

class LoginData {
  bool success;
  String message;
  LoginModel apiData;

  LoginData(this.success, this.message, this.apiData);
}

final blocLogin = BlocLogin(); //Single Global Instance
