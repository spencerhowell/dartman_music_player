import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class MusicList extends StatefulWidget {
  final FlutterAudioQuery audioQuery = FlutterAudioQuery();

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
        return ListTile(
          title: Text(albumList[position].title.toString()),
          subtitle: Text(albumList[position].artist.toString()),
          onTap: () => _returnAlbum(albumList[position]),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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