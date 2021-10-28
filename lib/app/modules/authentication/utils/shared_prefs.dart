import 'package:gosti_mobile/app/modules/authentication/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('id', user.id!);
    prefs.setString('name', user.name!);
    prefs.setString('email', user.email!);
    prefs.setString('codigo', user.codigo!);
    prefs.setBool('keepConnected', user.keepConnected!);
    prefs.setString('password', user.password!);
    prefs.setString('photo', user.photo!);
    prefs.setString('phone', user.phone!);
    prefs.setString('token', user.token!);

    return prefs.commit();
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? id = prefs.getString('id');
    String? name = prefs.getString('name');
    String? email = prefs.getString('email');
    String? codigo = prefs.getString('codigo');
    bool? keepConnected = prefs.getBool('keepConnected');
    String? password = prefs.getString('password');
    String? photo = prefs.getString('photo');
    String? phone = prefs.getString('phone');
    String? token = prefs.getString('token');

    return User(
      id: id,
      name: name,
      email: email,
      codigo: codigo,
      keepConnected: keepConnected,
      password: password,
      photo: photo,
      phone: phone,
      token: token,
    );
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('id');
    prefs.remove('name');
    prefs.remove('email');
    prefs.remove('codigo');
    prefs.remove('keepConnected');
    prefs.remove('password');
    prefs.remove('photo');
    prefs.remove('phone');
    prefs.remove('token');
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('token');
    if (token == null) {
      return '';
    }
    return '';
  }
}
