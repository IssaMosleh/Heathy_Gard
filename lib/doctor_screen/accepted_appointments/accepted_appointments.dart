import 'package:flutter/material.dart';
import 'package:tess/doctor_screen/mainscreendoctor.dart';



class AcceptedAppointment extends StatelessWidget {
  const AcceptedAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Appointment Details",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AcceptedAppointmentScreen(),
    );
  }
}

// Model for appointment data
class Appointment {
  String name;
  String date;
  String time;
  String imageUrl;

  Appointment({required this.name, required this.date, required this.time, required this.imageUrl});
}

class AcceptedAppointmentScreen extends StatefulWidget {
  const AcceptedAppointmentScreen({super.key});

  @override
  _AcceptedAppointmentScreenState createState() => _AcceptedAppointmentScreenState();
}

class _AcceptedAppointmentScreenState extends State<AcceptedAppointmentScreen> {
  // Dynamic list of appointments
  List<Appointment> appointments = [
    Appointment(name: "Malek Salem", date: "23/10/2021", time: "8:00 AM", imageUrl: "https://via.placeholder.com/100"),
    Appointment(name: "Nadia Noor", date: "24/10/2021", time: "10:00 AM", imageUrl: "https://via.placeholder.com/100"),
    Appointment(name: "Ahmad Ali", date: "25/10/2021", time: "1:00 PM", imageUrl: "https://via.placeholder.com/100"),
    Appointment(name: "Sara Khan", date: "26/10/2021", time: "3:00 PM", imageUrl: "https://via.placeholder.com/100"),
    Appointment(name: "John Doe", date: "27/10/2021", time: "9:00 AM", imageUrl: "https://via.placeholder.com/100"),
    Appointment(name: "Jane Smith", date: "28/10/2021", time: "11:00 AM", imageUrl: "https://via.placeholder.com/100"),
    Appointment(name: "Alex Brown", date: "29/10/2021", time: "2:00 PM", imageUrl: "https://via.placeholder.com/100"),
    Appointment(name: "Emily Green", date: "30/10/2021", time: "4:00 PM", imageUrl: "https://via.placeholder.com/100"),
  ];

  Future<void> _rescheduleAppointment(Appointment appointment) async {
    DateTime today = DateTime.now();
    DateTime endOfYear = DateTime(today.year, 12, 31);

    // Show Date Picker
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: today,
      lastDate: endOfYear,
    );

    if (pickedDate != null) {
      // Show Time Picker if date is picked
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        // Update the appointment with the new date and time
        setState(() {
          appointment.date = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
          appointment.time = pickedTime.format(context);
        });

        // Send update to the database (placeholder)
        _updateAppointmentInDatabase(appointment);

        // Confirmation message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Appointment rescheduled to ${appointment.date} at ${appointment.time}")),
        );
      }
    }
  }

  // Placeholder for future database update function
  void _updateAppointmentInDatabase(Appointment appointment) {
    // TODO: Implement database update logic here
    print("Updating appointment in database: ${appointment.name}, Date: ${appointment.date}, Time: ${appointment.time}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Accepted Appointment", style: TextStyle(color: Colors.white),),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Doctor_Screen()),
        );
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
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
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: appointments.length, // Number of cards based on dynamic data
        itemBuilder: (context, index) {
          final appointment = appointments[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Circular container for the profile image
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.blueAccent, width: 2),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              appointment.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Name: ${appointment.name}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Date: ${appointment.date}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Time: ${appointment.time}",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Reschedule button
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () => _rescheduleAppointment(appointment),
                        child: const Text("Reschedule"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}