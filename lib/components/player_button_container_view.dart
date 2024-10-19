import 'package:flutter/material.dart';
import 'package:iiiimusictv/viewmodels/video_player_view_model.dart';

class PlayerButtonContainerView extends StatefulWidget {
  VideoPlayerViewModel playerViewModel;

  PlayerButtonContainerView({super.key, required this.playerViewModel});

  @override
  State<StatefulWidget> createState() => PlayerButtonContainerViewState();
}

class PlayerButtonContainerViewState extends State<PlayerButtonContainerView> {
  static const paddingSize = 10.04;
  static const double iconSize = 60;

  @override
  void dispose() {
    widget.playerViewModel.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            widget.playerViewModel.playPre();
          },
          child: const Padding(
              padding: EdgeInsets.all(paddingSize),
              child: Icon(
                Icons.skip_previous,
                color: Colors.white70,
                size: iconSize,
              )),
        ),
        GestureDetector(
          onTap: () {
            if (widget.playerViewModel.isPlaying) {
              widget.playerViewModel.pause();
            } else {
              widget.playerViewModel.play();
            }
          },
          child: Padding(
              padding: const EdgeInsets.all(paddingSize),
              child: Icon(
                widget.playerViewModel.isPlaying
                    ? Icons.stop
                    : Icons.play_arrow,
                color: Colors.white70,
                size: iconSize,
              )),
        ),
        GestureDetector(
          onTap: () {
            widget.playerViewModel.playNext();
          },
          child: const Padding(
              padding: EdgeInsets.all(paddingSize),
              child: Icon(
                Icons.skip_next,
                color: Colors.white70,
                size: iconSize,
              )),
        ),
      ],
    );
  }
}
