import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:iiiimusictv/repos/remote/api/api_services_interface.dart';
import 'package:iiiimusictv/repos/remote/api/dto/dto_radio_country.dart';
import 'package:iiiimusictv/repos/remote/api/dto/dto_station.dart';

class ApiServices extends ApiServicesInterface {
  static const isDebug = true;
  static const isDebugJson = true;
  static final ApiServices _singleton = ApiServices._internal();

  ApiServices._internal();

  factory ApiServices() {
    return _singleton;
  }

  Future<http.Response> get(String url) {
    if (isDebugJson) {
      log('response--start $url');
    }
    return http.get(Uri.parse(url)).then((response) {
        if (isDebug) {
          var outputInfo = "status=${response.statusCode} $url";
          if (isDebugJson) {
            log('response--start $outputInfo \n${response.body}\nresponse--end $outputInfo');
          } else {
            log('response--start $outputInfo \nresponse--end $outputInfo');
          }
        }
        return response;
    });
  }

  @override
  Future<List<DTORadioCountry>> fetchCountryList() {
    final Future<http.Response> response = get('http://de1.api.radio-browser.info/json/countries');
    return response.then((response) {
      if (response.statusCode == 200) {
        return (jsonDecode(response.body) as List)
            .map((el) => DTORadioCountry.fromJson(el))
            .toList();
      } else {
        throw Exception('Failed to load fetchCountryList');
      }
    });
  }

  @override
  Future<List<DTOStation>> fetchStationListByCountry(String countryName) {
    final Future<http.Response> response = get('http://de1.api.radio-browser.info/json/stations/bycountry/$countryName');
    return response.then((response) {
      if (response.statusCode == 200) {
        return (jsonDecode(response.body) as List)
            .map((el) => DTOStation.fromJson(el))
            .toList();
      } else {
        throw Exception('Failed to load fetchStationByCountry');
      }
    });
  }

  @override
  Future<List<DTOStation>> fetchStationListByCodeExact(String codeExact) {
    final Future<http.Response> response = get('http://de1.api.radio-browser.info/json/stations/bycountrycodeexact/$codeExact');
    return response.then((response) {
      if (response.statusCode == 200) {
        return (jsonDecode(response.body) as List)
            .map((el) => DTOStation.fromJson(el))
            .toList();
      } else {
        throw Exception('Failed to load fetchStationByCountry');
      }
    });
  }
}
