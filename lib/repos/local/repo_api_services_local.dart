import 'dart:convert';
import 'dart:developer';

import 'package:iiiimusictv/repos/remote/api/dto/dto_radio_country.dart';
import 'package:iiiimusictv/extensions/shared_preferences_ext.dart';
import 'package:iiiimusictv/repos/remote/api/dto/dto_station.dart';
import 'package:iiiimusictv/repos/repo_api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RepoApiServicesLocal implements RepoApiServicesLocalInterface {
  Future<SharedPreferences> preferences = SharedPreferences.getInstance();

  static const String SP_COUNTRY_LIST = "SP_COUNTRY_LIST";
  static const String SP_STATION_LIST = "SP_STATION_LIST";

  @override
  Future<List<DTORadioCountry>> getCountryList() {
    return preferences.getString(SP_COUNTRY_LIST).then((onValue) {
      if (onValue.isEmpty) {
        return List.empty();
      }
      return (jsonDecode(onValue) as List)
          .map((el) => DTORadioCountry.fromJson(el))
          .toList();
    });
  }

  @override
  Future<void> setCountryList(List<DTORadioCountry> list) {
    return preferences.setString(SP_COUNTRY_LIST, jsonEncode(list));
  }

  @override
  Future<List<DTOStation>> getStationListByCodeExact(String codeExact) {
    return preferences.getString("${SP_STATION_LIST}_$codeExact").then((onValue) {
      if (onValue.isEmpty) {
        return List.empty();
      }
      return (jsonDecode(onValue) as List)
          .map((el) => DTOStation.fromJson(el))
          .toList();
    });
  }

  @override
  Future<void> setStationListByCodeExact(String codeExact, List<DTOStation> list) {
    return preferences.setString("${SP_STATION_LIST}_$codeExact", jsonEncode(list));
  }
}
