// import 'package:flutter/material.dart';
// import 'package:newtoktech_project/services/user/user_home_screeen_services.dart';
// import 'package:newtoktech_project/services/weather_provider.dart';
// import 'package:provider/provider.dart';


// class WeatherPick extends StatelessWidget {
//   const WeatherPick({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<WeatherProvider>(builder: (context, weatherValue, _) {
//       return Consumer<UserHomeScreeenServices>(
//           builder: (context, userValue, _) {
//         for (int i = 0; i < userValue.totalRow; i++) {
//           String city = userValue.setlocation.elementAt(i);
//           weatherValue.FetchWeather(city);
//           Future.delayed(const Duration(seconds: 3));
//           weather.add(weatherValue.weatherModel!.weather);
//           Future.delayed(const Duration(seconds: 1));
//         }

//         return SizedBox(); //Text(weather[].toString());
//       });
//     });
//   }
// }
