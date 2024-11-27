import 'package:flutter/material.dart';
import 'package:tess/patient_screen/mainscreenpatient.dart';
import 'package:tess/patient_screen/patient_appointmnet/patient_appointment_choosedoctor.dart';
import 'package:tess/patient_screen/patient_appointmnet/patient_appointment_selecthospital_search.dart';
import 'package:tess/patient_screen/patient_appointmnet/patient_appointment_typeofvist.dart';

class PatientAppointmentSelectHospital extends StatefulWidget {
  const PatientAppointmentSelectHospital({super.key});

  @override
  _PatientAppointmentSelectHospitalState createState() => _PatientAppointmentSelectHospitalState();
}

class _PatientAppointmentSelectHospitalState extends State<PatientAppointmentSelectHospital> {
  String? selectedLocation;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HospitalListScreen(selectedLocation: selectedLocation),
    );
  }
}

class HospitalListScreen extends StatefulWidget {
  final String? selectedLocation;

  const HospitalListScreen({super.key, this.selectedLocation});

  @override
  _HospitalListScreenState createState() => _HospitalListScreenState();
}

class _HospitalListScreenState extends State<HospitalListScreen> {
  String? selectedLocation;
  final List<Map<String, String>> allHospitals = [
    {"name": "Jordan Hospital", "location": "Amman", "image": "images/hospital_image.png"},
    {"name": "Specialty Hospital", "location": "Amman", "image": "images/hospital_image.png"},
    {"name": "Al Khalidi Hospital", "location": "Jabal Amman", "image": "images/hospital_image.png"},
    {"name": "Zarqa Governmental Hospital", "location": "Zarqa", "image": "images/hospital_image.png"},
    {"name": "King Abdullah University Hospital", "location": "Irbid", "image": "images/hospital_image.png"},
    {"name": "Ajloun Governmental Hospital", "location": "Ajloun", "image": "images/hospital_image.png"},
    {"name": "Al Karak Hospital", "location": "Karak", "image": "images/hospital_image.png"},
    {"name": "Aqaba Hospital", "location": "Aqaba", "image": "images/hospital_image.png"},
    {"name": "Madaba Governmental Hospital", "location": "Madaba", "image": "images/hospital_image.png"},
    {"name": "Jerash Hospital", "location": "Jerash", "image": "images/hospital_image.png"},
    {"name": "Salt Hospital", "location": "Salt", "image": "images/hospital_image.png"},
    {"name": "Mafraq Hospital", "location": "Mafraq", "image": "images/hospital_image.png"},
  ];

  List<Map<String, String>> get hospitals {
    if (selectedLocation == null) return allHospitals;
    return allHospitals.where((hospital) => hospital["location"] == selectedLocation).toList();
  }

  void updateLocation(String? location) {
    setState(() {
      selectedLocation = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          title: ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds),
            child: const Text(
              "Step 2 of 4: Choose Hospital",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const patient_appointment_typeofvist()),
              );
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Patient_Screen()),
                );
              },
              icon: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Image.asset('images/icon1.png'),
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(
              color: Colors.black,
              height: 1.0,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    "Hospital List",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const patient_appointment_selecthospital_search()),
                      );
                    },
                    icon: Image.asset("images/search.png"),
                  ),
                  IconButton(
                    onPressed: () {
                      showFilterBottomSheet(context);
                    },
                    icon: Image.asset("images/settings.png"),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                "Find the hospital or Clinic you want",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: hospitals.length,
                itemBuilder: (context, index) {
                  final hospital = hospitals[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const patient_appointment_choosedoctor()),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                hospital["image"]!,
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              hospital["name"]!,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              hospital["location"]!,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: FilterButtons(
            onLocationSelected: (location) {
              updateLocation(location);
            },
            selectedLocation: selectedLocation,
          ),
        );
      },
    );
  }
}

class FilterButtons extends StatefulWidget {
  final String? selectedLocation;
  final Function(String?) onLocationSelected;

  const FilterButtons({super.key, this.selectedLocation, required this.onLocationSelected});

  @override
  _FilterButtonsState createState() => _FilterButtonsState();
}

class _FilterButtonsState extends State<FilterButtons> {
  String? selectedButton;

  @override
  void initState() {
    super.initState();
    selectedButton = widget.selectedLocation;
  }

  @override
  Widget build(BuildContext context) {
    final locations = [
      "Amman", "Zarqa", "Irbid", "Ajloun", "Karak", "Aqaba", "Madaba",
      "Jerash", "Salt", "Mafraq", "Ma'an", "Tafilah"
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Filter (Hospital)",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 2.5,
          children: locations.map((location) => _buildFilterButton(location)).toList(),
        ),
      ],
    );
  }

  Widget _buildFilterButton(String text) {
    final isSelected = selectedButton == text;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedButton = text;
        });
        widget.onLocationSelected(text);
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  colors: [Colors.blue, Colors.purple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isSelected ? null : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade300),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
