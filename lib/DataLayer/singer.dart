class Singer {
  final int id;
  final String firstName;
  final String lastName;
  final String avatar;
  final String category;

  String get fullName => firstName + " " + lastName;

  Singer.fromJson(Map json)
      : id = json['id'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        avatar = json['avatar'],
        category = 'All';
}