import 'dart:developer';

import 'package:iiiimusictv/repos/remote/api/api_services_interface.dart';
import 'package:iiiimusictv/repos/remote/api/dto/dto_radio_country.dart';
import 'package:iiiimusictv/repos/remote/api/dto/dto_station.dart';

class RepoApiServices implements RepoApiServicesInterface {
  RepoApiServicesLocalInterface local;
  ApiServicesInterface remote;

  RepoApiServices({required this.local, required this.remote});

  @override
  Future<List<DTORadioCountry>> fetchCountryList() {
    return local.getCountryList().then((onValue) {
      if (onValue.isEmpty) {
        return remote.fetchCountryList().then((onRemoteValue) {
          local.setCountryList(onRemoteValue);
          return onRemoteValue;
        });
      } else {
        return Future.value(onValue);
      }
    });
  }

  @override
  Future<List<DTOStation>> fetchStationListByCodeExact(String codeExact) {
    return local.getStationListByCodeExact(codeExact).then((onValue) {
      if (onValue.isEmpty) {
        return remote.fetchStationListByCodeExact(codeExact).then((onRemoteValue) {
          local.setStationListByCodeExact(codeExact, onRemoteValue);
          return onRemoteValue;
        });
      } else {
        return Future.value(onValue);
      }
    });
  }
}

abstract class RepoApiServicesInterface {
  Future<List<DTORadioCountry>> fetchCountryList();
  Future<List<DTOStation>> fetchStationListByCodeExact(String codeExact);
}

abstract class RepoApiServicesLocalInterface {
  Future<List<DTORadioCountry>> getCountryList();
  Future<void> setCountryList(List<DTORadioCountry> list);
  Future<List<DTOStation>> getStationListByCodeExact(String codeExact);
  Future<void> setStationListByCodeExact(String codeExact, List<DTOStation> list);
}
