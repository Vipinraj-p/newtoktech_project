import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newtoktech_project/presentation/login_screen.dart';
import 'package:newtoktech_project/services/admin/admin_home_screen_services.dart';
import 'package:provider/provider.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<AdminHomeScreenServices>(
      builder: (BuildContext context, AdminHomeScreenServices screenValue,
          Widget? child) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 164, 152, 190),
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 58, 27, 131),
            foregroundColor: Colors.white,
            leading: const Icon(Icons.admin_panel_settings_rounded),
            title: const Text("Admin"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: [
                SizedBox(
                  height: size.height * 0.1,
                ),
                CSCPicker(
                  onCountryChanged: (value) {
                    screenValue.countryValue = value.toString();
                    /* screenValue.countryValue = value
                        .toString()
                        .replaceFirst(CountryFlag as String, '');
                    screenValue.countryFlag = CountryFlag; */
                  },
                  onStateChanged: (value) {
                    screenValue.stateValue = value.toString();
                  },
                  onCityChanged: (value) {
                    screenValue.cityValue = value.toString();

                    screenValue.setLocation();
                  },
                ),
                SizedBox(
                  height: size.height * 0.07,
                ),
                Center(
                    child: Text(
                  "country : ${screenValue.countryValue}\nState : ${screenValue.stateValue}\nCity: ${screenValue.cityValue}\n",
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                )),
                SizedBox(
                  height: size.height * 0.07,
                ),
                ElevatedButton(
                    onPressed: () {
                      screenValue.setLocation();
                      FirebaseFirestore.instance
                          .collection("location")
                          .doc()
                          .set(screenValue.location, SetOptions(merge: true));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 75, 77, 105),
                        shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        fixedSize: Size(size.width - 50, 50)),
                    child: Text(
                      'Add this Location to Cloud',
                      style:
                          GoogleFonts.ubuntu(color: Colors.white, fontSize: 18),
                    ))
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
            )
          ]),
        );
      },
    );
  }
}
