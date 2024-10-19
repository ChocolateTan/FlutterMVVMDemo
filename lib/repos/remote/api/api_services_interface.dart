import 'package:iiiimusictv/repos/remote/api/dto/dto_radio_country.dart';
import 'package:iiiimusictv/repos/remote/api/dto/dto_station.dart';

abstract class ApiServicesInterface {
  Future<List<DTORadioCountry>> fetchCountryList();
  Future<List<DTOStation>> fetchStationListByCountry(String countryName);
  Future<List<DTOStation>> fetchStationListByCodeExact(String codeExact);
}