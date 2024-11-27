import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tess/patient_screen/mainscreenpatient.dart';
import 'package:tess/patient_screen/notification_patient.dart';
import 'package:tess/patient_screen/settings_patient.dart'; // Add this for date formatting

class appointment_main_patient extends StatelessWidget {
  const appointment_main_patient({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppointmentsScreen(),
    );
  }
}

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  _AppointmentsScreenState createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Appointments",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
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
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white,
          tabs: const [
            Tab(text: 'Pending'),
            Tab(text: 'Confirmed'),
            Tab(text: 'Cancelled'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          AppointmentList(category: 'Pending'),
          AppointmentList(category: 'Confirmed'),
          AppointmentList(category: 'Cancelled'),
        ],
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
                    MaterialPageRoute(builder: (context) => const Patient_Screen()),
                    );         
                },
                icon: Image.asset('images/icon1.png', width: 30, height: 30),
              ),
              IconButton(
                onPressed: () {
                   Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const appointment_main_patient()),
                    );         
                },
                icon: Image.asset('images/icon2.png', width: 30, height: 30),
              ),
              IconButton(
                onPressed: () {
                   Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const notification_patient()),
                    );         
                },
                icon: Image.asset('images/icon3.png', width: 30, height: 30),
              ),
              IconButton(
                onPressed: () {
                   Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const settings_patient()),
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

class AppointmentList extends StatefulWidget {
  final String category;

  const AppointmentList({super.key, required this.category});

  @override
  _AppointmentListState createState() => _AppointmentListState();
}

class _AppointmentListState extends State<AppointmentList> {
  List<Map<String, dynamic>> appointments = [];
  List<Map<String, dynamic>> cancelledAppointments = [];

  @override
  void initState() {
    super.initState();
    appointments = getAppointmentsForCategory(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final appointment = appointments[index];
          bool isWithin24Hours = DateTime.now().isAfter(appointment['date'].subtract(const Duration(hours: 24)));

          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(
                          'images/person.jpg', // Replace with your image asset path
                          height: 60,
                          width: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              appointment['doctor']!,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              appointment['specialty']!,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            DateFormat('dd/MM/yyyy').format(appointment['date']),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(Icons.access_time, size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            appointment['time']!,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Icon(
                            widget.category == 'Pending' ? Icons.hourglass_top :
                            (widget.category == 'Cancelled' ? Icons.cancel : Icons.check_circle),
                            size: 16,
                            color: widget.category == 'Pending' ? Colors.orange :
                            (widget.category == 'Cancelled' ? Colors.red : Colors.green),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.category == 'Pending' ? 'Pending' :
                            (widget.category == 'Cancelled' ? 'Cancelled' : 'Confirmed'),
                            style: TextStyle(
                              fontSize: 14,
                              color: widget.category == 'Pending' ? Colors.orange :
                              (widget.category == 'Cancelled' ? Colors.red : Colors.green),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (widget.category == 'Cancelled') 
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Row(
                        children: [
                          const Text(
                            "Reason: ",
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                          ),
                          Text(
                            appointment['cancelReason']!,
                            style: const TextStyle(fontSize: 14, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  if (widget.category == 'Pending' || widget.category == 'Confirmed')
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: isWithin24Hours ? null : () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Cancel Appointment"),
                                    content: const Text("Are you sure you want to cancel this appointment?"),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text("No"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: const Text("Yes"),
                                        onPressed: () {
                                          // Handle cancellation logic here
                                          setState(() {
                                            // Move appointment to cancelled list
                                            cancelledAppointments.add({
                                              ...appointment,
                                              'cancelReason': 'User Cancelled',
                                              'status': 'Cancelled',
                                            });
                                            appointments.removeAt(index);
                                          });
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.grey),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              "Cancel",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: appointment['isRescheduled'] == true ? null : () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  DateTime? newDateTime;
                                  String selectedDateTime = "No date & time selected";
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    elevation: 4,
                                    child: Container(
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 10,
                                            offset: Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text(
                                            "Reschedule Appointment",
                                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                                          ),
                                          const SizedBox(height: 12),
                                          const Text(
                                            "Select a new date and time within the next week:",
                                            style: TextStyle(fontSize: 16, color: Colors.grey),
                                          ),
                                          const SizedBox(height: 16),
                                          ElevatedButton(
                                            onPressed: () async {
                                              DateTime? pickedDate = await showDatePicker(
                                                context: context,
                                                initialDate: appointment['date'],
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime.now().add(const Duration(days: 7)), // Max date is one week from now
                                              );
                                              if (pickedDate != null) {
                                                TimeOfDay? pickedTime = await showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.fromDateTime(appointment['date']),
                                                );
                                                if (pickedTime != null) {
                                                  newDateTime = DateTime(
                                                    pickedDate.year,
                                                    pickedDate.month,
                                                    pickedDate.day,
                                                    pickedTime.hour,
                                                    pickedTime.minute,
                                                  );
                                                  selectedDateTime = DateFormat('dd/MM/yyyy – hh:mm a').format(newDateTime!);
                                                  setState(() {
                                                    selectedDateTime = DateFormat('dd/MM/yyyy – hh:mm a').format(newDateTime!);
                                                  });
                                                }
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.blue, // Change to desired button color
                                              padding: const EdgeInsets.symmetric(vertical: 12),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                            ),
                                            child: const Text(
                                              "Pick New Date & Time",
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          ),
                                          const SizedBox(height: 12),
                                          Text(
                                            selectedDateTime,
                                            style: const TextStyle(fontSize: 16, color: Colors.black),
                                          ),
                                          const SizedBox(height: 16),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: TextButton(
                                                  onPressed: () {
                                                    if (newDateTime != null) {
                                                      setState(() {
                                                        appointments[index]['date'] = newDateTime;
                                                        appointments[index]['time'] = DateFormat('hh:mm a').format(newDateTime!);
                                                        appointments[index]['isRescheduled'] = true; // Mark as rescheduled
                                                      });
                                                    }
                                                    Navigator.of(context).pop();
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                  ),
                                                  child: const Text(
                                                    "Reschedule",
                                                    style: TextStyle(color: Colors.green),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 16),
                                              Expanded(
                                                child: TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text(
                                                    "Cancel",
                                                    style: TextStyle(color: Colors.red),
                                                  ),
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
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text("Reschedule"),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  List<Map<String, dynamic>> getAppointmentsForCategory(String category) {
    // Dummy data for demonstration purposes
    // In future, replace this with dynamic data fetching from a database
    DateTime now = DateTime.now();
    if (category == 'Cancelled') {
      return cancelledAppointments; // Return the cancelled appointments
    } else {
      return [
        {
          'doctor': 'Dr. Mohamed Jarwan',
          'specialty': 'Cardiology',
          'date': now.add(const Duration(days: 1)), // Future date for testing
          'time': '8:00 AM',
          'status': category,
          'isRescheduled': false,
        },
        {
          'doctor': 'Dr. Lina Al-Sarhan',
          'specialty': 'Dermatology',
          'date': now.add(const Duration(days: 2)), // Future date for testing
          'time': '10:30 AM',
          'status': category,
          'isRescheduled': false,
        },
      ];
    }
  }
}