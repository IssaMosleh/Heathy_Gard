import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tess/doctor_screen/main.dart';
import 'package:tess/doctor_screen/patient_portal/patient_portal_labs.dart';
import 'package:tess/doctor_screen/patient_portal/patient_portal_patient_profile_write_prescription.dart';


class Patient_portal_meds extends StatelessWidget {
  const Patient_portal_meds({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SelectMedicineScreen(doctorSpecialty: 'Cardiology'),
    );
  }
}

class SelectMedicineScreen extends StatefulWidget {
  final String doctorSpecialty;

  const SelectMedicineScreen({super.key, required this.doctorSpecialty});

  @override
  _SelectMedicineScreenState createState() => _SelectMedicineScreenState();
}

class _SelectMedicineScreenState extends State<SelectMedicineScreen> {
  // Placeholder medications list; to be replaced with data from a database in the future
  final List<Map<String, dynamic>> medications = [
  {"name": "Aspirin", "allowedSpecialties": ["Cardiology", "General"], "description": "Pain relief and anti-inflammatory"},
  {"name": "Amoxicillin", "allowedSpecialties": ["General", "Pediatrics"], "description": "Antibiotic used to treat infections"},
  {"name": "Metformin", "allowedSpecialties": ["Endocrinology", "General"], "description": "For diabetes management"},
  {"name": "Ibuprofen", "allowedSpecialties": ["General"], "description": "Pain relief and fever reduction"},
  {"name": "Lisinopril", "allowedSpecialties": ["Cardiology"], "description": "Used to treat high blood pressure"},
  {"name": "Clozapine", "allowedSpecialties": ["Psychiatry"], "description": "Treatment for schizophrenia"},
  // Additional medications
  {"name": "Atorvastatin", "allowedSpecialties": ["Cardiology"], "description": "Lowers cholesterol levels"},
  {"name": "Levothyroxine", "allowedSpecialties": ["Endocrinology"], "description": "Treats hypothyroidism"},
  {"name": "Hydrochlorothiazide", "allowedSpecialties": ["Cardiology"], "description": "Used to treat high blood pressure"},
  {"name": "Simvastatin", "allowedSpecialties": ["Cardiology", "General"], "description": "Reduces cholesterol levels"},
  {"name": "Azithromycin", "allowedSpecialties": ["General"], "description": "Antibiotic for bacterial infections"},
  {"name": "Omeprazole", "allowedSpecialties": ["Gastroenterology"], "description": "Reduces stomach acid"},
  {"name": "Losartan", "allowedSpecialties": ["Cardiology"], "description": "Treats high blood pressure"},
  {"name": "Fluoxetine", "allowedSpecialties": ["Psychiatry"], "description": "Antidepressant"},
  {"name": "Warfarin", "allowedSpecialties": ["Cardiology"], "description": "Blood thinner"},
];

  List<String> selectedMedications = [];
  List<Map<String, dynamic>> filteredMedications = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filterMedications(); // Initialize with all allowed medications
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    _filterMedications();
  }

  void _filterMedications() {
    setState(() {
      filteredMedications = medications
          .where((med) =>
              med["allowedSpecialties"].contains(widget.doctorSpecialty) &&
              med["name"].toLowerCase().contains(searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Medications', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        leading: IconButton(onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => patient_portal_patient_profile_write_prescription(patientData: {},)),);
        }, icon: Icon(Icons.arrow_back_ios),color: Colors.white,),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Doctor_Screen()),);
          }, icon: Image.asset('images/icon1.png'),color:Colors.white)
        ],
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Doctor Specialty: ${widget.doctorSpecialty}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Search Bar
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search medications...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: filteredMedications.length,
                itemBuilder: (context, index) {
                  final medication = filteredMedications[index];
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      leading: const FaIcon(
                        FontAwesomeIcons.pills,
                        color: Colors.blue,
                        size: 32,
                      ),
                      title: Text(
                        medication["name"],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        medication["description"],
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      trailing: Checkbox(
                        value: selectedMedications.contains(medication["name"]),
                        onChanged: (value) {
                          setState(() {
                            if (value == true) {
                              selectedMedications.add(medication["name"]);
                            } else {
                              selectedMedications.remove(medication["name"]);
                            }
                          });
                        },
                        activeColor: Colors.blue,
                      ),
                      onTap: () {
                        setState(() {
                          if (selectedMedications.contains(medication["name"])) {
                            selectedMedications.remove(medication["name"]);
                          } else {
                            selectedMedications.add(medication["name"]);
                          }
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: selectedMedications.isNotEmpty
                        ? () {
                            _showConfirmationDialog();
                          }
                        : null,
                    child: const Text("Request Medications"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      disabledBackgroundColor: Colors.grey.shade300,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  patient_portal_labs()),);
                    },
                    child: const Text("Continue"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Medication Request'),
        content: Text(
          "Selected Medications:\n${selectedMedications.join(", ")}",
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              print("Medications Requested: $selectedMedications");
            },
            child: const Text("Confirm"),
          ),
        ],
      ),
    );
  }
}