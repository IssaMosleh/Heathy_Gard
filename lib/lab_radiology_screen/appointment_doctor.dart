import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tess/lab_radiology_screen/main.dart';
import 'package:tess/lab_radiology_screen/notification_doctor.dart';
import 'package:tess/lab_radiology_screen/settings_doctor.dart';



class appointment_doctor_LAB extends StatelessWidget {
  const appointment_doctor_LAB({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Appointments',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AppointmentScreen(),
    );
  }
}

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  int _selectedIndex = 1;

  static final List<Widget> _screens = <Widget>[
    const DoctorScreen(),
    const AppointmentScreenBody(),
    const PlaceholderWidget(text: "Another Screen"),
    const PlaceholderWidget(text: "More Screen"),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
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
                MaterialPageRoute(builder: (context) => const Doctor_LAB()),
            );
                },
                icon: Image.asset('images/icon1.png', width: 30, height: 30),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const appointment_doctor_LAB()),
            );
                },
                icon: Image.asset('images/icon2.png', width: 30, height: 30),
              ),
              IconButton(
                onPressed: () {Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const notification_doctor_LAB()),
            );},
                icon: Image.asset('images/icon3.png', width: 30, height: 30),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const settings_doctor_LAB()),
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

class AppointmentScreenBody extends StatefulWidget {
  const AppointmentScreenBody({super.key});

  @override
  _AppointmentScreenBodyState createState() => _AppointmentScreenBodyState();
}

class _AppointmentScreenBodyState extends State<AppointmentScreenBody> {
  final List<Map<String, String>> acceptedAppointments = [
    {
      "name": "Malek Salem",
      "date": "23/10/2021",
      "time": "8:00 AM",
      "image": "images/profile1.png"
    },
  ];

  final List<Map<String, String>> pendingAppointments = [
    {
      "name": "Sara Ahmed",
      "date": "24/10/2021",
      "time": "9:00 AM",
      "image": "images/profile2.png"
    },
    {
      "name": "Ali Khaled",
      "date": "25/10/2021",
      "time": "10:30 AM",
      "image": "images/profile3.png"
    },
  ];

  void _moveToAccepted(Map<String, String> appointment) {
    setState(() {
      pendingAppointments.remove(appointment);
      acceptedAppointments.add(appointment);
    });
  }

  Future<void> _rescheduleAppointment(Map<String, String> appointment) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          final formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
          appointment["date"] = formattedDate;
          appointment["time"] = pickedTime.format(context);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Appointments",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: "Accepted Appointments"),
              Tab(text: "Pending Appointments"),
            ],
          ),
          elevation: 0,
        ),
        body: TabBarView(
          children: [
            AcceptedAppointments(
              appointments: acceptedAppointments,
              onReschedule: _rescheduleAppointment,
            ),
            PendingAppointments(
              appointments: pendingAppointments,
              onAccept: _moveToAccepted,
              onReschedule: _rescheduleAppointment,
            ),
          ],
        ),
      ),
    );
  }
}

class AcceptedAppointments extends StatefulWidget {
  final List<Map<String, String>> appointments;
  final Future<void> Function(Map<String, String>) onReschedule;

  const AcceptedAppointments({
    super.key,
    required this.appointments,
    required this.onReschedule,
  });

  @override
  _AcceptedAppointmentsState createState() => _AcceptedAppointmentsState();
}

class _AcceptedAppointmentsState extends State<AcceptedAppointments> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: widget.appointments.map((appointment) {
          return AppointmentCard(
            name: appointment["name"]!,
            date: appointment["date"]!,
            time: appointment["time"]!,
            imagePath: appointment["image"]!,
            onReschedule: () => widget.onReschedule(appointment),
            isPending: false,
          );
        }).toList(),
      ),
    );
  }
}

class PendingAppointments extends StatefulWidget {
  final List<Map<String, String>> appointments;
  final Function(Map<String, String>) onAccept;
  final Future<void> Function(Map<String, String>) onReschedule;

  const PendingAppointments({
    super.key,
    required this.appointments,
    required this.onAccept,
    required this.onReschedule,
  });

  @override
  _PendingAppointmentsState createState() => _PendingAppointmentsState();
}

class _PendingAppointmentsState extends State<PendingAppointments> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: widget.appointments.map((appointment) {
          return AppointmentCard(
            name: appointment["name"]!,
            date: appointment["date"]!,
            time: appointment["time"]!,
            imagePath: appointment["image"]!,
            onAccept: () => widget.onAccept(appointment),
            onReschedule: () => widget.onReschedule(appointment),
            isPending: true,
          );
        }).toList(),
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final String name;
  final String date;
  final String time;
  final String imagePath;
  final VoidCallback? onAccept;
  final VoidCallback onReschedule;
  final bool isPending;

  const AppointmentCard({
    super.key,
    required this.name,
    required this.date,
    required this.time,
    required this.imagePath,
    this.onAccept,
    required this.onReschedule,
    required this.isPending,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(imagePath),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name: $name",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Date: $date",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    Text(
                      "Time: $time",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (isPending)
                  ElevatedButton(
                    onPressed: onAccept,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text("Accept"),
                  ),
                ElevatedButton(
                  onPressed: onReschedule,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text("Reschedule"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PlaceholderWidget extends StatefulWidget {
  final String text;

  const PlaceholderWidget({super.key, required this.text});

  @override
  _PlaceholderWidgetState createState() => _PlaceholderWidgetState();
}

class _PlaceholderWidgetState extends State<PlaceholderWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Text(
          widget.text,
          style: TextStyle(fontSize: 18, color: Colors.grey[700]),
        ),
      ),
    );
  }
}

class DoctorScreen extends StatefulWidget {
  const DoctorScreen({super.key});

  @override
  _DoctorScreenState createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Text(
          "Doctor Screen",
          style: TextStyle(fontSize: 18, color: Colors.grey[700]),
        ),
      ),
    );
  }
}
