import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:skysignal/models/forecast_model.dart';
import 'package:skysignal/models/realtime_temperature_model.dart';
import 'package:skysignal/provider/theme_provider.dart';
import 'package:skysignal/reuse_widgets/loading_shimmer.dart';
import 'package:skysignal/utilities/weather_code.dart';
import 'package:weather_icons/weather_icons.dart';
import '../view_models/forecast_view_model_controller.dart';
import '../view_models/realtime_temp_view_model_controller.dart';

class BuildHomeUi extends StatefulWidget {

  final String location;
  const BuildHomeUi({super.key, required this.location});
  @override
  State<BuildHomeUi> createState() => _BuildHomeUiState();

}

class _BuildHomeUiState extends State<BuildHomeUi> {

  final RealtimeTempViewModelController realTempController = Get.put(RealtimeTempViewModelController());
  final ForecastViewModelController forecastController = Get.put(ForecastViewModelController());

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      fetchWeatherData();
    });
  }

  void fetchWeatherData() {
    realTempController.fetchRealTempData(widget.location);
    forecastController.fetchForecastData(widget.location);
  }


  DateTime _parseDateTime(dynamic time) {
    if (time is String) {
      return DateTime.parse(time).toUtc();
    } else if (time is DateTime) {
      return time.toUtc();
    } else {
      throw ArgumentError('Invalid time format');
    }
  }


  String getWindDirection(double degrees) {
    if (degrees >= 0 && degrees < 22.5) {
      return 'North';
    }else if(degrees>= 22.5 && degrees< 67.5) {
      return 'North East';
    }else if(degrees>= 67.5 && degrees< 112.5) {
      return 'East';
    }else if(degrees>= 112.5 && degrees< 157.5) {
      return 'South East';
    }else if(degrees>= 157.5 && degrees< 202.5) {
      return 'South';
    }else if(degrees>= 202.5 && degrees< 247.5) {
      return 'South West';
    }else if(degrees>= 247.5 && degrees< 292.5) {
      return 'West';
    }else if(degrees>= 292.5 && degrees< 337.5) {
      return 'North West';
    }else if(degrees>= 337.5 && degrees<= 360) {
      return 'North';
    } else {
      return 'Invalid direction';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: const Text("SkySignal"),backgroundColor: Theme.of(context).secondaryHeaderColor,),
      extendBodyBehindAppBar: true,

      body: SafeArea(
        child: Stack(
          children: [

            Consumer<ThemeProvider>(
              builder: (context, value, widget) {
                return Container(
                  width: Get.width,
                  height: Get.height,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: value.changeTheme == ThemeMode.light? [const Color(0xfffff1eb), const Color(0xfface0f9)] // Light theme gradient colors
                          :[const Color(0xff434343), const Color(0xff000000)], // Dark theme gradient colors
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                );
              },
            ),


            Obx((){
            if (realTempController.isLoading.value || forecastController.isLoading.value) {
              return const LoadingShimmer();
            }

            final realTemp = realTempController.realTimeTemp.value;
            final forecastData = forecastController.forecastData.value;

            if (realTemp == null || forecastData == null) {
              return const LoadingShimmer();
            }


            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  weatherTemperatureCard(realTemp),

                  _buildSectionTitle("24 Hours forecast(UTC)"),

                  forecast24Hours(forecastData.timelines.hourly),

                  _buildSectionTitle("⏲️ Daily forecast"),

                  forecast6Days(forecastData.timelines.daily),

                  _buildSectionTitle("Weather details"),

                  otherWeatherThings(realTemp),

                ],
              ),
            );
          }),
           ]
        ),
      ),
    );
  }


  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }



  Widget weatherTemperatureCard(RealTimeTemperatureModel realTemp) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: GetBuilder<ForecastViewModelController>(
        builder: (controller) {

          int weatherCode = realTemp.data?.values?.weatherCode?.toInt() ?? 1000;
          bool isDay = controller.isDaytimeNow.value;
          IconData weatherIcon = WeatherCode.getWeatherIcon(weatherCode, isDay);
          String weatherDescription = WeatherCode.getWeatherCondition(weatherCode);
          String locationName = realTemp.location?.name?.trim() ?? 'Unknown Location';

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
            child: ListTile(
              leading: BoxedIcon(weatherIcon, size: 35, color: Colors.blue),
              title: Text('Temperature: ${realTemp.data?.values?.temperature?.toStringAsFixed(1) ?? 'N/A'}°C',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Location: $locationName',
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400), // Prevents overflow
                  ),
                  Text("Weather: $weatherDescription",
                    style: const TextStyle(fontSize: 16,color: Colors.pink),
                  ),
                ],
              ),
            )
          );
        },
      ),
    );
  }


  Widget forecast24Hours(List<HourlyForecast> hourlyData) {
    return SizedBox(
      height: Get.height * 0.25,
      child: GetBuilder<ForecastViewModelController>(
        builder: (controller) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 24,
            itemBuilder: (context, index) {

              final hours = hourlyData[index];
              final DateTime dateTimeUTC = _parseDateTime(hours.time).toUtc();
              final bool isDay = controller.isDaytimeForDate(dateTimeUTC);
              final IconData weatherIcon = WeatherCode.getWeatherIcon(hours.values.weatherCode, isDay);
              final String weatherDescription = WeatherCode.getWeatherCondition(hours.values.weatherCode);

              return Card(
                margin: const EdgeInsets.all(8),
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(DateFormat.Hm().format(dateTimeUTC),
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      BoxedIcon(weatherIcon, size: 30, color: Colors.blue),
                      Text(weatherDescription, style: const TextStyle(fontSize: 14)),
                      Text("Temp. ${hours.values.temperature}°C", style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.pink)),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }


  Widget forecast6Days(List<DailyForecast> dailyForecast) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        elevation: 5,
        child: ListView.separated(

          padding: const EdgeInsets.symmetric(horizontal: 8),
          separatorBuilder: (context, index) => Divider(indent: Get.width / 6),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: dailyForecast.length,
          itemBuilder: (context, index){

            final day = dailyForecast[index];
            return ListTile(

              title: Text(DateFormat('EEEE, MMM d').format(_parseDateTime(day.time)),style: const TextStyle(fontWeight: FontWeight.bold),),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Min. Temp: ${day.values.temperatureMin.toStringAsFixed(1)}°C',style: const TextStyle(color: Colors.pink),),
                  Text('Max. Temp: ${day.values.temperatureMax.toStringAsFixed(1)}°C',style: const TextStyle(color: Colors.pink),),
                  Text('Avg. Temp: ${day.values.temperatureAvg.toStringAsFixed(1)}°C',style: const TextStyle(color: Colors.pink),),
                ],
              ),

              leading: const Icon(Icons.thermostat,color: Colors.blue,size: 30,),
              onTap: (){
                Get.bottomSheet(Container(
                     width: Get.width,
                      decoration: BoxDecoration(
                        color: Theme.of(context).secondaryHeaderColor,
                        borderRadius: const BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15))
                      ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: const Icon(FontAwesomeIcons.wind,color: Colors.pink,),
                          title: const Text("Wind speed"),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Wind speed min. ${day.values.windSpeedMin} Kph"),
                              Text("Wind speed max. ${day.values.windSpeedMax} Kph"),
                            ],
                          )
                        ),
                        ListTile(
                          leading: const Text("🌅",style: TextStyle(fontSize: 25),),
                          title: const Text("Sunrise/Sunset"),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Sunrise: ${day.values.sunriseTime} UTC"),
                              Text("Sunset: ${day.values.sunsetTime} UTC"),
                            ],
                          )
                        ),
                      ],
                    ),
                  ),
                ));
              },
            );
          },
        ),
      ),
    );
  }


  Widget otherWeatherThings(RealTimeTemperatureModel realTemp) {
    double windDirection = realTemp.data?.values?.windDirection ?? 0.0;
    String direction = getWindDirection(windDirection);
    return Column(
      children: [

        GridView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 5,mainAxisSpacing: 5),

          children: [
            SizedBox(
              width: Get.width/2,
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.wb_sunny,color: Colors.orange,size: 35,),
                          SizedBox(width: 5,),
                          Text("UVIndex",style: TextStyle(fontSize: 18),),
                        ],
                      ),
                      Text("${realTemp.data?.values?.uvIndex??"N/A"}",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      Text("UV health concerns: ${realTemp.data?.values?.uvHealthConcern??"N/A"}",style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.pink)),
                      // const Text("Use sun protection 9:30-16:30")
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(
              width: Get.width/2,
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.water_drop,color: Colors.blue,size: 35,),
                          SizedBox(width: 5,),
                          Text("Rain",style: TextStyle(fontSize: 18),)
                        ],
                      ),
                      Text("${realTemp.data?.values?.rainIntensity??"N/A"} mm",style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      Text("Precipitation Probability ${realTemp.data?.values?.precipitationProbability??"N/A"}%",style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.pink),),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
              width: Get.width,
              height: Get.height*.25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                leading: const Icon(FontAwesomeIcons.wind,size: 40,color: Colors.blue,),
                title: const Text("Wind",style: TextStyle(fontSize: 18),),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Wind speed: ${realTemp.data?.values?.windSpeed} Kph"),
                    Divider(indent: Get.width/9,),
                    Text("Wind gust: ${realTemp.data?.values?.windGust} Kph"),
                    Divider(indent: Get.width/9,),
                    Text("Wind direction: $direction",style: const TextStyle(fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
            ),
          ),
        ),

        GridView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 5,mainAxisSpacing: 5),

          children: [

            SizedBox(
              width: Get.width/2,
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(FontAwesomeIcons.water,color: Colors.blue,size: 35,),
                          SizedBox(width: 6,),
                          Text(" Humidity",style: TextStyle(fontSize: 18),),
                        ],
                      ),
                      Text("${realTemp.data?.values?.humidity??"N/A"} %",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      Text("The dew point is ${realTemp.data?.values?.dewPoint??"N/A"} right now")
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(
              width: Get.width/2,
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.remove_red_eye,color: Colors.blue,),
                          SizedBox(width: 5,),
                          Text("Visibility",style: TextStyle(fontSize: 18),)
                        ],
                      ),
                      Text("${realTemp.data?.values?.visibility??"N/A"} Km",style: const TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                      const Text("Visibility in weather refers to the distance one can clearly see due to atmospheric conditions.",style: TextStyle(fontSize: 11),),
                    ],
                  ),
                ),
              ),
            ),


          ],
        ),

      ],
    );
  }

}




