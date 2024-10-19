import 'package:flutter/material.dart';
import 'package:iiiimusictv/repos/remote/api/api_services.dart';
import 'package:iiiimusictv/components/player_button_container_view.dart';
import 'package:iiiimusictv/components/radio_list_view/country_list_view.dart';
import 'package:iiiimusictv/components/radio_list_view/country_list_view_model.dart';
import 'package:iiiimusictv/repos/repo_api_services.dart';
import 'package:iiiimusictv/repos/local/repo_api_services_local.dart';
import 'package:iiiimusictv/viewmodels/video_player_view_model.dart';
import 'package:provider/provider.dart';

class PlayerView extends StatefulWidget {
  VideoPlayerViewModel playerViewModel;

  PlayerView({super.key, required this.playerViewModel});

  @override
  State<StatefulWidget> createState() => PlayerViewState();
}

class PlayerViewState extends State<PlayerView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minWidth: double.infinity,
        minHeight: double.infinity,
        maxWidth: double.infinity,
        maxHeight: double.infinity,
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            // SliderBarView(),
            Expanded(child: Consumer<VideoPlayerViewModel>(
              builder: (BuildContext context, VideoPlayerViewModel value,
                  Widget? child) {
                if (value.currentStation == null) {
                  return const Icon(
                    Icons.broken_image_outlined,
                    size: 90,
                    color: Colors.white70,
                  );
                  // https://placehold.co/600x400.png
                }
                return Image.network(
                  value.currentStation!.favicon,
                  fit: BoxFit.fitWidth,
                    errorBuilder: (
                        context,
                        error,
                        stackTrace,
                        ) {
                      return const Icon(
                        Icons.broken_image_outlined,
                        size: 90,
                        color: Colors.white70,
                      );
                    }
                );
              },
            )),
            // Text("title"),
            // Text("desc"),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: fm(),
            ),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Consumer<VideoPlayerViewModel>(
                  builder: (BuildContext context, VideoPlayerViewModel value,
                      Widget? child) {
                    return PlayerButtonContainerView(
                      playerViewModel: value,
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget fm() {
    return ElevatedButton(
      child: Text(widget.playerViewModel.currentStation?.name ?? "NaN"),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MultiProvider(
                        providers: [
                          ChangeNotifierProvider(
                              create: (context) =>
                                  CountryListViewModel(RepoApiServices(local: RepoApiServicesLocal(), remote: ApiServices()))),
                        ],
                        child: Consumer<CountryListViewModel>(
                          builder: (BuildContext context,
                              CountryListViewModel value, Widget? child) {
                            return CountryListView(
                              viewModel: value,
                              playerViewModel: widget.playerViewModel,
                            );
                          },
                        ))));
      },
    );
  }
}
