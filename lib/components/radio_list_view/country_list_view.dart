import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:iiiimusictv/repos/local/repo_api_services_local.dart';
import 'package:iiiimusictv/repos/remote/api/api_services.dart';
import 'package:iiiimusictv/app_style.dart';
import 'package:iiiimusictv/components/radio_list_view/station_list_view.dart';
import 'package:iiiimusictv/components/radio_list_view/station_list_view_model.dart';
import 'package:iiiimusictv/components/radio_list_view/country_list_view_model.dart';
import 'package:iiiimusictv/repos/repo_api_services.dart';
import 'package:iiiimusictv/viewmodels/video_player_view_model.dart';
import 'package:iiiimusictv/vo_models/vo_radio_country.dart';
import 'package:provider/provider.dart';

class CountryListView extends StatefulWidget {
  CountryListViewModel viewModel;
  VideoPlayerViewModel playerViewModel;

  CountryListView(
      {super.key, required this.viewModel, required this.playerViewModel});

  // RadioListView({key, require this.viewModel, require this.radioPlayerViewModel});
  // RadioListView(this.viewModel, this.radioPlayerViewModel, {super.key});

  @override
  State<StatefulWidget> createState() => _CountryListViewState();
}

class _CountryListViewState extends State<CountryListView> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: AppStyle.bgColor,
        child: SafeArea(
            child: Column(mainAxisSize: MainAxisSize.max, children: [
          searchView(widget.viewModel.searchText, (text) {
            widget.viewModel.inputSearchText(text);
          }, () {
            widget.viewModel.clearSearchText();
          }),
          Expanded(
              child: ListView.builder(
                  itemCount: widget.viewModel.list.length,
                  itemBuilder: (context, index) {
                    final item = widget.viewModel.list[index];
                    return listItem(item);
                  }))
        ])),
      ),
    );
  }

  Widget listItem(VORadioCountry data) {
    return GestureDetector(
      onTap: () {
        log('data=${data.countryName}');
        FocusScope.of(context).unfocus();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MultiProvider(
                        providers: [
                          ChangeNotifierProvider(
                              create: (context) => StationListInfoViewModel(
                                  RepoApiServices(local: RepoApiServicesLocal(), remote: ApiServices()),
                                  data.countryName,
                                  data.countryCode)),
                        ],
                        child: Consumer<StationListInfoViewModel>(
                          builder: (context, vm, child) {
                            return StationListInfoView(
                              countryName: data.countryName,
                              viewModel: vm,
                              playerViewModel: widget.playerViewModel,
                            );
                          },
                        ))));
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          "${data.countryName}(${data.countryCode}) stations:${data.stationCount}",
          style: AppStyle.defaultTextStyle,
        ),
      ),
    );
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
              FocusScope.of(context).unfocus();
              Navigator.pop(context);
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
                      hintText: "China"),
                  onChanged: (text) {
                    onSearchTextChanged?.call(text);
                  })),
        ],
      ),
    );
  }
}
