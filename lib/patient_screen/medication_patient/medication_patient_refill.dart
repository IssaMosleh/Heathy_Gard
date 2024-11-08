import 'package:flutter/material.dart';
import 'dart:async';

import 'package:tess/patient_screen/medication_patient/medication_patient_main.dart';

void main() {
  runApp(const medication_patient_refill());
}

class medication_patient_refill extends StatelessWidget {
  const medication_patient_refill({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MedicationScreen(),
    );
  }
}

class MedicationScreen extends StatefulWidget {
  const MedicationScreen({Key? key}) : super(key: key);

  @override
  _MedicationScreenState createState() => _MedicationScreenState();
}

class _MedicationScreenState extends State<MedicationScreen> {
  // Simulate a data fetch with a Future
  Future<List<Map<String, dynamic>>> fetchOrders() async {
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    return [
      {'medicationName': 'Aspirin', 'orderId': '1730618259765', 'status': 'Pending'},
      {'medicationName': 'Panadol Extra', 'orderId': '1730618259766', 'status': 'Completed'},
      // Add more orders as needed
    ];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => medication_patient_main()),
                    );         
            },
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.white,
          ),
          title: const Text(
            "Refill Orders",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
          elevation: 4.0,
          bottom: TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
            tabs: const [
              Tab(text: "Pending"),
              Tab(text: "Completed"),
            ],
          ),
        ),
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: fetchOrders(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error fetching orders'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No orders available'));
            }

            final orders = snapshot.data!;
            return TabBarView(
              children: [
                OrderList(orders: orders.where((order) => order['status'] == 'Pending').toList()),
                OrderList(orders: orders.where((order) => order['status'] == 'Completed').toList()),
              ],
            );
          },
        ),
      ),
    );
  }
}

class OrderList extends StatelessWidget {
  final List<Map<String, dynamic>> orders;

  const OrderList({Key? key, required this.orders}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 3,
          shadowColor: Colors.grey.withOpacity(0.5),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order['medicationName'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Order ID: ${order['orderId']}",
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      order['status'] == 'Pending' ? Icons.hourglass_empty : Icons.check_circle,
                      color: order['status'] == 'Pending' ? Colors.orange : Colors.green,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Status: ${order['status']}",
                      style: TextStyle(
                        fontSize: 14,
                        color: order['status'] == 'Pending' ? Colors.orange : Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}