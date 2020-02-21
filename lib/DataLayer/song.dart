import 'singer.dart';

class Song {
  final int id;
  final String name;
  final Singer singer;
  final String video;
  final String image;
  final int watchedCounter;
  final String addedDateTime;

  Song.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        singer = Singer.fromJson(json['singer']),
        video = json['video'],
        image = json['image'],
        watchedCounter = json['watchedCounter'],
        addedDateTime = json['addedDateTime'];
}