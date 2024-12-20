import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tess/doctor_screen/patient_portal/patient_portal_payment.dart';
import 'package:tess/doctor_screen/patient_portal/patient_portal_show_doctor_profile.dart';

class patient_portal_date_picker extends StatefulWidget {
  const patient_portal_date_picker({super.key});

  @override
  _DateAndTimeSelectionScreenState createState() => _DateAndTimeSelectionScreenState();
}

class _DateAndTimeSelectionScreenState extends State<patient_portal_date_picker> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _selectedTime = TimeOfDay.now();
  }

  void _pickDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate!,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _pickTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime!,
    );
    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => patient_portal_show_doctor_profile()),
            );
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: const Text(
          'Select Date & Time',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
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
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextButton(
              onPressed: _pickDate,
              child: Text(
                "Select Date: ${DateFormat('yMMMd').format(_selectedDate!)}",
                style: const TextStyle(fontSize: 18, color: Colors.blueAccent),
              ),
            ),
            TextButton(
              onPressed: _pickTime,
              child: Text(
                "Select Time: ${_selectedTime!.format(context)}",
                style: const TextStyle(fontSize: 18, color: Colors.blueAccent),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const patient_portal_payment()),);
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: Colors.blue,
              ),
              child: const Text(
                "Save Selection",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
