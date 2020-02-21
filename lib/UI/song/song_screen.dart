import 'package:flutter/cupertino.dart';
import 'package:muz_tm/BLoC/bloc_provider.dart';
import 'package:muz_tm/BLoC/song_bloc.dart';
import 'package:muz_tm/DataLayer/singer.dart';
import 'package:muz_tm/DataLayer/song.dart';
import 'package:muz_tm/Karaoke.dart';

import 'song_row_item.dart';

class SongScreen extends StatelessWidget {
  SongScreen({Key key, @required this.isPopular, this.singer}) :super(key: key);
  final bool isPopular;
  final Singer singer;

  @override
  Widget build(BuildContext context) {
    String path = isPopular ? Karaoke.TOP_20_PATH : Karaoke.SONG_PATH;
    final bloc = SongBloc(singer);
    bloc.submitQuery(path);

    return BlocProvider<SongBloc>(
      bloc: bloc,
      child: StreamBuilder<List<Song>>(
        stream: bloc.stream,
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return buildErrorResult();
          }

          final songs = snapshot.data;

          if(songs == null || songs.isEmpty){
            return buildEmptyResult(songs);
          }

          return _buildResults(songs);
        },
      ),
    );
  }

  Widget buildEmptyResult(List<Song> songs) {
    return Center(
      child: songs == null ? CupertinoActivityIndicator() : Text(
          Karaoke.NO_RESULT),
    );
  }

  Widget buildErrorResult() {
    return Center(
        child: Text(Karaoke.CONNECTION_ERROR)
    );
  }

  Widget _buildResults(List<Song> songs) {
    String title = isPopular ? Karaoke.NAVIGATION_POPULAR : Karaoke.NAVIGATION_SONG;
    return CustomScrollView(
      semanticChildCount: songs != null ? songs.length : 0,
      slivers: <Widget>[
        CupertinoSliverNavigationBar(
          largeTitle: Text(title),
        ),
        buildResultWithData(songs)
      ],
    );
  }

  Widget buildResultWithData(List<Song> songs){
    return SliverSafeArea(
      top: false,
      minimum: const EdgeInsets.only(top: 8),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            if (index < songs.length) {
              return SongRowItem(
                index: index,
                song: songs[index],
                lastItem: index == songs.length - 1,
              );
            }
            return null;
          },
        ),
      ),
    );
  }
}