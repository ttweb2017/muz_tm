import 'package:flutter/cupertino.dart';
import 'package:muz_tm/BLoC/song_bloc.dart';
import 'package:muz_tm/DataLayer/singer.dart';
import 'package:muz_tm/DataLayer/song.dart';
import 'package:muz_tm/UI/song/song_row_item.dart';
import 'package:muz_tm/UI/styles.dart';

class SingersSongScreen extends StatelessWidget {
  SingersSongScreen({Key key, this.singer}) : super(key: key);

  final Singer singer;

  @override
  Widget build(BuildContext context) {
    final bloc = SongBloc(singer);
    bloc.submitQuery("");

    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: true,
      navigationBar: CupertinoNavigationBar(
        middle: Text(singer.fullName),
      ),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Styles.scaffoldBackground,
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: bloc.stream,
                  builder: (context, snapshot){
                    if(snapshot.connectionState == ConnectionState.active){
                      print("done");
                      return _buildDataResults(snapshot.data);
                    }else{
                      print("loading...");
                      return Center(child: CupertinoActivityIndicator());
                    }
                  },
                )
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDataResults(List<Song> songs){
    return ListView.builder(
      itemBuilder: (context, index) => SongRowItem(
          index: index,
          song: songs[index],
          lastItem: index == songs.length - 1
      ),
      itemCount: songs.length,
    );
  }
}