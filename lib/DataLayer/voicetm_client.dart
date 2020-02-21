import 'dart:async';
import 'dart:convert' show json;

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

import 'singer.dart';
import 'song.dart';

class VoiceTmClient {
  final _apiKey = '';
  final _host = 'voicetm.com';
  final _contextRoot = 'api';

  // Method to fetch all singers, singers will be fetched ordered by name
  Future<List<Singer>> fetchSingers(String path) async {
    final results = await request(
        path: path,
    );

    final data = results;
    return data
        .map<Singer>((json) => Singer.fromJson(json))
        .toList(growable: false);
  }

  // Method to fetch all songs, songs by singers or top-20
  Future <List<Song>> fetchSongs(String path) async {
    final results = await request(
      path: path
    );

    final data = results;
    return data.map<Song>((json) => Song.fromJson(json))
        .toList(growable: true);
  }

  Future<List> request(
      {@required String path, Map<String, String> parameters}) async {
    final uri = Uri.https(_host, '$_contextRoot/$path', parameters);
    final results = await http.get(uri, headers: _headers);
    final jsonObject = json.decode(results.body);
    return jsonObject;
  }

  Map<String, String> get _headers =>
      {'Accept': 'application/json', 'user-key': _apiKey};
}