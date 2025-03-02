class ForecastModel {
  final Location location;
  final Timelines timelines;

  ForecastModel({required this.location, required this.timelines});

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    return ForecastModel(
      location: Location.fromJson(json['location']),
      timelines: Timelines.fromJson(json['timelines']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location': location.toJson(),
      'timelines': timelines.toJson(),
    };
  }
}

class Location {
  final String name;
  final double lat;
  final double lon;

  Location({required this.name, required this.lat, required this.lon});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'],
      lat: json['lat'],
      lon: json['lon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lat': lat,
      'lon': lon,
    };
  }
}

class Timelines {
  final List<DailyForecast> daily;
  final List<HourlyForecast> hourly;

  Timelines({required this.daily, required this.hourly});

  factory Timelines.fromJson(Map<String, dynamic> json) {
    return Timelines(
      daily: (json['daily'] as List).map((i) => DailyForecast.fromJson(i)).toList(),
      hourly: (json['hourly'] as List).map((i) => HourlyForecast.fromJson(i)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'daily': daily.map((i) => i.toJson()).toList(),
      'hourly': hourly.map((i) => i.toJson()).toList(),
    };
  }
}

class DailyForecast {
  final DateTime time;
  final DailyWeatherValues values;

  DailyForecast({required this.time, required this.values});

  factory DailyForecast.fromJson(Map<String, dynamic> json) {
    return DailyForecast(
      time: DateTime.parse(json['time']),
      values: DailyWeatherValues.fromJson(json['values']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time.toIso8601String(),
      'values': values.toJson(),
    };
  }
}

class HourlyForecast {
  final DateTime time;
  final HourlyWeatherValues values;

  HourlyForecast({required this.time, required this.values});

  factory HourlyForecast.fromJson(Map<String, dynamic> json) {
    return HourlyForecast(
      time: DateTime.parse(json['time']),
      values: HourlyWeatherValues.fromJson(json['values']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time.toIso8601String(),
      'values': values.toJson(),
    };
  }
}


class DailyWeatherValues {
  final double cloudBaseAvg;
  final double cloudBaseMax;
  final double cloudBaseMin;
  final double cloudCeilingAvg;
  final double cloudCeilingMax;
  final double cloudCeilingMin;
  final double cloudCoverAvg;
  final double cloudCoverMax;
  final double cloudCoverMin;
  final double dewPointAvg;
  final double dewPointMax;
  final double dewPointMin;
  final double temperatureAvg;
  final double temperatureMax;
  final double temperatureMin;
  final double windSpeedAvg;
  final double windSpeedMax;
  final double windSpeedMin;
  final DateTime sunriseTime;
  final DateTime sunsetTime;
  final DateTime moonriseTime;
  final DateTime moonsetTime;

  DailyWeatherValues({
    required this.cloudBaseAvg,
    required this.cloudBaseMax,
    required this.cloudBaseMin,
    required this.cloudCeilingAvg,
    required this.cloudCeilingMax,
    required this.cloudCeilingMin,
    required this.cloudCoverAvg,
    required this.cloudCoverMax,
    required this.cloudCoverMin,
    required this.dewPointAvg,
    required this.dewPointMax,
    required this.dewPointMin,
    required this.temperatureAvg,
    required this.temperatureMax,
    required this.temperatureMin,
    required this.windSpeedAvg,
    required this.windSpeedMax,
    required this.windSpeedMin,
    required this.sunriseTime,
    required this.sunsetTime,
    required this.moonriseTime,
    required this.moonsetTime,
  });


  factory DailyWeatherValues.fromJson(Map<String, dynamic> json) {
    return DailyWeatherValues(
      cloudBaseAvg: (json['cloudBaseAvg'] ?? 0.0).toDouble(),
      cloudBaseMax: (json['cloudBaseMax'] ?? 0.0).toDouble(),
      cloudBaseMin: (json['cloudBaseMin'] ?? 0.0).toDouble(),
      cloudCeilingAvg: (json['cloudCeilingAvg'] ?? 0.0).toDouble(),
      cloudCeilingMax: (json['cloudCeilingMax'] ?? 0.0).toDouble(),
      cloudCeilingMin: (json['cloudCeilingMin'] ?? 0.0).toDouble(),
      cloudCoverAvg: (json['cloudCoverAvg'] ?? 0.0).toDouble(),
      cloudCoverMax: (json['cloudCoverMax'] ?? 0.0).toDouble(),
      cloudCoverMin: (json['cloudCoverMin'] ?? 0.0).toDouble(),
      dewPointAvg: (json['dewPointAvg'] ?? 0.0).toDouble(),
      dewPointMax: (json['dewPointMax'] ?? 0.0).toDouble(),
      dewPointMin: (json['dewPointMin'] ?? 0.0).toDouble(),
      temperatureAvg: (json['temperatureAvg'] ?? 0.0).toDouble(),
      temperatureMax: (json['temperatureMax'] ?? 0.0).toDouble(),
      temperatureMin: (json['temperatureMin'] ?? 0.0).toDouble(),
      windSpeedAvg: (json['windSpeedAvg'] ?? 0.0).toDouble(),
      windSpeedMax: (json['windSpeedMax'] ?? 0.0).toDouble(),
      windSpeedMin: (json['windSpeedMin'] ?? 0.0).toDouble(),
      sunriseTime: json['sunriseTime'] != null ? DateTime.parse(json['sunriseTime']) : DateTime.now(),
      sunsetTime: json['sunsetTime'] != null ? DateTime.parse(json['sunsetTime']) : DateTime.now(),
      moonriseTime: json['moonriseTime'] != null ? DateTime.parse(json['moonriseTime']) : DateTime.now(),
      moonsetTime: json['moonsetTime'] != null ? DateTime.parse(json['moonsetTime']) : DateTime.now(),
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'cloudBaseAvg': cloudBaseAvg,
      'cloudBaseMax': cloudBaseMax,
      'cloudBaseMin': cloudBaseMin,
      'cloudCeilingAvg': cloudCeilingAvg,
      'cloudCeilingMax': cloudCeilingMax,
      'cloudCeilingMin': cloudCeilingMin,
      'cloudCoverAvg': cloudCoverAvg,
      'cloudCoverMax': cloudCoverMax,
      'cloudCoverMin': cloudCoverMin,
      'dewPointAvg': dewPointAvg,
      'dewPointMax': dewPointMax,
      'dewPointMin': dewPointMin,
      'temperatureAvg': temperatureAvg,
      'temperatureMax': temperatureMax,
      'temperatureMin': temperatureMin,
      'windSpeedAvg': windSpeedAvg,
      'windSpeedMax': windSpeedMax,
      'windSpeedMin': windSpeedMin,
      'sunriseTime': sunriseTime.toIso8601String(),
      'sunsetTime': sunsetTime.toIso8601String(),
      'moonriseTime': moonriseTime.toIso8601String(),
      'moonsetTime': moonsetTime.toIso8601String(),
    };
  }
}

class HourlyWeatherValues {
  final double? cloudBase;
  final double? cloudCeiling;
  final double cloudCover;
  final double dewPoint;
  final double evapotranspiration;
  final double freezingRainIntensity;
  final double hailProbability;
  final double hailSize;
  final double humidity;
  final double iceAccumulation;
  final double iceAccumulationLwe;
  final double precipitationProbability;
  final double pressureSeaLevel;
  final double pressureSurfaceLevel;
  final double rainAccumulation;
  final double rainAccumulationLwe;
  final double rainIntensity;
  final double sleetAccumulation;
  final double sleetAccumulationLwe;
  final double sleetIntensity;
  final double snowAccumulation;
  final double snowAccumulationLwe;
  final double snowIntensity;
  final double temperature;
  final double temperatureApparent;
  final double uvHealthConcern;
  final double uvIndex;
  final double visibility;
  final int weatherCode;
  final double windDirection;
  final double windGust;
  final double windSpeed;

  HourlyWeatherValues({
    this.cloudBase,
    this.cloudCeiling,
    required this.cloudCover,
    required this.dewPoint,
    required this.evapotranspiration,
    required this.freezingRainIntensity,
    required this.hailProbability,
    required this.hailSize,
    required this.humidity,
    required this.iceAccumulation,
    required this.iceAccumulationLwe,
    required this.precipitationProbability,
    required this.pressureSeaLevel,
    required this.pressureSurfaceLevel,
    required this.rainAccumulation,
    required this.rainAccumulationLwe,
    required this.rainIntensity,
    required this.sleetAccumulation,
    required this.sleetAccumulationLwe,
    required this.sleetIntensity,
    required this.snowAccumulation,
    required this.snowAccumulationLwe,
    required this.snowIntensity,
    required this.temperature,
    required this.temperatureApparent,
    required this.uvHealthConcern,
    required this.uvIndex,
    required this.visibility,
    required this.weatherCode,
    required this.windDirection,
    required this.windGust,
    required this.windSpeed,
  });


  factory HourlyWeatherValues.fromJson(Map<String, dynamic> json) {
    return HourlyWeatherValues(
      cloudBase: json['cloudBase'] != null ? json['cloudBase'].toDouble() : 0.0,
      cloudCeiling: json['cloudCeiling'] != null ? json['cloudCeiling'].toDouble() : 0.0,
      cloudCover: (json['cloudCover'] ?? 0.0).toDouble(),
      dewPoint: (json['dewPoint'] ?? 0.0).toDouble(),
      evapotranspiration: (json['evapotranspiration'] ?? 0.0).toDouble(),
      freezingRainIntensity: (json['freezingRainIntensity'] ?? 0.0).toDouble(),
      hailProbability: (json['hailProbability'] ?? 0.0).toDouble(),
      hailSize: (json['hailSize'] ?? 0.0).toDouble(),
      humidity: (json['humidity'] ?? 0.0).toDouble(),
      iceAccumulation: (json['iceAccumulation'] ?? 0.0).toDouble(),
      iceAccumulationLwe: (json['iceAccumulationLwe'] ?? 0.0).toDouble(),
      precipitationProbability: (json['precipitationProbability'] ?? 0.0).toDouble(),
      pressureSeaLevel: (json['pressureSeaLevel'] ?? 1013.0).toDouble(),
      pressureSurfaceLevel: (json['pressureSurfaceLevel'] ?? 1013.0).toDouble(),
      rainAccumulation: (json['rainAccumulation'] ?? 0.0).toDouble(),
      rainAccumulationLwe: (json['rainAccumulationLwe'] ?? 0.0).toDouble(),
      rainIntensity: (json['rainIntensity'] ?? 0.0).toDouble(),
      sleetAccumulation: (json['sleetAccumulation'] ?? 0.0).toDouble(),
      sleetAccumulationLwe: (json['sleetAccumulationLwe'] ?? 0.0).toDouble(),
      sleetIntensity: (json['sleetIntensity'] ?? 0.0).toDouble(),
      snowAccumulation: (json['snowAccumulation'] ?? 0.0).toDouble(),
      snowAccumulationLwe: (json['snowAccumulationLwe'] ?? 0.0).toDouble(),
      snowIntensity: (json['snowIntensity'] ?? 0.0).toDouble(),
      temperature: (json['temperature'] ?? 0.0).toDouble(),
      temperatureApparent: (json['temperatureApparent'] ?? 0.0).toDouble(),
      uvHealthConcern: (json['uvHealthConcern'] ?? 0.0).toDouble(),
      uvIndex: (json['uvIndex'] ?? 0.0).toDouble(),
      visibility: (json['visibility'] ?? 1.0).toDouble(),
      weatherCode: json['weatherCode'] ?? 0,
      windDirection: (json['windDirection'] ?? 0.0).toDouble(),
      windGust: (json['windGust'] ?? 0.0).toDouble(),
      windSpeed: (json['windSpeed'] ?? 0.0).toDouble(),
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'cloudBase': cloudBase,
      'cloudCeiling': cloudCeiling,
      'cloudCover': cloudCover,
      'dewPoint': dewPoint,
      'evapotranspiration': evapotranspiration,
      'freezingRainIntensity': freezingRainIntensity,
      'hailProbability': hailProbability,
      'hailSize': hailSize,
      'humidity': humidity,
      'iceAccumulation': iceAccumulation,
      'iceAccumulationLwe': iceAccumulationLwe,
      'precipitationProbability': precipitationProbability,
      'pressureSeaLevel': pressureSeaLevel,
      'pressureSurfaceLevel': pressureSurfaceLevel,
      'rainAccumulation': rainAccumulation,
      'rainAccumulationLwe': rainAccumulationLwe,
      'rainIntensity': rainIntensity,
      'sleetAccumulation': sleetAccumulation,
      'sleetAccumulationLwe': sleetAccumulationLwe,
      'sleetIntensity': sleetIntensity,
      'snowAccumulation': snowAccumulation,
      'snowAccumulationLwe': snowAccumulationLwe,
      'snowIntensity': snowIntensity,
      'temperature': temperature,
      'temperatureApparent': temperatureApparent,
      'uvHealthConcern': uvHealthConcern,
      'uvIndex': uvIndex,
      'visibility': visibility,
      'weatherCode': weatherCode,
      'windDirection': windDirection,
      'windGust': windGust,
      'windSpeed': windSpeed,
    };
  }
}

