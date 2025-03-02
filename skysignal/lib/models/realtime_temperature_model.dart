class RealTimeTemperatureModel {
  Data? data;
  Location? location;

  RealTimeTemperatureModel({this.data, this.location});

  RealTimeTemperatureModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (location != null) {
      data['location'] = location!.toJson();
    }
    return data;
  }
}

class Data {
  String? time;
  Values? values;

  Data({this.time, this.values});

  Data.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    values = json['values'] != null ? Values.fromJson(json['values']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time'] = time;
    if (values != null) {
      data['values'] = values!.toJson();
    }
    return data;
  }
}

class Values {
  double? cloudBase;
  double? cloudCeiling;
  double? cloudCover;
  double? dewPoint;
  double? freezingRainIntensity;
  double? hailProbability;
  double? hailSize;
  double? humidity;
  double? precipitationProbability;
  double? pressureSeaLevel;
  double? pressureSurfaceLevel;
  double? rainIntensity;
  double? sleetIntensity;
  double? snowIntensity;
  double? temperature;
  double? temperatureApparent;
  double? uvHealthConcern;
  double? uvIndex;
  double? visibility;
  double? weatherCode;
  double? windDirection;
  double? windGust;
  double? windSpeed;

  Values({
    this.cloudBase,
    this.cloudCeiling,
    this.cloudCover,
    this.dewPoint,
    this.freezingRainIntensity,
    this.hailProbability,
    this.hailSize,
    this.humidity,
    this.precipitationProbability,
    this.pressureSeaLevel,
    this.pressureSurfaceLevel,
    this.rainIntensity,
    this.sleetIntensity,
    this.snowIntensity,
    this.temperature,
    this.temperatureApparent,
    this.uvHealthConcern,
    this.uvIndex,
    this.visibility,
    this.weatherCode,
    this.windDirection,
    this.windGust,
    this.windSpeed,
  });

  Values.fromJson(Map<String, dynamic> json) {
    cloudBase = _toDouble(json['cloudBase']);
    cloudCeiling = _toDouble(json['cloudCeiling']);
    cloudCover = _toDouble(json['cloudCover']);
    dewPoint = _toDouble(json['dewPoint']);
    freezingRainIntensity = _toDouble(json['freezingRainIntensity']);
    hailProbability = _toDouble(json['hailProbability']);
    hailSize = _toDouble(json['hailSize']);
    humidity = _toDouble(json['humidity']);
    precipitationProbability = _toDouble(json['precipitationProbability']);
    pressureSeaLevel = _toDouble(json['pressureSeaLevel']);
    pressureSurfaceLevel = _toDouble(json['pressureSurfaceLevel']);
    rainIntensity = _toDouble(json['rainIntensity']);
    sleetIntensity = _toDouble(json['sleetIntensity']);
    snowIntensity = _toDouble(json['snowIntensity']);
    temperature = _toDouble(json['temperature']);
    temperatureApparent = _toDouble(json['temperatureApparent']);
    uvHealthConcern = _toDouble(json['uvHealthConcern']);
    uvIndex = _toDouble(json['uvIndex']);
    visibility = _toDouble(json['visibility']);
    weatherCode = _toDouble(json['weatherCode']);
    windDirection = _toDouble(json['windDirection']);
    windGust = _toDouble(json['windGust']);
    windSpeed = _toDouble(json['windSpeed']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cloudBase'] = cloudBase;
    data['cloudCeiling'] = cloudCeiling;
    data['cloudCover'] = cloudCover;
    data['dewPoint'] = dewPoint;
    data['freezingRainIntensity'] = freezingRainIntensity;
    data['hailProbability'] = hailProbability;
    data['hailSize'] = hailSize;
    data['humidity'] = humidity;
    data['precipitationProbability'] = precipitationProbability;
    data['pressureSeaLevel'] = pressureSeaLevel;
    data['pressureSurfaceLevel'] = pressureSurfaceLevel;
    data['rainIntensity'] = rainIntensity;
    data['sleetIntensity'] = sleetIntensity;
    data['snowIntensity'] = snowIntensity;
    data['temperature'] = temperature;
    data['temperatureApparent'] = temperatureApparent;
    data['uvHealthConcern'] = uvHealthConcern;
    data['uvIndex'] = uvIndex;
    data['visibility'] = visibility;
    data['weatherCode'] = weatherCode;
    data['windDirection'] = windDirection;
    data['windGust'] = windGust;
    data['windSpeed'] = windSpeed;
    return data;
  }


  double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is int) return value.toDouble();
    if (value is double) return value;
    return double.tryParse(value.toString());
  }
}


class Location {
  double? lat;
  double? lon;
  String? name;
  String? type;

  Location({this.lat, this.lon, this.name, this.type});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lon'] = lon;
    data['name'] = name;
    data['type'] = type;
    return data;
  }
}
