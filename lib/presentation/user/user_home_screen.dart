import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newtoktech_project/presentation/login_screen.dart';
import 'package:newtoktech_project/presentation/user/widget/get_cloud_location.dart';
import 'package:newtoktech_project/services/user/user_home_screeen_services.dart';
import 'package:newtoktech_project/services/weather_provider.dart';
import 'package:provider/provider.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});
  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  @override
  void initState() {
    Provider.of<WeatherProvider>(context, listen: false).FetchWeather("kannur");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final userScreenProvider = Provider.of<UserHomeScreeenServices>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 234, 251, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 50, 153, 73),
        foregroundColor: const Color.fromARGB(255, 23, 23, 24),
        leading: const Icon(
          Icons.account_circle_rounded,
          color: Colors.white,
        ),
        title: const Text(
          "User",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.1, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        userScreenProvider.filePick();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 75, 102, 105),
                          shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(7)),
                          fixedSize: Size(size.width, 50)),
                      child: Text(
                        'Upload excel file',
                        style: GoogleFonts.ubuntu(
                            color: Colors.white, fontSize: 18),
                      )),
                  const SizedBox(height: 10),
                  Text(userScreenProvider.fileName),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      const ListTile(
                        leading: Text("Sl.No",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.black)),
                        title: Text("City",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.black)),
                        trailing: Text("Weather",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.black)),
                      ),
                      const Divider(),
                      ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            if (weatherProvider.weatherList.length <
                                userScreenProvider.totalRow) {
                              weatherProvider.FetchWeather(userScreenProvider
                                  .setlocation
                                  .elementAt(index));
                              weatherProvider.weatherList.add(weatherProvider
                                  .weatherModel!.main!.temp
                                  .toString());
                            }

                            var realIndex = index + 1;
                            if (userScreenProvider.setlocation.isNotEmpty) {
                              return ListTile(
                                  leading: Text(realIndex.toString()),
                                  title: Text(userScreenProvider.setlocation
                                      .elementAt(index)),
                                  trailing:
                                      Text(weatherProvider.weatherList[index]));
                            } else {
                              return const SizedBox();
                            }
                          },
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: userScreenProvider.totalRow)
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      endDrawer: NavigationDrawer(children: [
        const DrawerHeader(
            child: CircleAvatar(
          child: Icon(
            Icons.admin_panel_settings,
            color: Color.fromARGB(190, 244, 67, 54),
            size: 50,
          ),
        )),
        ListTile(
          leading: const Icon(Icons.location_on),
          title: const Text("Location Stored by Admin"),
          onTap: () {
            FirebaseAuth.instance.signOut().then(
              (value) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LocationInformation(),
                    ));
              },
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text("Logout"),
          onTap: () {
            FirebaseAuth.instance.signOut().then(
              (value) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ));
              },
            );
          },
        ),
      ]),
    );
  }
}




// Consumer<WeatherProvider>(
//                   builder: (context, value, child) {
//                     return ElevatedButton(
//                         onPressed: () {
//                           _filePick();
//                           // value.FetchWeather("kannur");
//                         },
//                         style: ElevatedButton.styleFrom(
//                             backgroundColor:
//                                 const Color.fromARGB(255, 75, 102, 105),
//                             shape: ContinuousRectangleBorder(
//                                 borderRadius: BorderRadius.circular(7)),
//                             fixedSize: Size(size.width * 0.5, 50)),
//                         child: Text(
//                           'Upload excel file',
//                           style: GoogleFonts.ubuntu(
//                               color: Colors.white, fontSize: 18),
//                         ));
//                   },
//                 ),