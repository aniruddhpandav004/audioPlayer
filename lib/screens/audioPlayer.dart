import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class JsonData extends StatefulWidget {
  const JsonData({Key? key}) : super(key: key);

  @override
  State<JsonData> createState() => _JsonDataState();
}

class _JsonDataState extends State<JsonData> {
  bool isPlay = false;
  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
  Duration endDuration = Duration(seconds: 0);

  @override
  void initState() {
    super.initState();
    loadAudio();
  }

  void loadAudio() async {
    await assetsAudioPlayer.open(Audio("assets/audio/keshri.mp3"),
        autoStart: false);

    assetsAudioPlayer.current.listen(
      (event) {
        setState(
          () {
            endDuration = event!.audio.duration;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Music Player"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  setState(
                    () {
                      isPlay = !isPlay;
                    },
                  );
                  if (isPlay) {
                    assetsAudioPlayer.play();
                  } else {
                    assetsAudioPlayer.pause();
                  }
                },
                icon: Icon(isPlay
                    ? Icons.pause_circle_filled_outlined
                    : Icons.play_circle),
              ),
              assetsAudioPlayer.builderCurrentPosition(
                builder: (context, duration) {
                  return Column(
                    children: [
                      Slider(
                          value: duration.inSeconds.toDouble(),
                          onChanged: (value) {
                            assetsAudioPlayer
                                .seek(Duration(seconds: value.toInt()));
                          },
                          max: endDuration.inSeconds.toDouble()),
                      Text("$duration / $endDuration"),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
