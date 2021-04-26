import 'package:moody/data/models/user.dart';
import 'package:moody/data/providers/user_provider.dart';

class UserRepository {
  final UserProvider _userProvider;

  UserRepository(this._userProvider);

  User get() {
    return _userProvider.get();
  }

  void add(User user) {
    _userProvider.add(user);
  }

  void update(User user) {
    _userProvider.update(user);
  }

  void delete(User user) {
    _userProvider.delete(user);
  }
}
