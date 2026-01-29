import 'package:flutter/foundation.dart';
import '../models/user.dart';

class UserProvider with ChangeNotifier {
  User _user = User(
    name: "Sophy Moeurn",
    email: "sophy.moeurn@example.com",
    bio: "Tech enthusiast and avid gamer.",
    avatar: 'https://images.unsplash.com/photo-1599566150163-29194dcaad36?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
  );

  User get user => _user;

  void updateUser(String name, String bio, String avatar) {
    _user.name = name;
    _user.bio = bio;
    _user.avatar = avatar;
    notifyListeners();
  }

  void resetUser() {
    _user = User(
      name: "Sophy Moeurn",
      email: "sophy.moeurn@example.com",
      bio: "Tech enthusiast and avid gamer.",
      avatar: 'https://images.unsplash.com/photo-1599566150163-29194dcaad36?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
    );
    notifyListeners();
  }}