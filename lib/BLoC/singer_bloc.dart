import 'dart:async';

import 'package:muz_tm/BLoC/bloc.dart';
import 'package:muz_tm/DataLayer/singer.dart';

class SingerBloc implements Bloc {
  Singer _singer;
  Singer get selectedSinger => _singer;

  final _singerController = StreamController<Singer>();

  Stream<Singer> get singerStream => _singerController.stream;

  void selectSinger(Singer singer){
    _singer = singer;
    _singerController.sink.add(singer);
  }

  @override
  void dispose() {
    _singerController.close();
  }
}