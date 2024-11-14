import 'package:flutter/material.dart';
import 'package:tess/lab_radiology_screen/main.dart';
import 'package:tess/lab_radiology_screen/patient_portal/patient_portal_patient_profile.dart';
import 'package:tess/lab_radiology_screen/patient_portal/patient_upload_lab.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Doctor Treatment App',
    home: patient_portal_patient_profile_write_prescription_LAB(
      patientData: {}, // Specialty to filter codes
    ),
  ));
}

class patient_portal_patient_profile_write_prescription_LAB extends StatefulWidget {
  final Map<String, String> patientData;

  patient_portal_patient_profile_write_prescription_LAB({required this.patientData});

  @override
  _TreatmentFormScreenState createState() => _TreatmentFormScreenState();
}

class _TreatmentFormScreenState extends State<patient_portal_patient_profile_write_prescription_LAB> {
  final _formKey = GlobalKey<FormState>();
  late String patientName;
  late String doctorName;
  late String visitDate;
  String description = '';
  String treatment = '';
  String icd10Code = '';
  String doctorSpecialty = 'General'; // Default specialty, can be replaced

  // Codes categorized by specialties
  final Map<String, List<String>> codesBySpecialty = {
    'General': ["I10 - Essential hypertension", "E11.9 - Type 2 diabetes without complications"],
    'Lab': [
      "CPT 80050 - General Health Panel",
      "CPT 80053 - Comprehensive Metabolic Panel",
      "CPT 80061 - Lipid Panel",
      "CPT 81000 - Urinalysis, non-automated",
    ],
    'Radiology': [
      "CPT 71045 - Chest X-Ray",
      "CPT 70450 - CT Head",
      "CPT 73721 - MRI Lower Extremity",
      "CPT 72141 - MRI Cervical Spine",
    ],
  };

  List<String> availableCodes = [];

  @override
  void initState() {
    super.initState();
    _fetchPatientData();
    _updateCodes();
  }

  void _fetchPatientData() {
    setState(() {
      patientName = widget.patientData['patientName'] ?? 'Unknown';
      doctorName = widget.patientData['doctorName'] ?? 'Unknown';
      visitDate = widget.patientData['visitDate'] ?? 'Unknown';
      doctorSpecialty = widget.patientData['doctorSpecialty'] ?? 'General';
    });
  }

  void _updateCodes() {
    // Update codes based on the doctor's specialty
    setState(() {
      availableCodes = codesBySpecialty[doctorSpecialty] ?? [];
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
    // Code to send `formData` to your database
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const patient_portal_patient_profile_LAB()),
            );
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Doctor_LAB()),
              );
            },
            icon: Image.asset('images/icon1.png'),
          )
        ],
        title: Center(
          child: Text('Treatment Form', style: TextStyle(color: Colors.white)),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
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
              _buildCodeDropdown(),
              _buildMultilineTextField('Description', 4, 200, (value) {
                description = value!;
              }),
              _buildMultilineTextField('Treatment', 4, 200, (value) {
                treatment = value!;
              }),
              SizedBox(height: 16), // Add spacing before the button

              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
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
                  child: Text(
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
          border: OutlineInputBorder(),
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
          border: OutlineInputBorder(),
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

  Widget _buildCodeDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        decoration: InputDecoration(
          labelText: doctorSpecialty == 'Lab' ? 'Select Lab CPT Code' : 'Select Radiology CPT Code',
          border: OutlineInputBorder(),
        ),
        items: availableCodes.map((code) {
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
        validator: (value) => value == null || value.isEmpty ? 'Please select a code' : null,
      ),
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Continue'),
        content: Text('You have successfully completed this step.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const upload_lab_screen()),
            ),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
