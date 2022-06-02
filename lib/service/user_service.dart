import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:my_app/entity/user.dart';

import '../entity/chat.dart';

class UserService {
  List<User> _users = List.empty();
  List<Chat> _chats = List.empty();

  Future<void> loadData()  async {
    debugPrint('Loading data');

    String jsonData = await rootBundle.loadString('assets/data/users.json');
    var jsonUsers = jsonDecode(jsonData)['results'] as List;
    _users = jsonUsers.map((data) => User.fromJson(data)).toList();

    jsonData = await rootBundle.loadString('assets/data/chats.json');
    var objs = jsonDecode(jsonData)['results'] as List;
    _chats = objs.map((data) => Chat.fromJson(data)).toList();

    debugPrint('Complete loading data');
  }

  List<Chat> get chats => _chats;

  List<User> get users => _users;
}
