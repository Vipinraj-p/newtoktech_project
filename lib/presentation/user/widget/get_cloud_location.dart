import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LocationInformation extends StatefulWidget {
  const LocationInformation({super.key});

  @override
  _LocationInformationState createState() => _LocationInformationState();
}

class _LocationInformationState extends State<LocationInformation> {
  final Stream<QuerySnapshot> _locationStream =
      FirebaseFirestore.instance.collection('location').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: _locationStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }

            return ListView(
              children: snapshot.data!.docs
                  .map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return ListTile(
                      title: Text(
                        data['city'],
                        style: const TextStyle(color: Colors.white),
                      ),
                      trailing: Text(
                        data['country'],
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        data['state'],
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  })
                  .toList()
                  .cast(),
            );
          },
        ),
      ),
    );
  }
}
