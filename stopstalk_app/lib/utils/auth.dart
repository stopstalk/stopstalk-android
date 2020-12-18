import 'dart:convert';

import './storage.dart';
import './api.dart';
import '../classes/user.dart';

Future<User> getCurrentUser() async {
  var jwt = await getDataSecureStore("jwt");
  if (jwt == null) return null;
  final parts = jwt.split('.');
  if (parts.length != 3) {
    throw Exception('invalid token');
  }
  final payload = utf8.decode(base64Url.decode(base64.normalize(parts[1])));
  Map<String, dynamic> payloadMap = jsonDecode(payload);
  var user = userFromPayloapMap(payloadMap);
  getProfileFromHandle(user.stopstalkHandle);
  return user;
}

Future<bool> checkAuthUser() async {
  var jwt = await getDataSecureStore("jwt");
  if (jwt == null) return false;
  var userJwt = await resetToken(jwt);
  if (userJwt == null) return false;
  await writeDataSecureStore("jwt", userJwt);
  return true;
}

Future<bool> isAuthenticated() async {
  var jwt = await getDataSecureStore("jwt");
  if (jwt == null) return false;
  final parts = jwt.split('.');
  if (parts.length != 3) {
    throw Exception('invalid token');
  }
  return true;
}
