class User {
  final first_name;
  final last_name;
  final email;
  final rating;
  final codeforces_handle;
  final timus_handle;
  final uva_handle;
  final hackerearth_handle;
  final per_day;
  final id;
  final stopstalk_rating;
  final stopstalk_prev_rating;
  final atcoder_handle;
  final allowed_cu;
  final prev_rating;
  final hackerrank_handle;
  final codechef_handle;
  final blacklisted;
  final stopstalk_handle;
  final institute;
  final referrer;
  final per_day_change;
  final country;
  final poj_handle;

  User(
      this.first_name,
      this.last_name,
      this.email,
      this.rating,
      this.codeforces_handle,
      this.timus_handle,
      this.uva_handle,
      this.hackerearth_handle,
      this.per_day,
      this.id,
      this.stopstalk_rating,
      this.stopstalk_prev_rating,
      this.atcoder_handle,
      this.allowed_cu,
      this.prev_rating,
      this.hackerrank_handle,
      this.codechef_handle,
      this.blacklisted,
      this.stopstalk_handle,
      this.institute,
      this.referrer,
      this.per_day_change,
      this.country,
      this.poj_handle);
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
    payloadMap['user']['poj_handle']);
