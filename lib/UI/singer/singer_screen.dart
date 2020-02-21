import 'package:flutter/cupertino.dart';
import 'package:muz_tm/BLoC/bloc_provider.dart';
import 'package:muz_tm/BLoC/singer_query_bloc.dart';
import 'package:muz_tm/DataLayer/singer.dart';
import 'package:muz_tm/Karaoke.dart';

import 'singer_row_item.dart';

class SingerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /*var screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    var height = screenSize.height;*/

    final bloc = SingerQueryBloc();
    bloc.submitQuery(Karaoke.SINGER_PATH);

    return BlocProvider<SingerQueryBloc>(
      bloc: bloc,
      child: _buildResults(bloc),
    );
  }

  Widget _buildResults(SingerQueryBloc bloc) {
    return StreamBuilder<List<Singer>>(
        stream: bloc.singerStream,
        builder: (context, snapshot) {

          if(snapshot.connectionState == ConnectionState.active){
            print("done");
            return _buildDataResults(snapshot.data);
          }else{
            print("loading...");
            return Center(child: CupertinoActivityIndicator());
          }

        }
    );
  }

  Widget buildErrorResult(){
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: Text(Karaoke.NAVIGATION_SINGER, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
      ),
      child: Center(child: Text(Karaoke.NO_RESULT)),
    );
  }

  Widget _buildEmptyResult(List<Singer> singers){
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(Karaoke.NAVIGATION_SINGER),
      ),
      child: Center(child: singers == null ? CupertinoActivityIndicator() : Text(Karaoke.NO_RESULT)),
    );
  }

  Widget _buildDataResults(List<Singer> singers) {

    int singerRowCount = singers != null ? singers.length : 0;
    return CustomScrollView(
      semanticChildCount: singerRowCount,
      slivers: <Widget>[
        const CupertinoSliverNavigationBar(
          largeTitle: Text(Karaoke.NAVIGATION_SINGER),
        ),
        singerRowCount != 0 ?
        SliverSafeArea(
          top: false,
          minimum: const EdgeInsets.only(top: 8),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                if (index < singerRowCount) {
                  return SingerRowItem(
                    index: index,
                    singer: singers[index],
                    lastItem: index == singers.length - 1,
                  );
                }
                return null;
              },
            )
          ),
        ) :
        SliverToBoxAdapter(
          child: SizedBox(
            height: 400.0,
            child: Center(child: Text(Karaoke.NO_RESULT))
          )
        ),
      ],
    );
  }
}