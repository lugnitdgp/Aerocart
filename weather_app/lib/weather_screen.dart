import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/additional_info.dart';
import 'package:weather_app/hourly_forecast.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/secrets.dart';
import 'package:moon_icons/moon_icons.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
   late Future<Map<String, dynamic>> weather;
    String cityname = 'Kolkata';
  Future<Map<String, dynamic>> getCurrentWeather() async{
    try{      
      final result = await http.get(
        Uri.parse('https://api.openweathermap.org/data/2.5/forecast?q=$cityname,in&APPID=$apiId'),
      );

      final data=jsonDecode(result.body);

      if(data['cod']!='200'){
        throw'Unexpected error occured';
      }

      return data;
    }catch(e){
      throw e.toString();
    }

  }

  @override
  void initState() {
    super.initState();
    weather = getCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: const Text('Weather App', style: TextStyle( fontWeight: FontWeight.bold),),
        actions: [IconButton(
          onPressed: () {
            setState(() {
              weather =getCurrentWeather();
            });
          }, 
          icon: const Icon(Icons.refresh))],
        centerTitle: true,
        
      ),
      body: FutureBuilder(
        future: weather,
        builder:(context, snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }
          if(snapshot.hasError){
            return Center(child: Text(snapshot.error.toString()));
          }

          final data = snapshot.data!;
          double currentTemp=data['list'][0]['main']['temp'];
          currentTemp-=273.15; 
          final temp=currentTemp.toStringAsFixed(1);
          final currentSky=data['list'][0]['weather'][0]['main'];
          final humidity = data['list'][0]['main']['humidity'];
          final wind = data['list'][0]['wind']['speed'];
          final pressure=data['list'][0]['main']['pressure'];
          final currtime = DateTime.parse(data['list'][0]['dt_txt']);
          return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 16,
                  ),
                  Text(cityname,style: const TextStyle( fontSize: 24,fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox( 
                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 20,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 5,
                        sigmaY: 5,
                      ),
                      child:  Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text('$temp°C', style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),),
                            const SizedBox(height: 12,),
                            Icon(
                              (int.parse(DateFormat.H().format(currtime))>18&&int.parse(DateFormat.H().format(currtime))<5)?(currentSky=='Clouds'? Icons.cloud:(currentSky =='Rain'? WeatherIcons.rain:MoonIcons.other_moon_16_light)):(currentSky=='Clouds'? Icons.cloud:(currentSky =='Rain'? WeatherIcons.rain:Icons.sunny)), 
                              size: 64,
                              ),
                            const SizedBox(height: 12,),
                            Text(currentSky, style: const TextStyle(fontSize: 24),)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox( height: 25,),            
              const Padding(
                padding: EdgeInsets.fromLTRB(8.0,0,0,0),
                child: Text('Weather Forecast',style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
              ),
              const SizedBox( height: 14,),                
              SizedBox(
                height: 131,
                child: ListView.builder(
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index){
                    final hourlyForecast=data['list'][index+1];
                    final hourlySky=hourlyForecast['weather'][0]['main'];
                    double hourlytemp=hourlyForecast['main']['temp'];
                    hourlytemp=hourlytemp-273.15;
                    final hourlyTemp=hourlytemp.toStringAsFixed(1);
                    final time = DateTime.parse(hourlyForecast['dt_txt']);
                    
                    return HourlyForecast(
                      icon: (int.parse(DateFormat.H().format(time))>18&&int.parse(DateFormat.H().format(time))<5)?(hourlySky=='Clouds'? Icons.cloud:(hourlySky =='Rain'? WeatherIcons.rain:MoonIcons.other_moon_16_light)):(hourlySky=='Clouds'? Icons.cloud:(hourlySky =='Rain'? WeatherIcons.rain:Icons.sunny)),  
                      time: DateFormat.j().format(time), 
                      temp: hourlyTemp);
                  }),
              ),
              const SizedBox( height: 25,),            
              const Padding(
                padding: EdgeInsets.fromLTRB(8.0,0,0,0),
                child: Text('Additional Information',style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),),
              ),
              const SizedBox(height: 14,),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AdditionalInfo(
                    label: 'Humidity',
                    value: '$humidity',
                    icon: Icons.water_drop,
                  ),
                  AdditionalInfo(
                    label: 'Wind Speed',
                    value: '$wind',
                    icon: Icons.air,
                  ), 
                  AdditionalInfo(
                    label: 'Pressure',
                    value: '$pressure',
                    icon: Icons.beach_access,
                  ),                 
                ],
              )
            ],
          ),
        );
        },
      ),
    );
  }

}
