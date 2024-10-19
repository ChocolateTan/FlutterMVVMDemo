import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:iiiimusictv/app_style.dart';
import 'package:iiiimusictv/components/radio_list_view/station_list_view_model.dart';
import 'package:iiiimusictv/vo_models/vo_station.dart';
import 'package:iiiimusictv/viewmodels/video_player_view_model.dart';

class StationListInfoView extends StatefulWidget {
  final String countryName;
  final StationListInfoViewModel viewModel;
  final VideoPlayerViewModel playerViewModel;

  const StationListInfoView(
      {super.key,
      required this.countryName,
      required this.viewModel,
      required this.playerViewModel});

  @override
  State<StatefulWidget> createState() => _StationListInfoViewState();
}

class _StationListInfoViewState extends State<StationListInfoView> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.clickedStation.stream.listen((value) {
      widget.playerViewModel.switchChannelByStation(value.first, value.second);
      // Navigator.popUntil(context, (route) {
      //   return route.isFirst;
      // });
    });
  }

  @override
  void dispose() {
    widget.viewModel.clickedStation.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
      color: AppStyle.bgColor,
      child: SafeArea(
        child: Column(
          children: [
            searchView(widget.viewModel.searchText, (text) {
              widget.viewModel.inputSearchText(text);
            }, () {
              widget.viewModel.clearSearchText();
            }),
            Text("All:${widget.viewModel.allChannelCount}, Unknown:${widget.viewModel.unknownChannelCount}"),
            getListViewWidget()
          ],
        ),
      ),
    ));
  }

  TextEditingController textEditingController = TextEditingController();

  Widget searchView(String search, Function(String)? onSearchTextChanged,
      Function()? onClickSuffixIcon) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                FocusScope.of(context).unfocus();
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Icon(
                  Icons.arrow_back,
                  color: AppStyle.primaryColor,
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 50.0,
                child: TextField(
                  controller: textEditingController..text = search,
                  cursorColor: AppStyle.primaryColor,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: GestureDetector(
                          onTap: () {
                            onClickSuffixIcon?.call();
                            onSearchTextChanged?.call("");
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(Icons.close),
                          )),
                      hintText: "FM"),
                  onChanged: (text) {
                    onSearchTextChanged?.call(text);
                  },
                ),
              ),
            ),
          ]),
    );
  }

  Widget getListViewWidget() {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: List.generate(
            widget.viewModel.list.length,
            (index) => GestureDetector(
                onTap: () =>
                    widget.viewModel.onClickItem(widget.viewModel.list[index]),
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Image.network(
                              widget.viewModel.list[index].favicon,
                              fit: BoxFit.fitWidth,
                              width: 50,
                              height: 50,
                              errorBuilder: (
                                context,
                                error,
                                stackTrace,
                              ) {
                                return const Icon(
                                  Icons.broken_image_outlined,
                                  size: 50,
                                  color: Colors.white70,
                                );
                              },
                            )),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "(${widget.viewModel.list[index].votes})${widget.viewModel.list[index].name}",
                                style: AppStyle.defaultTextTitleStyle,
                              ),
                              // Expanded(
                              //   child:
                              Text(
                                widget.viewModel.list[index].url,
                                style: AppStyle.textTheme.bodySmall,
                              ),
                              // )
                            ],
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 20.0, right: 10.0),
                            child: getItemPlayStatue(
                              widget.viewModel.list[index],
                            )),
                      ],
                    )))),
      ),
    );
  }

  Widget getItemPlayStatue(VOStation station) {
    const double iconSize = 30;
    return StreamBuilder<bool>(
      stream: widget.playerViewModel.isPlayingController.stream,
      builder: (context, snapshot) {
        return GestureDetector(
          onTap: () {
            if (widget.playerViewModel.currentStation?.stationUUID ==
                station.stationUUID) {
              if (snapshot.data == true) {
                widget.playerViewModel.pause();
              } else {
                widget.playerViewModel.play();
              }
            } else {
              widget.viewModel.onClickItem(station);
            }
          },
          child: snapshot.data == true &&
                  widget.playerViewModel.currentStation?.stationUUID ==
                      station.stationUUID
              ? const Icon(
                  Icons.pause_circle_outline,
                  size: iconSize,
                  color: Colors.white70,
                )
              : const Icon(
                  Icons.play_circle_outline,
                  size: iconSize,
                  color: Colors.white70,
                ),
        );
      },
    );
  }
}
