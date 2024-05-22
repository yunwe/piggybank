import 'package:equatable/equatable.dart';

/// {@template user}
/// User model
///
/// [User.empty] represents an unauthenticated user.
/// {@endtemplate}
class User extends Equatable {
  /// {@macro user}
  const User({
    required this.id,
    this.email,
    this.name,
    this.photo,
  });

  /// The current user's email address.
  final String? email;

  /// The current user's id.
  final String id;

  /// The current user's name (display name).
  final String? name;

  /// Url for the current user's photo.
  final String? photo;

  /// Empty user which represents an unauthenticated user.
  static const empty = User(id: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == User.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [email, id, name, photo];
}

// extension UserCacheing on User {
//   static User load(SharedPreferences cache) {
//     List<String>? values = cache.getStringList(Consts.user_cache_key);
//     if (values == null || values.length != 4) {
//       return User.empty;
//     }

//     return User(id: values[0], email: values[1], name: values[2], photo: values[3]);
//   }

//   void writeCache(SharedPreferences cache) {
//     if (isEmpty) {
//       cache.setStringList(Consts.user_cache_key, []);
//       return;
//     }

//     List<String> values = [id, email ?? '', name ?? '', photo ?? ''];
//     cache.setStringList(Consts.user_cache_key, values);
//   }
// }
