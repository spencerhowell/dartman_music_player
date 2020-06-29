import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class MusicList extends StatefulWidget {
  final FlutterAudioQuery audioQuery = FlutterAudioQuery();
  static final _tapeColor = Colors.grey[900];
  final _labelTextStyle = TextStyle(
    fontFamily: 'PermanentMarker',
    fontSize: 20.0,
    color: _tapeColor,
  );

  @override
  State<StatefulWidget> createState() => MusicListState();
}

class MusicListState extends State<MusicList> {

  @override
  void initState() {
    super.initState();
  }

  _returnAlbum(AlbumInfo albumInfo) {
    Navigator.pop(context, albumInfo);
  }

  Widget _buildList(List<AlbumInfo> albumList) {
    return ListView.builder(
      itemCount: albumList.length,
      itemBuilder: (BuildContext context, int position) {
        return GestureDetector(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: MusicList._tapeColor
            ),
            height: 75.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              margin: EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: Text(
                "${albumList[position].title.toString()} - ${albumList[position].artist.toString()}",
                textAlign: TextAlign.center,
                maxLines: 1,
                style: widget._labelTextStyle,
              ),
            ),
          ),
          onTap: () => _returnAlbum(albumList[position]),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Cassette Tapes"),
        backgroundColor: Colors.blue[300],
      ),
     body: FutureBuilder<List<AlbumInfo>>(
       future: widget.audioQuery.getAlbums(),
       builder: (context, snapshot) {
         if (!snapshot.hasData) {
           return CircularProgressIndicator();
         } else {
            return _buildList(snapshot.data);
         }
       }
     ),
    );
  }
}