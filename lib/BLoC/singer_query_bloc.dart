import 'dart:async';

import 'package:muz_tm/DataLayer/singer.dart';
import 'package:muz_tm/DataLayer/voicetm_client.dart';

import 'bloc.dart';

class SingerQueryBloc implements Bloc {
  final _controller = StreamController<List<Singer>>();
  final _client = VoiceTmClient();
  Stream <List<Singer>> get singerStream => _controller.stream;

  void submitQuery(String path) async {
    final result = await _client.fetchSingers(path);
    _controller.sink.add(result);
  }

  @override
  void dispose() {
    _controller.close();
  }
}