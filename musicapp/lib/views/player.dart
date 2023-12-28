import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicapp/const/colors.dart';
import 'package:musicapp/const/style.dart';
import 'package:musicapp/controllers/player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Player extends StatelessWidget {
  final List<SongModel> data;
  const Player({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PlayerController>();
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(),
      body: Column(children: [
        Obx(
          () => Expanded(
              // ignore: avoid_unnecessary_containers
              child: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  alignment: Alignment.center,
                  child: QueryArtworkWidget(
                    id: data[controller.playIndex.value].id,
                    type: ArtworkType.AUDIO,
                    artworkHeight: double.infinity,
                    artworkWidth: double.infinity,
                    nullArtworkWidget: const Icon(
                      size: 50,
                      Icons.music_note,
                      color: whiteColor,
                    ),
                  ))),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                color: whiteColor),
            child: Obx(
              () => Column(children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    data[controller.playIndex.value].displayNameWOExt,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: ourStyle(color: darkColor, size: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    data[controller.playIndex.value].artist.toString(),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: ourStyle(color: darkColor, size: 18),
                  ),
                ),
                Obx(
                  () => Row(
                    children: [
                      Text(
                        controller.position.value,
                        style: ourStyle(color: darkColor),
                      ),
                      Expanded(
                        child: Slider(
                          thumbColor: slideColor,
                          inactiveColor: bgColor,
                          activeColor: slideColor,
                          min: const Duration(seconds: 0).inSeconds.toDouble(),
                          max: controller.max.value,
                          value: controller.value.value,
                          onChanged: (newValue) {
                            controller
                                .changeDurationToSeconds(newValue.toInt());
                            newValue = newValue;
                          },
                        ),
                      ),
                      Text(
                        controller.duration.value,
                        style: ourStyle(color: darkColor),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        controller.playSong(
                            data[controller.playIndex.value - 1].uri,
                            controller.playIndex.value - 1);
                      },
                      icon: const Icon(
                        Icons.skip_previous_rounded,
                        color: darkColor,
                        size: 40,
                      ),
                    ),
                    Obx(
                      () => CircleAvatar(
                        radius: 35,
                        backgroundColor: darkColor,
                        child: Transform.scale(
                          scale: 2.5,
                          child: IconButton(
                            onPressed: () {
                              if (controller.isPlaying.value) {
                                controller.audioPlayer.pause();
                                controller.isPlaying(false);
                              } else {
                                controller.audioPlayer.play();
                                controller.isPlaying(true);
                              }
                            },
                            icon: controller.isPlaying.value
                                ? const Icon(
                                    Icons.pause,
                                    color: whiteColor,
                                  )
                                : const Icon(
                                    Icons.play_arrow_rounded,
                                    color: whiteColor,
                                  ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        controller.playSong(
                            data[controller.playIndex.value + 1].uri,
                            controller.playIndex.value + 1);
                      },
                      icon: const Icon(
                        Icons.skip_next_rounded,
                        color: darkColor,
                        size: 40,
                      ),
                    )
                  ],
                )
              ]),
            ),
          ),
        ),
      ]),
    );
  }
}
