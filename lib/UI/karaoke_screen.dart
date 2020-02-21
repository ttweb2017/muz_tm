import 'package:flutter/cupertino.dart';
import 'package:muz_tm/Karaoke.dart';
import 'package:muz_tm/UI/song/song_tab.dart';
import 'package:permission_handler/permission_handler.dart';

import 'singer/singer_tab.dart';

class KaraokeScreen extends StatelessWidget {
  //final Map<PermissionGroup, PermissionStatus> permissions;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            title: Text(Karaoke.NAVIGATION_POPULAR),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.music_note),
            title: Text(Karaoke.NAVIGATION_SONG),
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.group),
            title: Text(Karaoke.NAVIGATION_SINGER),
          ),
        ],
      ),
      tabBuilder: (context, index) {
        CupertinoTabView returnValue;
        switch (index) {
          case 0:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                  child: SongTab(isPopular: true)
              );
            });
            break;
          case 1:
            returnValue = CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                  child: SongTab(isPopular: false)
              );
            });
            break;
          case 2:
            returnValue = CupertinoTabView(builder: (context) {
              return SingerTab();
            });
            break;
        }
        return returnValue;
      },
    );
  }

  // TODO ask permission on load
  /*void getPermission() async {
    permissions = await PermissionHandler().requestPermissions([
      PermissionGroup.camera,
      PermissionGroup.photos,
      PermissionGroup.microphone,
    ]);
  }*/
}