// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:locator_mobile/data/model/user.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({required this.userId, super.key});
  final User userId;

  @override
  Widget build(BuildContext context) {
    final dateTime = DateTime.fromMicrosecondsSinceEpoch(userId.time);
    final formattedDate = DateFormat('kk:mm').format(dateTime);
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Spacer(),
                  Text(
                    userId.name, // Replace with actual name
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Spacer(),
                  IconButton.filled(
                    highlightColor: Colors.white,
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_outward,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        elevation: 0, 
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [


            const SizedBox(height: 20),

            // Avatar
            CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage(
                userId.avatar,
              ), // Replace with actual avatar URL
            ),
            const SizedBox(height: 20), // Spacer

            // ID number and buttons row
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.info),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        10,
                      ), 
                      color: Color.fromRGBO(165, 235, 49, 1),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      userId.id, // Replace with actual ID
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.chat_bubble),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20), // Spacer
            // Card showing current location and time
            Card(
              color: Colors.white,
              // elevation: ,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Now is',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10), // Spacer
                    FutureBuilder<String>(
                      future: geocodeLocation(
                        double.parse(userId.currentLat),
                        double.parse(userId.currentLon),
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text(
                            'Loading...',
                          ); // Display a loading indicator while fetching data
                        } else if (snapshot.hasError) {
                          return Text(
                            'Error: ${snapshot.error}',
                          ); // Handle error case
                        } else if (snapshot.hasData) {
                          return Text(
                            snapshot.data!,
                          ); // Display the geocoded location
                        } else {
                          return Text(
                            'Unknown',
                          ); // Handle other cases (when data is not available)
                        }
                      },
                    ),
                    SizedBox(height: 10), // Spacer
                    Text(
                      formattedDate, // Replace with actual time
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20), // Spacer
            // Last updates
            const Text(
              'Last Updates:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10), // Spacer
            SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: 5, 
                itemBuilder: (context, index) {
                  return ListTile(
                    title: FutureBuilder<String>(
                      future: geocodeLocation(
                        double.parse(userId.previousLat),
                        double.parse(userId.previousLon),
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text(
                            'Loading...',
                          );
                        } else if (snapshot.hasError) {
                          return Text(
                            'Error: ${snapshot.error}',
                          );
                        } else if (snapshot.hasData) {
                          return Text(
                            snapshot.data!,
                          );
                        } else {
                          return Text(
                            'Unknown',
                          );
                        }
                      },
                    ),
                  );
                },
              ),
            ),
          
          ],
        ),
      ),
    );
  }
}

Future<String> geocodeLocation(double lat, double lon) async {
  try {
    final placemarks = await placemarkFromCoordinates(lat, lon);
    final address =
        placemarks.isNotEmpty ? placemarks.first.name ?? '' : 'Unknown';
    return address;
  } catch (e) {
    return 'Unknown';
  }
}
