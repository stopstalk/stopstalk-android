import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> getURL(String url, Map<String, String> parameters) async {
  var server = DotEnv().env['SERVER'];
  var apiToken = DotEnv().env['API_TOKEN'];
  String param = '';
  parameters.forEach((key, value) {
    param += '&' + key + '=' + value;
  });
  return '$server/' + url + '?api_token=$apiToken' + param;
}

Future<String> attemptLogIn(String email, String password) async {
  var url = await getURL('user/login_token', {});
  var res = await http.post(url, body: {'email': email, 'password': password});
  if (res.statusCode == 200) {
    var jsonData = jsonDecode(res.body);
    return jsonData['token'];
  }
  return null;
}

Future<String> resetToken(String token) async {
  var url = await getURL('user/login_token', {});
  print(url);
  var res = await http.post(url, body: {'token': token});
  print(res.statusCode);
  if (res.statusCode == 200) {
    var jsonData = jsonDecode(res.body);
    return jsonData['token'];
  }
  return null;
}

Future<Map<String, dynamic>> getUserLoadByHandle(String handle) async {
  var url = await getURL('user/profile.json/' + handle, {});
  var res = await http.get(url);
  if (res.statusCode == 200) {
    return jsonDecode(res.body);
  }
  return null;
}

Future<Map<String, dynamic>> getProfileLoadById(String id) async {
  var url = await getURL(
      'user/get_stopstalk_user_stats.json', {'user_id': id, 'custom': 'false'});
  var res = await http.get(url);
  if (res.statusCode == 200) {
    return jsonDecode(res.body);
  }
  return null;
}
