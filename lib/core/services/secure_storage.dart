import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  // final String token = "token";
  final String userName = "name";
  final String userId = "nameId";
  final String userData = "userData";
  final String coachName = "name";
  final String coachId = "coachId";
  final String coachData = "coachData";

  Future<void> _write(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future<String?> _read(String key) async {
    return await _secureStorage.read(key: key);
  }

  Future<bool> containsKey(String key) async {
    final value = await _secureStorage.read(key: key);
    return value != null;
  }

  // Future<void> addUserToken(String value) async {
  //   return await _write(token, value);
  // }

  Future<void> addUserData(String value) async {
    return await _write(userData, value);
  }

  Future<void> addCoachData(String value) async {
    return await _write(coachData, value);
  }

  Future<void> deleteUserData(String key) async {
    await _secureStorage.delete(key: key); // "userData"
  }

  Future<void> deleteCoachData(String key) async {
    await _secureStorage.delete(key: key); // "userData"
  }

  // Future<String?> getUserToken() async {
  //   return await _read(token);
  // }

  Future<String?> getUserData() async {
    return await _read(userData);
  }

  Future<String?> getCoachData() async {
    return await _read(coachData);
  }

  Future<void> addUserName(String value) async {
    return await _write(userName, value);
  }

  Future<void> addUserId(String value) async {
    return await _write(userId, value);
  }

  Future<String?> getUserId() async {
    return await _read(userId);
  }

  Future<String?> getUserName() async {
    return await _read(userName);
  }

  // Future<bool> containsTokenKey() async {
  //   final value = await _secureStorage.read(key: token);
  //   return value != null;
  // }

  // Future<void> deleteUserToken() async {
  //   await _secureStorage.delete(key: token);
  // }

  Future<void> deleteUserName() async {
    await _secureStorage.delete(key: userName);
  }
}
