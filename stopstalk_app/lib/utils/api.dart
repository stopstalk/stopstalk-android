import 'package:flutter_config/flutter_config.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> getURL(String url) async {
  var server = await FlutterConfig.get('SERVER');
  var apiToken = await FlutterConfig.get('API_TOKEN');
  return '$server/' + url + '?api_token=$apiToken';
}

Future<String> attemptLogIn(String email, String password) async {
  var url = await getURL('user/login_token');
  var res = await http.post(url, body: {'email': email, 'password': password});
  if (res.statusCode == 200) {
    var jsonData = jsonDecode(res.body);
    return jsonData['token'];
  }
  return null;
}
