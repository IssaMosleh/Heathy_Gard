import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tess/insurance_screen/main.dart';
import 'package:tess/insurance_screen/settings_insurance.dart';

class InsuranceNotificationScreen extends StatelessWidget {
  const InsuranceNotificationScreen({Key? key}) : super(key: key);

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
          "title": "New Claim Submitted",
          "message": "A new claim has been submitted for processing. Review and approve or deny as needed.",
          "date": "2024-11-05",
          "icon": "assignment",
        },
        {
          "title": "Claim Approved",
          "message": "Claim #12345 has been approved. Check the report for further details.",
          "date": "2024-11-03",
          "icon": "check_circle",
        },
        {
          "title": "Report Ready",
          "message": "The monthly report for client statistics is ready for review. Download and analyze the data.",
          "date": "2024-11-02",
          "icon": "insert_chart",
        },
        {
          "title": "Policy Update",
          "message": "New policies have been added to the system. Review them to stay updated.",
          "date": "2024-11-01",
          "icon": "policy",
        },
        {
          "title": "Claim Denied",
          "message": "Claim #98765 has been denied. Check the rejection reason and notify the client if required.",
          "date": "2024-10-29",
          "icon": "cancel",
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
                  MaterialPageRoute(
                      builder: (context) => InsuranceRep_Screen()),
                );
              },
              icon: Image.asset('images/icon1.png', width: 30, height: 30),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotificationsScreen()),
                );
              },
              icon: Image.asset('images/icon3.png', width: 30, height: 30),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => settings_insurance()),
                  );
              },
              icon: Image.asset('images/icon4.png', width: 30, height: 30),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16.0),
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
        case 'assignment':
          return Icons.assignment;
        case 'check_circle':
          return Icons.check_circle;
        case 'insert_chart':
          return Icons.insert_chart;
        case 'policy':
          return Icons.policy;
        case 'cancel':
          return Icons.cancel;
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
