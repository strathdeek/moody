import 'package:hive/hive.dart';
import 'package:moody/data/constants/hive.dart';
import 'package:moody/data/exceptions.dart';
import 'package:moody/data/models/user.dart';

class UserProvider {
  final Box<User> _userBox = Hive.box<User>(UserBoxKey);

  void add(User user) {
    _userBox.put(UserKey, user);
  }

  void update(User user) {
    _userBox.put(UserKey, user);
  }

  void delete(User user) {
    _userBox.delete(UserKey);
  }

  User get() {
    var user = _userBox.get(UserKey);
    if (user == null) {
      throw RepositoryException('Unable to retrieve user');
    }
    return user;
  }
}
