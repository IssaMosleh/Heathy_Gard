import 'package:flutter/material.dart';
import 'package:tess/doctor_screen/mainscreendoctor.dart';
import 'package:tess/doctor_screen/patient_portal/Patient_portal_meds.dart';
import 'package:tess/doctor_screen/patient_portal/patient_portal_patient_profile.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Doctor Treatment App',
    home: patient_portal_patient_profile_write_prescription(
      patientData: const { // Specialty to filter ICD-10 codes
      },
    ),
  ));
}


class patient_portal_patient_profile_write_prescription extends StatefulWidget {
  final Map<String, String> patientData;

  const patient_portal_patient_profile_write_prescription({super.key, required this.patientData});

  @override
  _TreatmentFormScreenState createState() => _TreatmentFormScreenState();
}

class _TreatmentFormScreenState extends State<patient_portal_patient_profile_write_prescription> {
  final _formKey = GlobalKey<FormState>();
  late String patientName;
  late String doctorName;
  late String visitDate;
  String description = '';
  String treatment = '';
  String icd10Code = '';
  String doctorSpecialty = 'General'; // Default specialty, can be replaced

  // ICD-10 Codes categorized by specialties
  final Map<String, List<String>> icd10CodesBySpecialty = {
    'General': [
      "I10 - Essential (primary) hypertension",
      "E11.9 - Type 2 diabetes mellitus without complications",
      "J45.909 - Unspecified asthma, uncomplicated",
      "R07.9 - Chest pain, unspecified",
      "F41.1 - Generalized anxiety disorder",
    ],
    'Cardiology': [
      "I50.9 - Heart failure, unspecified",
      "I10 - Essential (primary) hypertension",
      "I20.0 - Unstable angina",
      "I25.10 - Atherosclerotic heart disease",
    ],
    'Endocrinology': [
      "E11.9 - Type 2 diabetes mellitus without complications",
      "E03.9 - Hypothyroidism, unspecified",
      "E05.9 - Thyrotoxicosis, unspecified",
      "E66.9 - Obesity, unspecified",
    ],
    'Neurology': [
      "G43.9 - Migraine, unspecified",
      "G40.909 - Epilepsy, unspecified, not intractable",
      "F32.9 - Major depressive disorder, single episode, unspecified",
      "R51 - Headache",
      "R42 - Dizziness and giddiness",
    ],
    // Add more specialties and codes as needed
  };

  List<String> availableIcd10Codes = [];

  @override
  void initState() {
    super.initState();
    _fetchPatientData();
    _updateIcd10Codes();
  }

  void _fetchPatientData() {
    setState(() {
      patientName = widget.patientData['patientName'] ?? 'Unknown';
      doctorName = widget.patientData['doctorName'] ?? 'Unknown';
      visitDate = widget.patientData['visitDate'] ?? 'Unknown';
      doctorSpecialty = widget.patientData['doctorSpecialty'] ?? 'General';
    });
  }

  void _updateIcd10Codes() {
    // Update the ICD-10 codes based on the doctor's specialty
    setState(() {
      availableIcd10Codes = icd10CodesBySpecialty[doctorSpecialty] ?? [];
    });
  }

  void _saveFormData() {
    final formData = {
      'patientName': patientName,
      'doctorName': doctorName,
      'visitDate': visitDate,
      'description': description,
      'treatment': treatment,
      'icd10Code': icd10Code,
      'doctorSpecialty': doctorSpecialty,
    };
    print('Form Data to save: $formData');
    // Here, add code to send `formData` to your database
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const patient_portal_patient_profile()),);
        }, icon: const Icon(Icons.arrow_back_ios,color: Colors.white,),color: Colors.white,),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Doctor_Screen()),);
          }, icon: Image.asset('images/icon1.png'),color: Colors.white,)
        ],
        title: const Center(child: Text('Treatment Form',style: TextStyle(color: Colors.white),)),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple, Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildDisabledTextField('Name of Patient', patientName),
              _buildDisabledTextField('Name of Doctor', doctorName),
              _buildDisabledTextField('Date of Visit', visitDate),
              _buildICD10Dropdown(),
              _buildMultilineTextField('Description', 4, 200, (value) {
                description = value!;
              }),
              _buildMultilineTextField('Treatment', 4, 200, (value) {
                treatment = value!;
              }),

              const SizedBox(height: 16), // Add some spacing before the button

              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.purple, Colors.blue],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _saveFormData();
                      _showConfirmationDialog();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'Continue',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDisabledTextField(String label, String initialValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: TextEditingController(text: initialValue),
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        enabled: false,
      ),
    );
  }

  Widget _buildMultilineTextField(String label, int maxLines, int maxLength, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        maxLines: maxLines,
        maxLength: maxLength,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildICD10Dropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        decoration: const InputDecoration(
          labelText: 'Select ICD-10 Code',
          border: OutlineInputBorder(),
        ),
        items: availableIcd10Codes.map((code) {
          return DropdownMenuItem(
            value: code,
            child: Text(code, maxLines: 2, overflow: TextOverflow.ellipsis),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            icd10Code = value ?? '';
          });
        },
        validator: (value) => value == null || value.isEmpty ? 'Please select an ICD-10 Code' : null,
      ),
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Continue'),
        content: const Text('You have successfully completed this step.'),
        actions: [
          TextButton(onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Patient_portal_meds()),), child: const Text('OK')),
        ],
      ),
    );
  }
}

