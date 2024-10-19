import 'package:flutter/material.dart';
import 'package:iiiimusictv/app_style.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MaterialApp(
      home: Scaffold(
    backgroundColor: Colors.black,
    body: const SliderBarView(),
  )));
}

class SliderBarView extends StatelessWidget {
  final double currentPos = 0.0;
  final double startPosition = 0.0;
  final String startTime = "00:00";
  final String endTime = "00:00";
  final Function(double)? onChanged;

  const SliderBarView({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SliderTheme(
          data: SliderThemeData(
            thumbColor: Colors.white,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
            inactiveTrackColor: AppStyle.primaryColor,
            activeTrackColor: Colors.white,
            trackHeight: 1.0,
          ),
          child: Slider(
            value: currentPos,
            onChanged: (value) {
              // 拖动改变进度
              // widget.onChangeSliderBarValue?.call(value);
              onChanged?.call(value);
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              startTime,
              style: AppStyle.defaultTextStyle,
            ),
            Text(
              endTime,
              style: AppStyle.defaultTextStyle,
            ),
          ],
        ),
      ],
    );
  }
}
