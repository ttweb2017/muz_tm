import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:muz_tm/Karaoke.dart';

import 'BLoC/bloc_provider.dart';
import 'BLoC/singer_bloc.dart';
import 'UI/karaoke_screen.dart';

void main() => runApp(KaraokeApp());

class KaraokeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This app is designed only to work vertically, so we limit
    // orientations to portrait up and down.
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]
    );

    return CupertinoApp(
      title: Karaoke.APP_TITLE,
      home: KaraokeScreen(),
    );
  }
}