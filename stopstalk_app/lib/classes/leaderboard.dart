class LeaderBoard {
  final bool loggedin;
  final String name;
  final String stopstalkHandle;
  final String institute;
  final int stopstalkRating;
  final double perDayChanges;
  final List<dynamic> country;
  final int customUsers;
  final int rank;

  LeaderBoard({
    this.loggedin,
    this.name,
    this.stopstalkHandle,
    this.institute,
    this.stopstalkRating,
    this.perDayChanges,
    this.country,
    this.customUsers,
    this.rank,
  });
}
