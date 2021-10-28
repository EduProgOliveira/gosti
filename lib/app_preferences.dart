import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  AppPreferences();

  static loadPrefs(SharedPreferences prefs) async {
    prefs = await SharedPreferences.getInstance();
    token(prefs.getString('token') ?? '');
    id(prefs.getInt('id') ?? 0);
    email(prefs.getString('email') ?? '');
    password(prefs.getString('password') ?? '');
    phone(prefs.getString('phone') ?? '');
  }

  static clean() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static token(String token) async => await SharedPreferences.getInstance().then((prefs) => prefs.setString('token', token));
  static id(int id) async => await SharedPreferences.getInstance().then((prefs) => prefs.setInt('id', id));
  static email(String email) async => await SharedPreferences.getInstance().then((prefs) => prefs.setString('email', email));
  static password(String password) async => await SharedPreferences.getInstance().then((prefs) => prefs.setString('password', password));
  static phone(String phone) async => await SharedPreferences.getInstance().then((prefs) => prefs.setString('phone', phone));
  static keepConnected(bool keepConnected) async => await SharedPreferences.getInstance().then((prefs) => prefs.setBool('keepConnected', keepConnected));
  static validade(String validade) async => await SharedPreferences.getInstance().then((prefs) => prefs.setString('validade', validade));
  static mensagem(String mensagem) async => await SharedPreferences.getInstance().then((prefs) => prefs.setString('mensagem', mensagem));

  static Future<String> TOKEN() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token') ?? '';
    return token;
  }

  static Future<int> ID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = prefs.getInt('id') ?? 0;
    return id;
  }

  static Future<String> EMAIL() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email') ?? '';
    return email;
  }

  static Future<String> PASSWORD() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var password = prefs.getString('password') ?? '';
    return password;
  }

  static Future<String> PHONE() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var phone = prefs.getString('phone') ?? '';
    return phone;
  }

  static Future<bool> KEEP_CONNECTED() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool keepConnected = prefs.getBool('keepConnected') ?? false;
    return keepConnected;
  }

  static Future<String> VALIDADE() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var validade = prefs.getString('validade') ?? '';
    return validade;
  }

  static Future<String> MENSAGEM() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var mensagem = prefs.getString('mensagem') ?? '';
    return mensagem;
  }

}
