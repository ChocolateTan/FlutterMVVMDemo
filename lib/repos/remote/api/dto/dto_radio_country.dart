import 'package:iiiimusictv/vo_models/vo_radio_country.dart';

class DTORadioCountry {
  final String name;
  final String iso_3166_1;
  final int stationCount;

  DTORadioCountry(
      {required this.name,
      required this.iso_3166_1,
      required this.stationCount});

  factory DTORadioCountry.fromJson(Map<String, dynamic> json) {
    return DTORadioCountry(
      name: json["name"],
      iso_3166_1: json["iso_3166_1"],
      stationCount: json["stationcount"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "iso_3166_1": iso_3166_1,
        "stationcount": stationCount,
      };
}

extension DTORadioCountryExtension on DTORadioCountry {
  VORadioCountry toVORadioCountry() {
    return VORadioCountry(name, iso_3166_1, stationCount);
  }
}
