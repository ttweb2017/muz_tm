import 'package:flutter/cupertino.dart';
import 'package:muz_tm/DataLayer/singer.dart';
import 'package:muz_tm/UI/song/song_screen.dart';

class SongTab extends StatelessWidget {
  SongTab({Key key, @required this.isPopular, this.singer}) : super(key: key);

  final bool isPopular;
  final Singer singer;

  @override
  Widget build(BuildContext context){
    return SongScreen(isPopular: isPopular);
  }
}