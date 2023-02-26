import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

void main(){
runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Audio Player'),
        ),

        body: AudioPlayer(),
      ),
    );
  }
}




class AudioPlayer extends StatefulWidget {
  const AudioPlayer({super.key});

  @override
  State<AudioPlayer> createState() => _AudioPlayerState();
}

class _AudioPlayerState extends State<AudioPlayer> {
  late AssetsAudioPlayer assetsAudioPlayer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
    loadMedia();
  }

  Future<void> loadMedia() async {
    try {
      await assetsAudioPlayer.open(
          Audio.network(
              "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3"),
          autoStart: false,
          showNotification: true);
    } catch (e) {
      //mp3 unreachable
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text('Another audio player'),
                ),
                StreamBuilder(
                    stream: assetsAudioPlayer.isPlaying,
                    builder: (context, asyncSnapshot) {
                      final bool? isPlaying = asyncSnapshot.data;
                      return isPlaying == true
                          ? Center(
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  assetsAudioPlayer.pause();
                                });

                              },
                              icon: const Icon(
                                Icons.pause,
                                size: 50,
                              )))
                          : Center(
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                assetsAudioPlayer.play();
                              });

                            },
                            icon: Icon(
                              Icons.play_arrow,
                              size: 50,
                            )),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}