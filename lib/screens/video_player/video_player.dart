import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class KVideoPlayer extends StatefulWidget {
  KVideoPlayer({super.key, required this.videoPath});
  String videoPath;

  @override
  State<KVideoPlayer> createState() => K_VideoPlayerState();
}

class K_VideoPlayerState extends State<KVideoPlayer> {
  late FlickManager flickManager;
  // late VideoPlayerController  _controller
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(widget.videoPath),
    );
    // _controller = VideoPlayerController.network(widget.videoPath)
    //   ..initialize().then((_) {
    //     setState(() {
    //       _controller.play();
    //     });
    //   });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    flickManager.dispose();
    // _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              child: FlickVideoPlayer(flickManager: flickManager),
            ),
            Positioned(
                left: 10,
                top: 10,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 34,
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
