import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:muz_tm/DataLayer/song.dart';
import 'package:muz_tm/Karaoke.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  VideoScreen({Key key, @required this.song}) : super(key: key);
  final Song song;

  @override
  _VideoScreenState createState() => _VideoScreenState(song);
}

class _VideoScreenState extends State<VideoScreen> {
  Song song;
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  _VideoScreenState(this.song);

  @override
  void initState() {
    // TODO: Video Player implement initState
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeRight]
    );

    _controller = VideoPlayerController.network(
      Karaoke.SONG_VIDEO_PATH + song.video,
    );

    // Initielize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(false);

    super.initState();
  }

  @override
  void dispose() {
    // TODO: Video Player implement dispose
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp]
    );

    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(song.name),
      ),
      child: Container(
        child: Stack(
          children: <Widget>[
            Center(
              child: FutureBuilder(
                  future: _initializeVideoPlayerFuture,
                  builder: (context, snapshot){
                    if(snapshot.connectionState == ConnectionState.done){
                      return AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        // Use the VideoPlayer widget to display the video.
                        child: VideoPlayer(_controller),
                      );
                    }else{
                      return Center(child: CupertinoActivityIndicator());
                    }

                  }
              ),
            ),
            Center(
              child: _playerControllerWidget(),
            )
          ],
        ),
      ),
    );
  }

  Widget _playerControllerWidget(){
    return CupertinoButton(
      child: _playerControlWidgetView(),
      color: Color(0x000000),
      onPressed: (){
        setState(() {
          if(_controller.value.isPlaying){
            _controller.pause();
          }else{
            _controller.play();
          }
        });
      },
    );
  }

  Widget _playerControlWidgetView(){
    return Container(
      height: 50,
      width: 50,
      child: Center(
        child: _controller != null && _controller.value.isPlaying
            ? Icon(CupertinoIcons.pause_solid, size: 40.0, color: Color(0xFF00BFFF))
            : Icon(CupertinoIcons.play_arrow_solid, size: 40.0, color: Color(0xFFFF0000)),
      ),
    );
  }
}