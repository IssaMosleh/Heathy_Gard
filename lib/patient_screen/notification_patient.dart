import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tess/patient_screen/appointment_main_patient.dart';
import 'package:tess/patient_screen/main.dart';
import 'package:tess/patient_screen/settings_patient.dart'; // Import for date formatting

class notification_patient extends StatelessWidget {
  const notification_patient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const NotificationsScreen(),
    );
  }
}

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<Map<String, String>> notifications = [];

  final DateFormat dateFormat = DateFormat('MMM d, yyyy');

  @override
  void initState() {
    super.initState();
    fetchNotifications();
  }

  void fetchNotifications() async {
    // Simulate fetching data from a database or API.
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      notifications = [
        {
          "title": "Appointment Reminder",
          "message": "Your upcoming appointment with Dr. Smith is scheduled for tomorrow at 10 AM. Don't forget to bring your health records.",
          "date": "2024-11-05",
          "icon": "calendar_today",
        },
        {
          "title": "Medication Refill",
          "message": "Your prescription for Ibuprofen is ready for refill. Please visit your pharmacy before 12th November.",
          "date": "2024-11-03",
          "icon": "medication",
        },
        {
          "title": "Health Tip of the Day",
          "message": "Stay hydrated! Drinking at least 8 glasses of water every day helps maintain a healthy metabolism.",
          "date": "2024-11-02",
          "icon": "local_drink",
        },
        {
          "title": "Lab Results Available",
          "message": "Your blood test results are now available. View them through the app to stay informed about your health.",
          "date": "2024-11-01",
          "icon": "science",
        },
        {
          "title": "New Exercise Routine",
          "message": "A new fitness plan has been added for your wellbeing. Check it out to stay fit and healthy!",
          "date": "2024-10-29",
          "icon": "fitness_center",
        },
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notifications",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 5,
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
                    MaterialPageRoute(builder: (context) => Patient_Screen()),
                    );         
                },
                icon: Image.asset('images/icon1.png', width: 30, height: 30),
              ),
              IconButton(
                onPressed: () {
                   Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => appointment_main_patient()),
                    );         
                },
                icon: Image.asset('images/icon2.png', width: 30, height: 30),
              ),
              IconButton(
                onPressed: () {
                   Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => notification_patient()),
                    );         
                },
                icon: Image.asset('images/icon3.png', width: 30, height: 30),
              ),
              IconButton(
                onPressed: () {
                   Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => settings_patient()),
                    );         
                },
                icon: Image.asset('images/icon4.png', width: 30, height: 30),
              ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0), // Adjusted spacing for content below AppBar
        child: notifications.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: notifications
                        .map((notification) => _buildNotificationCard(notification))
                        .toList(),
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildNotificationCard(Map<String, String> notification) {
    DateTime notificationDate = DateTime.parse(notification['date']!);

    IconData? getIcon(String iconName) {
      switch (iconName) {
        case 'calendar_today':
          return Icons.calendar_today;
        case 'medication':
          return Icons.medication;
        case 'local_drink':
          return Icons.local_drink;
        case 'science':
          return Icons.science;
        case 'fitness_center':
          return Icons.fitness_center;
        default:
          return Icons.notifications;
      }
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Icon(
              getIcon(notification['icon']!),
              size: 40,
              color: Colors.blue[700],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification['title']!,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  notification['message']!,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Date: ${dateFormat.format(notificationDate)}",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
