import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gosti_mobile/app/core/errors/failures.dart';
import 'package:gosti_mobile/app/modules/authentication/models/user.dart';
import 'package:gosti_mobile/app/modules/authentication/utils/shared_prefs.dart';
import 'package:gosti_mobile/app_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

const GOSTI_URL = 'http://gostiws.gesct.com.br:14335';

enum Authentication { success, failure, forgot_password }

class AuthenticationRepository {
  Dio dio = Dio();

  AuthenticationRepository();

  Future<bool> register({
    String? email,
    String? phone,
    required String password,
    bool keepConnected = false,
    bool enableFirebase = true,
  }) async {
    try {
      Response response = await dio.post<dynamic>(
        '$GOSTI_URL/cliaut/registre',
        data: {
          'email': email!,
          'telefone': phone!,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.data);
        User user = User.fromJson(responseData);
        UserPreferences().saveUser(user);
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> signUp({
    String? email,
    String? phone,
    required String password,
  }) async {
    try {
      final Response response = await dio.post<dynamic>(
        '$GOSTI_URL/cliaut/registre',
        data: {
          'email': email!,
          'telefone': phone!,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      print(e.response!.data['mensagem']);
      print(e.message);
      throw SignUpFailure();
      return false;
    }
  }

  /*late final FirebaseAuth _authFire;
  late final FacebookAuth _authFace;

  late GoogleSignInAccount? _currentUser;
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );

  AuthenticationRepository() {
    SharedPreferences.getInstance().then((value) {
      prefs = value;
    });
    _authFire = FirebaseAuth.instance;
    _authFace = FacebookAuth.instance;
  }*/

  Future<bool> verify() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool token = prefs.getBool('keepConnected')!;
    if (token) {
      var password = prefs.getString('password');
      var phone = prefs.getString('phone');
      var email = prefs.getString('email');

      bool val = await logInWithEmailOrPhoneAndPassword(
          password: password!, email: email, phone: phone, keepConnected: true);
      if (val) {
        return true;
      }
      return false;
    }
    return false;
  }

  Future<bool> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('keepConnected');
    prefs.remove('password');
    prefs.remove('phone');
    prefs.remove('email');

    return true;
  }

  static Future<String> reLogin(
      {String? email, String? phone, required String password}) async {
    Dio _dio = Dio();
    DateTime dateTime = DateTime.now();
    String? newToken;
    try {
      final response = await _dio.post<Map<dynamic, dynamic>>(
        '$GOSTI_URL/cliaut/login',
        data: {
          'email': email,
          'telefone': phone,
          'password': password,
        },
      );

      await Future.delayed(const Duration(seconds: 1), () async {
        if (response.statusCode == 200) {
          AppPreferences.token(response.data!['data']['token']);
          AppPreferences.id(response.data!['data']['idCli']);
          AppPreferences.mensagem(response.data!['mensagem']);
          AppPreferences.validade(dateTime.toString());
          AppPreferences.email(email!);
          AppPreferences.password(password);
          AppPreferences.phone(phone!);
          AppPreferences.keepConnected(true);
          newToken = response.data!['data']['token'];
        }
      });
      return newToken!;
    } on DioError catch (e) {
      throw LogInWithEmailAndPasswordFailure();
    }
  }

  Future<bool> logInWithEmailOrPhoneAndPassword({
    String? email,
    String? phone,
    required String password,
    bool keepConnected = false,
    bool enableFirebase = true,
  }) async {
    DateTime dateTime = DateTime.now();
    try {
      final response = await dio.post<Map<dynamic, dynamic>>(
        '$GOSTI_URL/cliaut/login',
        data: {
          'email': email,
          'telefone': phone != null && phone.length > 3 ? phone : '',
          'password': password,
        },
      );

      await Future.delayed(const Duration(seconds: 1), () async {
        if (response.statusCode == 200) {
          AppPreferences.token(response.data!['data']['token']);
          AppPreferences.id(response.data!['data']['idCli']);
          AppPreferences.validade(dateTime.toString());
          AppPreferences.email(email!);
          AppPreferences.password(password);
          AppPreferences.phone(phone!);
          AppPreferences.keepConnected(keepConnected);
          return true;
        }
      });
      return true;
    } on DioError catch (e) {
      throw LogInWithEmailAndPasswordFailure();
    }
  }

  Future<void> forgotPassword({
    required String email,
    required String phone,
  }) async {
    try {
      await dio.post<dynamic>(
        '$GOSTI_URL/cliaut/esqueci',
        data: {
          'email': email,
          'telefone': phone,
        },
      );
    } on Exception {
      throw SignUpFailure();
    }
  }

  Future<void> setPassword({
    required String email,
    required String password,
    required String phone,
    required String code,
  }) async {
    try {
      await dio.post<dynamic>(
        '$GOSTI_URL/cliaut/novasenha',
        data: {
          'email': email,
          'password': password,
          'telefone': phone,
          'codigo': code,
        },
      );
    } on Exception {
      throw SignUpFailure();
    }
  }

  Future<void> verifyCodeAndSetPassword({
    required String email,
    required String password,
    required String phone,
    required String code,
  }) async {
    try {
      await dio.post<dynamic>(
        '$GOSTI_URL/cliaut/validacodigo',
        data: {
          'email': email,
          'telefone': phone,
          'codigo': code,
        },
      );

      await setPassword(
        code: code,
        email: email,
        password: password,
        phone: phone,
      );
    } on Exception {
      throw SignUpFailure();
    }
  }

  Future verifyCode({
    required String email,
    required String phone,
    required String code,
  }) async {
    try {
      await dio.post<dynamic>(
        '$GOSTI_URL/cliaut/validacodigo',
        data: {
          'email': email,
          'telefone': phone,
          'codigo': code,
        },
      );
      return;
    } on DioError catch (e) {
      print(e.response!.data['mensagem']);
      throw SignUpFailure();
    }
  }
}
