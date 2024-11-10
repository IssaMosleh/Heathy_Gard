import 'package:flutter/material.dart';
import 'package:tess/pharmacy_screen/main.dart';
import 'package:tess/pharmacy_screen/settings_pharmacy.dart';

class PharmacyNotificationScreen extends StatelessWidget {
  // Sample notifications data
  final List<Map<String, String>> notifications = [
    {
      "title": "New Order",
      "description": "A new prescription has been submitted for Patient Alice Johnson.",
      "timestamp": "10:30 AM",
    },
    {
      "title": "Medication Change Request",
      "description": "Patient John Doe has requested a change in medication.",
      "timestamp": "9:15 AM",
    },
    {
      "title": "Order Completed",
      "description": "The order for Patient Michael Lee has been completed and dispensed.",
      "timestamp": "8:00 AM",
    },
    {
      "title": "Pending Order",
      "description": "The order for Patient Sarah Davis is still pending approval.",
      "timestamp": "7:45 AM",
    },
    {
      "title": "Prescription Refill",
      "description": "Patient Jane Smith has requested a prescription refill.",
      "timestamp": "7:30 AM",
    },
    {
      "title": "Order Update",
      "description": "The order for Patient Tom White has been updated.",
      "timestamp": "6:30 AM",
    },
    {
      "title": "Change Request Approved",
      "description": "Patient Emily Clark's medication change request has been approved.",
      "timestamp": "5:00 AM",
    },
    {
      "title": "Payment Reminder",
      "description": "Patient Robert Green has an outstanding payment for a prescription.",
      "timestamp": "4:00 AM",
    },
    {
      "title": "Medication Out of Stock",
      "description": "The medication requested by Patient Maria Lopez is out of stock.",
      "timestamp": "3:00 AM",
    },
    {
      "title": "Prescription Submitted",
      "description": "Patient Chris Johnson's new prescription has been submitted.",
      "timestamp": "2:30 AM",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
      title: const Text('Pharmacy Notifications', style: TextStyle(color: Colors.white)),
      flexibleSpace: Container(
      decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
  ),
  centerTitle: true,
),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Notification list wrapped in a Container
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: notifications.map((notification) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 8.0,
                      shadowColor: Colors.grey.withOpacity(0.2),
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.notifications, color: Colors.blue, size: 40),
                            SizedBox(height: 8),
                            Text(
                              notification["title"]!,
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Text(
                              notification["description"]!,
                              style: TextStyle(fontSize: 14, color: Colors.black54),
                            ),
                            SizedBox(height: 8),
                            Text(
                              notification["timestamp"]!,
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
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
              offset: const Offset(0, 3),
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
              MaterialPageRoute(builder: (context) => Pharmacy_Screen()),
            );
              },
              icon: Image.asset('images/icon1.png'), // Replace with desired icon
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PharmacyNotificationScreen()),
            );
              },
              icon: Image.asset('images/icon3.png'), // Replace with desired icon
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => settings_pharmacy()),
            );
              },
              icon: Image.asset('images/icon4.png'), // Replace with desired icon
            ),
          ],
        ),
      ),
    );
  }
}
