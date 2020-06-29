import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:dartmanmusicplayer/side_button.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

import 'music_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final FlutterAudioQuery audioQuery = FlutterAudioQuery();
  final audioPlayer = AssetsAudioPlayer.newPlayer();
  final sfxPlayer = AssetsAudioPlayer.newPlayer();
  final dartmanBlue = Colors.blue[600];
  final dartmanGray = Colors.blueGrey[200];

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isPaused = true;
  var buttonState = ButtonStates();

  _updateAlbum(AlbumInfo albumInfo) async {
    var songs = await widget.audioQuery
        .getSongsFromAlbum(albumId: albumInfo.id.toString());

    var songAudios = songs
        .map((songInfo) =>
            Audio.file(Uri.file(songInfo.filePath.toString()).toString()))
        .toList();
    widget.audioPlayer.open(Playlist(audios: songAudios));

    setState(() {
      widget.audioPlayer.play();
      _isPaused = false;
      buttonState.playPressed = true;
      buttonState.stopPressed = false;
      buttonState.ejectPressed = false;
    });
  }

  _ejectPressed() async {
    setState(() {
      buttonState.ejectPressed = true;
    });
    widget.audioPlayer.pause();
    AssetsAudioPlayer.playAndForget(Audio('assets/tape-sfx.mp3'));
    var selectedAlbum = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => MusicList()));

    if (selectedAlbum != null) {
      _updateAlbum(selectedAlbum);
    }
  }

  _playButtonSfx() {
    AssetsAudioPlayer.playAndForget(
      Audio('assets/button-sfx.mp3'),
    );
  }

  _playSeekSfx() {
    AssetsAudioPlayer.playAndForget(Audio('assets/ffwd-sfx.mp3'));
  }

  _playPressed() {
    _playButtonSfx();
    widget.audioPlayer.play();
    setState(() {
      _isPaused = false;
      buttonState.playPressed = true;
      buttonState.stopPressed = false;
    });
  }

  _stopPressed() {
    widget.audioPlayer.pause();
    _playButtonSfx();
    setState(() {
      _isPaused = true;
      buttonState.stopPressed = true;
      buttonState.playPressed = false;
    });
  }

  _rewindPressed() {
    widget.audioPlayer.previous();
    _playButtonSfx();
    _playSeekSfx();
    setState(() {
      _isPaused = false;
      buttonState.stopPressed = false;
      buttonState.playPressed = true;
    });
  }

  _fastForwardPressed() {
    widget.audioPlayer.next();
    _playButtonSfx();
    _playSeekSfx();
    setState(() {
      _isPaused = false;
      buttonState.stopPressed = false;
      buttonState.playPressed = true;
    });
  }

  @override
  void dispose() {
    widget.audioPlayer.dispose();
    widget.sfxPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: widget.dartmanBlue,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 80.0,
                  ),
                  Container(
                    decoration: BoxDecoration(color: Colors.blueGrey[700]),
                    height: 5.0,
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('FLUTTER',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 40.0,
                          color: Colors.white,
                          //color: Colors.blueGrey[100],
                          fontFamily: 'RobotoSlab',
                        )),
                  ),
                  Spacer(),
                  Container(
                    height: 375,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          child: FlareActor(
                            'assets/cassette.flr',
                            fit: BoxFit.contain,
                            animation: 'Roll',
                            isPaused: _isPaused,
                          ),
                        ),
                        Container(
                          //margin: EdgeInsets.symmetric(horizontal: 30.0),
                          width: 40,
                          child: Image.asset('assets/arrow.png', width: 50),
                        ),
                        SizedBox(
                          width: 30.0,
                        )
                      ],
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('DARTMAN',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 40.0,
                            color: Colors.white,
                            //color: Colors.blueGrey[100],
                            fontFamily: 'MuseoModerno')),
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: widget.dartmanGray,
            ),
            width: 100.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 85.0),
                SideButton(
                  icon: Icons.play_arrow,
                  onPressed: () => _playPressed(),
                  isPressed: buttonState.playPressed,
                ),
                SizedBox(height: 16.0),
                SideButton(
                  icon: Icons.stop,
                  onPressed: () => _stopPressed(),
                  isPressed: buttonState.stopPressed,
                ),
                SizedBox(height: 16.0),
                SideButton(
                  icon: Icons.fast_forward,
                  isPressed: buttonState.fastForwardPressed,
                  onPressed: () => _fastForwardPressed(),
                ),
                SizedBox(height: 16.0),
                SideButton(
                  icon: Icons.fast_rewind,
                  onPressed: () => _rewindPressed(),
                  isPressed: buttonState.rewindPressed,
                ),
                SizedBox(height: 16.0),
                SideButton(
                  text: "EJECT",
                  onPressed: () => _ejectPressed(),
                  isPressed: buttonState.ejectPressed,
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}

class ButtonStates {
  bool playPressed = false;
  bool stopPressed = false;
  bool fastForwardPressed = false;
  bool rewindPressed = false;
  bool ejectPressed = false;
}
