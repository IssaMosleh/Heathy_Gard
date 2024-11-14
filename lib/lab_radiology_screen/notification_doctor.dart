import 'package:flutter/material.dart';
import 'package:tess/lab_radiology_screen/appointment_doctor.dart';
import 'package:tess/lab_radiology_screen/main.dart';
import 'package:tess/lab_radiology_screen/settings_doctor.dart';




class notification_doctor_LAB extends StatefulWidget {
  const notification_doctor_LAB({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<notification_doctor_LAB> {
  final List<Map<String, String>> notifications = [
    {
      "title": "Appointment Reminder",
      "description": "You have an appointment tomorrow at 10:00 AM.",
      "date": "2024-11-10"
    },
    {
      "title": "Lab Results Available",
      "description": "Your recent lab results are now available for review.",
      "date": "2024-11-08"
    },
    {
      "title": "Prescription Ready",
      "description": "Your prescription is ready for pickup.",
      "date": "2024-11-05"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove the back button
        title: const Text(
          "Notifications",
          style: TextStyle(color: Colors.white), // Ensure title is white
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ListTile(
              title: Text(notification["title"]!),
              subtitle: Text(notification["description"]!),
              trailing: Text(notification["date"]!),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          margin: const EdgeInsets.symmetric(horizontal: 32.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Doctor_LAB()),
            );
                },
                icon: Image.asset('images/icon1.png', width: 30, height: 30),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => appointment_doctor_LAB()),
            );
                },
                icon: Image.asset('images/icon2.png', width: 30, height: 30),
              ),
              IconButton(
                onPressed: () {Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => notification_doctor_LAB()),
            );},
                icon: Image.asset('images/icon3.png', width: 30, height: 30),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => settings_doctor_LAB()),
            );
                },
                icon: Image.asset('images/icon4.png', width: 30, height: 30),
              ),
            ],
          ),
        ),
    );
  }
}


