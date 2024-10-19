import 'package:flutter/material.dart';
import 'package:iiiimusictv/app_style.dart';
import 'package:iiiimusictv/components/player_view.dart';
import 'package:iiiimusictv/viewmodels/video_player_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: AppStyle.primaryColor,
          textTheme: AppStyle.textTheme,
          textSelectionTheme: AppStyle.textSelectionThemeData,
          inputDecorationTheme: AppStyle.inputDecorationTheme),
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          decoration: const BoxDecoration(),
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                  create: (context) => VideoPlayerViewModel()),
            ],
            child: Consumer<VideoPlayerViewModel>(
              builder: (BuildContext context, VideoPlayerViewModel value,
                  Widget? child) {
                return PlayerView(
                  playerViewModel: value,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
