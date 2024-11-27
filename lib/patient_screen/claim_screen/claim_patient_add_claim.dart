import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:math';

import 'package:tess/patient_screen/claim_screen/claim_paatient_main.dart';
import 'package:tess/patient_screen/mainscreenpatient.dart';


class claim_patient_add_claim extends StatelessWidget {
  const claim_patient_add_claim({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AddNewClaimScreen(),
    );
  }
}

class AddNewClaimScreen extends StatefulWidget {
  const AddNewClaimScreen({super.key});

  @override
  _AddNewClaimScreenState createState() => _AddNewClaimScreenState();
}

class _AddNewClaimScreenState extends State<AddNewClaimScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _hospitalController = TextEditingController();
  final TextEditingController _doctorController = TextEditingController();
  bool _includeLabs = false;
  bool _includeRadiology = false;
  bool _includeTreatmentPlan = false;
  String claimId = '';

  // Variables to store picked file paths
  String? _billsFilePath;
  String? _labReportsFilePath;
  String? _radiologyReportsFilePath;
  String? _treatmentPlanFilePath;

  @override
  void initState() {
    super.initState();
    claimId = _generateClaimId();
  }

  // Generate a random Claim ID
  String _generateClaimId() {
    final random = Random();
    return 'CLM${random.nextInt(1000000)}';
  }

  Future<void> _pickFile(String fileType) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() {
        // Save the file path based on the file type
        switch (fileType) {
          case 'Bills':
            _billsFilePath = file.path;
            break;
          case 'Lab Reports':
            _labReportsFilePath = file.path;
            break;
          case 'Radiology Reports':
            _radiologyReportsFilePath = file.path;
            break;
          case 'Treatment Plan':
            _treatmentPlanFilePath = file.path;
            break;
        }
      });
      print("Selected $fileType: ${file.name}, Size: ${file.size}");
    } else {
      print("File picking canceled for $fileType.");
    }
  }

void _submitClaim() {
  if (_formKey.currentState!.validate()) {
    Map<String, dynamic> claimData = {
      'claimId': claimId,
      'date': _dateController.text,
      'hospital': _hospitalController.text,
      'doctor': _doctorController.text,
      'includeLabs': _includeLabs,
      'includeRadiology': _includeRadiology,
      'includeTreatmentPlan': _includeTreatmentPlan,
      'billsFilePath': _billsFilePath,
      'labReportsFilePath': _includeLabs ? _labReportsFilePath : null,
      'radiologyReportsFilePath': _includeRadiology ? _radiologyReportsFilePath : null,
      'treatmentPlanFilePath': _includeTreatmentPlan ? _treatmentPlanFilePath : null,
    };

    print("Submitting Claim Data:");
    print(claimData);

    _formKey.currentState!.reset();
    setState(() {
      _includeLabs = false;
      _includeRadiology = false;
      _includeTreatmentPlan = false;
      _billsFilePath = null;
      _labReportsFilePath = null;
      _radiologyReportsFilePath = null;
      _treatmentPlanFilePath = null;
      claimId = _generateClaimId();
    });

    // Navigate to the desired screen after submitting
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Patient_Screen()),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
           Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const claim_paatient_main())
                    );         
        }, icon: const Icon(Icons.arrow_back_ios),color: Colors.white,),
        title: const Text('Add New Claim', style: TextStyle(color: Colors.white),),
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Claim ID: $claimId",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Claim Details",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(color: Colors.blueGrey),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _dateController,
                    decoration: const InputDecoration(
                      labelText: 'Date',
                      border: OutlineInputBorder(),
                      hintText: 'YYYY-MM-DD',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a date';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _hospitalController,
                    decoration: const InputDecoration(
                      labelText: 'Hospital Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the hospital name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _doctorController,
                    decoration: const InputDecoration(
                      labelText: 'Doctor Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the doctor\'s name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Upload Documents",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(color: Colors.blueGrey),
                  const SizedBox(height: 10),
                  _buildGradientButton(
                    label: _billsFilePath != null ? "Bills Uploaded" : "Upload Bills",
                    icon: Icons.attach_file,
                    onPressed: () => _pickFile("Bills"),
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text("Include Lab Reports"),
                    value: _includeLabs,
                    onChanged: (bool value) {
                      setState(() {
                        _includeLabs = value;
                      });
                    },
                  ),
                  if (_includeLabs)
                    _buildGradientButton(
                      label: _labReportsFilePath != null ? "Lab Reports Uploaded" : "Upload Lab Reports",
                      icon: Icons.attach_file,
                      onPressed: () => _pickFile("Lab Reports"),
                    ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text("Include Radiology Reports"),
                    value: _includeRadiology,
                    onChanged: (bool value) {
                      setState(() {
                        _includeRadiology = value;
                      });
                    },
                  ),
                  if (_includeRadiology)
                    _buildGradientButton(
                      label: _radiologyReportsFilePath != null ? "Radiology Reports Uploaded" : "Upload Radiology Reports",
                      icon: Icons.attach_file,
                      onPressed: () => _pickFile("Radiology Reports"),
                    ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text("Include Treatment Plan"),
                    value: _includeTreatmentPlan,
                    onChanged: (bool value) {
                      setState(() {
                        _includeTreatmentPlan = value;
                      });
                    },
                  ),
                  if (_includeTreatmentPlan)
                    _buildGradientButton(
                      label: _treatmentPlanFilePath != null ? "Treatment Plan Uploaded" : "Upload Treatment Plan",
                      icon: Icons.attach_file,
                      onPressed: () => _pickFile("Treatment Plan"),
                    ),
                  const SizedBox(height: 24),
                  Center(
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.purple, Colors.blue],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ElevatedButton(
                        onPressed: _submitClaim,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "Submit Claim",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGradientButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.purple, Colors.blue],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white),
        label: Text(
          label,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}