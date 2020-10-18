import 'package:flutter/services.dart';
import 'dart:convert';

import '../utils/api.dart';

const sites_img = {
  "AtCoder": 'assets/platform_logos/atcoder_small.png',
  "HackerRank": 'assets/platform_logos/hackerrank_small.png',
  "HackerEarth": 'assets/platform_logos/hackerearth_small.png',
  "CodeForces": 'assets/platform_logos/codeforces_small.png',
  "Spoj": 'assets/platform_logos/spoj_small.png',
  "UVa": 'assets/platform_logos/uva_small.png',
  "Timus": 'assets/platform_logos/timus_small.png',
  "CodeChef": 'assets/platform_logos/codechef_small.png',
};

class User {
  final firstName;
  final lastName;
  final email;
  final rating;
  final codeforcesHandle;
  final timusHandle;
  final uvaHandle;
  final hackerearthHandle;
  final perDay;
  final id;
  final stopstalkRating;
  final stopstalkPrevRating;
  final atcoderHandle;
  final allowedCu;
  final prevRating;
  final hackerrankHandle;
  final codechefHandle;
  final blacklisted;
  final stopstalkHandle;
  final institute;
  final referrer;
  final perDayChange;
  final country;
  final spojHandle;

  User(
      this.firstName,
      this.lastName,
      this.email,
      this.rating,
      this.codeforcesHandle,
      this.timusHandle,
      this.uvaHandle,
      this.hackerearthHandle,
      this.perDay,
      this.id,
      this.stopstalkRating,
      this.stopstalkPrevRating,
      this.atcoderHandle,
      this.allowedCu,
      this.prevRating,
      this.hackerrankHandle,
      this.codechefHandle,
      this.blacklisted,
      this.stopstalkHandle,
      this.institute,
      this.referrer,
      this.perDayChange,
      this.country,
      this.spojHandle);

  String name() => this.firstName + " " + this.lastName;
  Map<String, String> handles() => {
        "AtCoder": this.atcoderHandle,
        "HackerRank": this.hackerrankHandle,
        "HackerEarth": this.hackerearthHandle,
        "CodeForces": this.codeforcesHandle,
        "Spoj": this.spojHandle,
        "UVa": this.uvaHandle,
        "Timus": this.timusHandle,
        "CodeChef": this.codechefHandle,
      };
}

User userFromPayloapMap(payloadMap) => User(
    payloadMap['user']['first_name'],
    payloadMap['user']['last_name'],
    payloadMap['user']['email'],
    payloadMap['user']['rating'],
    payloadMap['user']['codeforces_handle'],
    payloadMap['user']['timus_handle'],
    payloadMap['user']['uva_handle'],
    payloadMap['user']['hackerearth_handle'],
    payloadMap['user']['per_day'],
    payloadMap['user']['id'],
    payloadMap['user']['stopstalk_rating'],
    payloadMap['user']['stopstalk_prev_rating'],
    payloadMap['user']['atcoder_handle'],
    payloadMap['user']['allowed_cu'],
    payloadMap['user']['prev_rating'],
    payloadMap['user']['hackerrank_handle'],
    payloadMap['user']['codechef_handle'],
    payloadMap['user']['blacklisted'],
    payloadMap['user']['stopstalk_handle'],
    payloadMap['user']['institute'],
    payloadMap['user']['referrer'],
    payloadMap['user']['per_day_change'],
    payloadMap['user']['country'],
    payloadMap['user']['spoj_handle']);

class Profile {
  final User user;
  final Map<String, dynamic> accuracy;
  final Map<String, dynamic> solved;
  final Map<String, dynamic> handleUrls;
  final Map<String, dynamic> acceptanceGraph;
  final int dayCurrent;
  final int dayMaximum;
  final int acceptedSolnCurrent;
  final int acceptedSolnMaximum;
  final int problemsSolved;
  final int problemsTotal;

  Profile(
      this.user,
      this.accuracy,
      this.solved,
      this.handleUrls,
      this.dayCurrent,
      this.dayMaximum,
      this.acceptedSolnCurrent,
      this.acceptedSolnMaximum,
      this.problemsSolved,
      this.problemsTotal,
      this.acceptanceGraph);

  Map<String, dynamic> getSitesDetails() {
    Map<String, dynamic> data = {};
    this.user.handles().forEach((key, value) {
      if (value != null &&
          value != "" &&
          this.handleUrls[key] != null &&
          this.handleUrls[key] != "") {
        data[key] = {
          'handle': value,
          'url': this.handleUrls[key],
          'accuracy': this.accuracy[key],
          'solved': this.solved[key],
          'img': sites_img[key]
        };
      }
    });
    return data;
  }

  Future<String> getFlagURL() async {
    String data = await rootBundle.loadString('assets/countries.json');
    var flags = await json.decode(data);
    var shortCountry = flags[this.user.country].toLowerCase();
    return 'assets/flags/$shortCountry.svg';
  }
}

Future<Profile> getProfileFromHandle(String handle) async {
  var userPayload = await getUserLoadByHandle(handle);
  userPayload['user'] = userPayload['row'];
  final user = userFromPayloapMap(userPayload);
  var profilePayload = await getProfileLoadById(user.id.toString());
  return Profile(
      user,
      profilePayload['site_accuracies'],
      profilePayload['solved_counts'],
      userPayload['profile_urls'],
      profilePayload['curr_day_streak'],
      profilePayload['max_day_streak'],
      profilePayload['curr_accepted_streak'],
      profilePayload['max_accepted_streak'],
      profilePayload['solved_problems_count'],
      profilePayload['total_problems_count'],
      profilePayload['calendar_data']);
}
