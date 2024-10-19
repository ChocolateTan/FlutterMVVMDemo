import 'package:iiiimusictv/vo_models/vo_station.dart';

class DTOStation {
  final String changeUUID;
  final String stationUUID;
  final String? serverUUID;
  final String name;
  final String url;
  final String urlResolved;
  final String homepage;
  final String favicon;
  final String tags;
  final String country;
  final String countryCode;
  final String iso_3166_2;
  final String state;
  final String language;
  final String languageCodes;
  final int votes;
  final String lastChangeTime;
  final String lastChangeTimeISO8601;
  final String codec;
  final int bitrate;
  final int hls;
  final int lastCheckOK;
  final String lastCheckTime;
  final String lastCheckTimeISO8601;
  final String lastCheckOKTime;
  final String lastCheckOKTimeISO8601;
  final String lastLocalCheckTime;
  final String lastLocalCheckTimeISO8601;
  final String clickTimestamp;
  final String clickTimestampISO8601;
  final int clickCount;
  final int clickTrend;
  final int sslError;
  final double? geoLat;
  final double? geoLong;
  final bool hasExtendedInfo;

  DTOStation(
      {required this.changeUUID,
      required this.stationUUID,
      required this.serverUUID,
      required this.name,
      required this.url,
      required this.urlResolved,
      required this.homepage,
      required this.favicon,
      required this.tags,
      required this.country,
      required this.countryCode,
      required this.iso_3166_2,
      required this.state,
      required this.language,
      required this.languageCodes,
      required this.votes,
      required this.lastChangeTime,
      required this.lastChangeTimeISO8601,
      required this.codec,
      required this.bitrate,
      required this.hls,
      required this.lastCheckOK,
      required this.lastCheckTime,
      required this.lastCheckTimeISO8601,
      required this.lastCheckOKTime,
      required this.lastCheckOKTimeISO8601,
      required this.lastLocalCheckTime,
      required this.lastLocalCheckTimeISO8601,
      required this.clickTimestamp,
      required this.clickTimestampISO8601,
      required this.clickCount,
      required this.clickTrend,
      required this.sslError,
      required this.geoLat,
      required this.geoLong,
      required this.hasExtendedInfo});

  factory DTOStation.fromJson(Map<String, dynamic> json) {
    return DTOStation(
      changeUUID: json["changeuuid"]??"",
      stationUUID: json["stationuuid"]??"",
      serverUUID: json["serveruuid"]??"",
      name: json["name"]??"",
      url: json["url"]??"",
      urlResolved: json["url_resolved"]??"",
      homepage: json["homepage"]??"",
      favicon: json["favicon"]??"",
      tags: json["tags"]??"",
      country: json["country"]??"",
      countryCode: json["countrycode"]??"",
      iso_3166_2: json["iso_3166_2"]??"",
      state: json["state"]??"",
      language: json["language"]??"",
      languageCodes: json["languagecodes"]??"",
      votes: json["votes"]??"",
      lastChangeTime: json["lastchangetime"]??"",
      lastChangeTimeISO8601: json["lastchangetime_iso8601"]??"",
      codec: json["codec"]??"",
      bitrate: json["bitrate"]??"",
      hls: json["hls"]??"",
      lastCheckOK: json["lastcheckok"]??"",
      lastCheckTime: json["lastchecktime"]??"",
      lastCheckTimeISO8601: json["lastchecktime_iso8601"]??"",
      lastCheckOKTime: json["lastcheckoktime"]??"",
      lastCheckOKTimeISO8601: json["lastcheckoktime_iso8601"]??"",
      lastLocalCheckTime: json["lastlocalchecktime"]??"",
      lastLocalCheckTimeISO8601: json["lastlocalchecktime_iso8601"]??"",
      clickTimestamp: json["clicktimestamp"]??"",
      clickTimestampISO8601: json["clicktimestamp_iso8601"]??"",
      clickCount: json["clickcount"]??"",
      clickTrend: json["clicktrend"]??"",
      sslError: json["ssl_error"]??"",
      geoLat: json["geo_lat"],
      geoLong: json["geo_long"],
      hasExtendedInfo: json["has_extended_info"]??"",
    );
  }
  Map<String, dynamic> toJson() => {
      "changeuuid": changeUUID,
      "stationuuid": stationUUID,
      "serveruuid": serverUUID,
      "name": name,
      "url": url,
      "url_resolved": urlResolved,
      "homepage": homepage,
      "favicon": favicon,
      "tags": tags,
      "country": country,
      "countrycode": countryCode,
      "iso_3166_2": iso_3166_2,
      "state": state,
      "language": language,
      "languagecodes": languageCodes,
      "votes": votes,
      "lastchangetime": lastChangeTime,
      "lastchangetime_iso8601": lastChangeTimeISO8601,
      "codec": codec,
      "bitrate": bitrate,
      "hls": hls,
      "lastcheckok": lastCheckOK,
      "lastchecktime": lastCheckTime,
      "lastchecktime_iso8601": lastCheckTimeISO8601,
      "lastcheckoktime": lastCheckOKTime,
      "lastcheckoktime_iso8601": lastCheckOKTimeISO8601,
      "lastlocalchecktime": lastLocalCheckTime,
      "lastlocalchecktime_iso8601": lastLocalCheckTimeISO8601,
      "clicktimestamp": clickTimestamp,
      "clicktimestamp_iso8601": clickTimestampISO8601,
      "clickcount": clickCount,
      "clicktrend": clickTrend,
      "ssl_error": sslError,
      "geo_lat": geoLat,
      "geo_long": geoLong,
      "has_extended_info": hasExtendedInfo
  };
}

extension DTOStationExtension on DTOStation {
  VOStation toVOStation() {
    return VOStation(
      stationUUID,
      name,
      url,
      urlResolved,
      country,
      countryCode,
      language,
      languageCodes,
      state,
      geoLat,
      geoLong,
      favicon,
      homepage,
      tags,
      votes,
    );
  }
}
