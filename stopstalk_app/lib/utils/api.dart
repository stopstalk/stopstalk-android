import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;
import 'package:stopstalkapp/screens/login/login_screen.dart';
import 'dart:convert';
import 'package:stopstalkapp/utils/storage.dart';

Future<String> getURL(String url, Map<String, String> parameters) async {
  var server = DotEnv().env['SERVER'];
  var apiToken = DotEnv().env['API_TOKEN'];
  assert(apiToken != '', "API token must be Present");
  String param = '';
  print(parameters);
  parameters.forEach((key, value) {
    if (value == null) {
      value = '';
    }
    if (value.startsWith('is_list[')) {
      var list = value
          .replaceAll('is_list[', '')
          .replaceAll(']', '')
          .replaceAll(' ', '')
          .split(',');
      list.forEach((e) {
        if (e != null && e != '') {
          param += '&' + key + '=' + e;
        }
      });
    } else {
      param += '&' + key + '=' + value;
    }
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

Future<String> attemptGoogleLogIn(String token) async {
  var url = await getURL('user/app_google_login_token', {'gauth_token': token});
  var res = await http.post(url);
  print(res.statusCode);
  if (res.statusCode == 200) {
    var jsonData = jsonDecode(res.body);
    return jsonData['token'];
  }
  return null;
}

Future<String> resetToken(String token) async {
  var url = await getURL('user/login_token', {});
  var res = await http.post(url, body: {'token': token});
  if (res.statusCode == 200) {
    var jsonData = jsonDecode(res.body);
    return jsonData['token'];
  }
  return null;
}

Future<Map<String, dynamic>> getUserLoadByHandle(String handle) async {
  var url = await getURL('user/profile/' + handle, {});
  var res = await http.get(url);
  if (res.statusCode == 200) {
    return jsonDecode(res.body);
  }
  return null;
}

Future<Map<String, dynamic>> getProfileLoadById(String id) async {
  var url = await getURL(
      'user/get_stopstalk_user_stats', {'user_id': id, 'custom': 'false'});
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

Future<Map<String, dynamic>> getFriendsSubmissions() async {

  var url = await getURL('submissions', {});
  var headers = await getAuthHeader();
  var res = await http.get(url, headers: headers);
  if (res.statusCode == 200) {
    return jsonDecode(res.body);
  }
  if (res.statusCode == 401) {
    deleteAllDataSecureStore();
    Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
  }
  return null;
}

Future<Map<String, dynamic>> getFriendsTrendingprobs(
    BuildContext context) async {
  var url = await getURL('problems/friends_trending', {});
  var headers = await getAuthHeader();
  var res = await http.get(url, headers: headers);
  if (res.statusCode == 200) {
    return jsonDecode(res.body);
  }
  if (res.statusCode == 401) {
    deleteAllDataSecureStore();
    Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
  }
  return null;
}

Future<Map<String, dynamic>> getTodos(BuildContext context) async {
  var url = await getURL('todo', {});
  var headers = await getAuthHeader();
  var res = await http.get(url, headers: headers);
  if (res.statusCode == 200) {
    return jsonDecode(res.body);
  }
  if (res.statusCode == 401) {
    deleteAllDataSecureStore();
    Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
  }
  return null;
}

Future<String> addTodoUsingId(String id, BuildContext context) async {
  var url = await getURL('problems/add_todo_problem', {'pid': id});
  var headers = await getAuthHeader();
  var res = await http.get(url, headers: headers);
  if (res.statusCode == 200) {
    return res.body;
  }
  if (res.statusCode == 401) {
    deleteAllDataSecureStore();
    Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
  }
  return null;
}

Future<void> deleteTodoUsingLink(String link, BuildContext context) async {
  var url = await getURL('remove_todo', {'plink': link});
  var headers = await getAuthHeader();
  var res = await http.get(url, headers: headers);
  if (res.statusCode == 200) {
    print("deleted todo: " + link);
  }
  if (res.statusCode == 401) {
    deleteAllDataSecureStore();
    Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
  }
  return null;
}

Future<Map<String, dynamic>> getRecommendedProblems(
    BuildContext context) async {
  var url = await getURL('problems/recommendations.json', {});
  var headers = await getAuthHeader();
  var res = await http.get(url, headers: headers);
  if (res.statusCode == 200) {
    return jsonDecode(res.body);
  }
  if (res.statusCode == 401) {
    deleteAllDataSecureStore();
    Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
  }
  return null;
}

Future<Map<String, dynamic>> getSearchProblems(
    Map<String, String> filters, BuildContext context) async {
  var url = await getURL('problems/search', filters);
  var jwt = await getDataSecureStore("jwt");
  var res;
  if (jwt == null) {
    res = await http.get(url);
  } else {
    var headers = await getAuthHeader();
    res = await http.get(url, headers: headers);
  }
  if (res.statusCode == 200) {
    return jsonDecode(res.body);
  }
  if (res.statusCode == 401) {
    deleteAllDataSecureStore();
    Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
  }
  return null;
}

Future<Map<String, dynamic>> getSearchFriends(
    Map<String, String> filters, BuildContext context) async {
  var url = await getURL('search', filters);
  print(url);
  var jwt = await getDataSecureStore("jwt");
  var res;
  if (jwt == null) {
    res = await http.get(url);
  } else {
    var headers = await getAuthHeader();
    res = await http.get(url, headers: headers);
  }
  print(res.statusCode);
  if (res.statusCode == 200) {
    return jsonDecode(res.body);
  }
  if (res.statusCode == 401) {
    deleteAllDataSecureStore();
    Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
  }
  return null;
}

Future<bool> markFriend(String friendId) async {
  var url = await getURL('mark_friend/' + friendId, {});
  var headers = await getAuthHeader();
  var res = await http.get(url, headers: headers);
  if (res.statusCode == 200) {
    print("Added friend: " + friendId);
    return true;
  }
  if (res.statusCode == 401) {
    deleteAllDataSecureStore();
    Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
  }
  print("Unable to add friend at the moment");
  return false;
}

Future<bool> unFriend(String friendId) async {
  var url = await getURL('unfriend/' + friendId, {});
  var headers = await getAuthHeader();
  var res = await http.get(url, headers: headers);
  if (res.statusCode == 200) {
    print("remove friend: " + friendId);
    return true;
  }
  if (res.statusCode == 401) {
    deleteAllDataSecureStore();
    Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
  }
  print("Unable to remove friend at the moment");
  return false;
}

Future<Map<String, dynamic>> getLeaderboard(
    bool global, BuildContext context) async {
  var url = await getURL('leaderboard', {});
  var res;
  if (global) {
    res = await http.get(url);
  } else {
    var headers = await getAuthHeader();
    res = await http.get(url, headers: headers);
  }
  if (res.statusCode == 200) {
    return jsonDecode(res.body);
  }
  if (res.statusCode == 401) {
    deleteAllDataSecureStore();
    Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
  }
  return null;
}
