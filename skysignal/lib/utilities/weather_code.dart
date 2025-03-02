import 'package:weather_icons/weather_icons.dart';
import 'package:flutter/material.dart';

class WeatherCode {
  static IconData getWeatherIcon(int weatherCode, bool isDaytime) {
    if (isDaytime) {
      return _dayIcons[weatherCode] ?? WeatherIcons.day_sunny;
    } else {
      return _nightIcons[weatherCode] ?? WeatherIcons.night_clear;
    }
  }

  static final Map<int, IconData> _dayIcons = {
    1000: WeatherIcons.day_sunny,
    1100: WeatherIcons.day_cloudy,
    1101: WeatherIcons.day_cloudy_high,
    1102: WeatherIcons.day_sunny_overcast,
    1001: WeatherIcons.cloudy,
    2000: WeatherIcons.fog,
    2100: WeatherIcons.fog,
    4000: WeatherIcons.day_showers,
    4001: WeatherIcons.day_rain,
    4200: WeatherIcons.day_rain_mix,
    4201: WeatherIcons.day_rain_wind,
    5000: WeatherIcons.day_snow,
    5001: WeatherIcons.day_snow_wind,
    5100: WeatherIcons.day_snow,
    5101: WeatherIcons.day_snow_thunderstorm,
    6000: WeatherIcons.sleet,
    6001: WeatherIcons.day_sleet_storm,
    6200: WeatherIcons.day_sleet,
    6201: WeatherIcons.day_sleet,
    7000: WeatherIcons.hail,
    7101: WeatherIcons.hail,
    7102: WeatherIcons.hail,
    8000: WeatherIcons.day_thunderstorm
  };

  static final Map<int, IconData> _nightIcons = {
    1000: WeatherIcons.night_clear,
    1100: WeatherIcons.night_alt_cloudy,
    1101: WeatherIcons.night_alt_cloudy_high,
    1102: WeatherIcons.night_alt_partly_cloudy,
    1001: WeatherIcons.cloudy,
    2000: WeatherIcons.fog,
    2100: WeatherIcons.fog,
    4000: WeatherIcons.night_alt_showers,
    4001: WeatherIcons.night_alt_rain,
    4200: WeatherIcons.night_alt_rain_mix,
    4201: WeatherIcons.night_alt_rain_wind,
    5000: WeatherIcons.night_alt_snow,
    5001: WeatherIcons.night_alt_snow_wind,
    5100: WeatherIcons.night_alt_snow,
    5101: WeatherIcons.night_alt_snow_thunderstorm,
    6000: WeatherIcons.sleet,
    6001: WeatherIcons.night_alt_sleet_storm,
    6200: WeatherIcons.night_alt_sleet,
    6201: WeatherIcons.night_alt_sleet,
    7000: WeatherIcons.hail,
    7101: WeatherIcons.hail,
    7102: WeatherIcons.hail,
    8000: WeatherIcons.night_alt_thunderstorm
  };

  static String getWeatherCondition(int weatherCode) {
    Map<int, String> conditions = {
      0: "Unknown",
      1000: "Clear",
      1100: "Mostly Clear",
      1101: "Partly Cloudy",
      1102: "Mostly Cloudy",
      1001: "Cloudy",
      2000: "Fog",
      2100: "Light Fog",
      4000: "Drizzle",
      4001: "Rain",
      4200: "Light Rain",
      4201: "Heavy Rain",
      5000: "Snow",
      5001: "Flurries",
      5100: "Light Snow",
      5101: "Heavy Snow",
      6000: "Freezing Drizzle",
      6001: "Freezing Rain",
      6200: "Light Freezing Rain",
      6201: "Heavy Freezing Rain",
      7000: "Ice Pellets",
      7101: "Heavy Ice Pellets",
      7102: "Light Ice Pellets",
      8000: "Thunderstorm"
    };
    return conditions[weatherCode] ?? "Unknown";
  }
}
