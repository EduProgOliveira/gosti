import 'package:equatable/equatable.dart';

/// {@template user}
/// User model
///
/// [User.anonymous] represents an unauthenticated user.
/// {@endtemplate}
class User extends Equatable {
  /// {@macro user}
  const User({
    required this.id,
    this.email,
    this.name,
    this.photo,
    this.codigo,
    this.password,
    this.phone,
    this.token,
    this.keepConnected = false,
  });

  /// The users current phone
  final String? phone;

  /// The users current password
  final String? password;

  /// The users validation code
  final String? codigo;

  /// The current user's email address.
  final String? email;

  /// The current user's id.
  final String? id;

  /// The current user's name (display name).
  final String? name;

  /// Url for the current user's photo.
  final String? photo;

  final String? token;

  ///User session state
  final bool? keepConnected;

  /// Empty user which represents an unauthenticated user.
  static const empty = User(id: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == User.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != User.empty;

  /// Anonymous user which represents an unauthenticated user.
  static const anonymous = User(id: '');

  /// Convenience getter to determine whether the current user is anonymous.
  bool get isAnonymous => this == User.anonymous;

  /// Convenience getter to determine whether the current user is not anonymous.
  bool get isNotAnonymous => this != User.anonymous;

  @override
  List<Object?> get props => [email, id, name, photo, phone, token];

  /// user to map
  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'email': email,
        'name': name,
        'phone': phone,
        'token': token,
      };

  /// parse user data
  User.fromJson(Map<String, dynamic> json)
      : id = json['idCli'].toString(),
        name = json['name'].toString(),
        email = json['email'].toString(),
        codigo = json['codigo'].toString(),
        keepConnected = json['keepConnected'] = false,
        password = json['password'].toString(),
        photo = json['photo'].toString(),
        phone = json['phone'].toString(),
        token = json['token'].toString();
}
