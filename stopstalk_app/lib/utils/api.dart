import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:stopstalkapp/utils/storage.dart';

Future<String> getURL(String url, Map<String, String> parameters) async {
  var server = DotEnv().env['SERVER'];
  var apiToken = DotEnv().env['API_TOKEN'];
  String param = '';
  parameters.forEach((key, value) {
    param += '&' + key + '=' + value;
  });
  return '$server/' + url + '?api_token=$apiToken' + param;
}

Future<Map<String, String>> getAuthHeader() async {
  var jwt = await getDataSecureStore("jwt");
  assert(jwt != null, "JWT is null");
  return {'Content-Type': 'application/json', 'Authorization': 'Bearer ' + jwt};
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

Future<Map<String, dynamic>> getGlobalTrendingprobs() async {
  var url = await getURL('problems/global_trending', {});
  var res = await http.get(url);
  if (res.statusCode == 200) {
    return jsonDecode(res.body);
  }
  return null;
}

Future<Map<String, dynamic>> getFriendsTrendingprobs() async {
  var url = await getURL('problems/friends_trending', {});
  var headers = await getAuthHeader();
  var res = await http.get(url, headers: headers);
  if (res.statusCode == 200) {
    return jsonDecode(res.body);
  }
  return null;
}

Future<Map<String, dynamic>> getTodos() async {
  var url = await getURL('todo', {});
  var headers = await getAuthHeader();
  var res = await http.get(url, headers: headers);
  if (res.statusCode == 200) {
    return jsonDecode(res.body);
  }
  return null;
}

Future<Map<String, dynamic>> addTodoUsingId(String id) async {
  var url = await getURL('problems/add_todo_problem', {'pid': id});
  var headers = await getAuthHeader();
  var res = await http.get(url, headers: headers);
  if (res.statusCode == 200) {
    return jsonDecode(res.body);
  }
  return null;
}

Future<void> deleteTodoUsingLink(String link) async {
  var url = await getURL('remove_todo', {'plink': link});
  var headers = await getAuthHeader();
  var res = await http.get(url, headers: headers);
  if (res.statusCode == 200) {
    print("deleted todo: " + link);
  }
  return null;
}
