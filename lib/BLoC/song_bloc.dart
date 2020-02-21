import 'dart:async';

import 'package:muz_tm/BLoC/bloc.dart';
import 'package:muz_tm/DataLayer/singer.dart';
import 'package:muz_tm/DataLayer/song.dart';
import 'package:muz_tm/DataLayer/voicetm_client.dart';
import 'package:muz_tm/Karaoke.dart';

class SongBloc implements Bloc {
  final Singer singer;
  final _client = VoiceTmClient();
  final _controller = StreamController<List<Song>>();

  Stream<List<Song>> get stream => _controller.stream;
  SongBloc(this.singer);

  void submitQuery(String path) async {
    if(singer != null){
      String path = Karaoke.SINGER_PATH + "/" + singer.id.toString();
      final result = await _client.fetchSongs(path);
      _controller.sink.add(result);
    }else{
      final result = await _client.fetchSongs(path);
      _controller.sink.add(result);
    }
  }

  @override
  void dispose() {
    _controller.close();
  }

}