class VOStation {
  String stationUUID;
  String name;
  String url;
  String urlResolved;
  String country;
  String countryCode;
  String language;
  String languageCodes;
  String state;
  double? geoLat;
  double? geoLong;
  String favicon;
  String homepage;
  String tags;
  int votes;

  VOStation(
    this.stationUUID,
    this.name,
    this.url,
    this.urlResolved,
    this.country,
    this.countryCode,
    this.language,
    this.languageCodes,
    this.state,
    this.geoLat,
    this.geoLong,
    this.favicon,
    this.homepage,
    this.tags,
      this.votes,
  );
}

// extension RadioCountryExtensions on RadioCountry {
//   RadioCountry create() {
//     return RadioCountry(
//
//     );
//   }
// }
