import 'package:flutter/material.dart';
import 'package:tess/doctor_screen/main.dart';
import 'package:tess/doctor_screen/patient_portal/Patient_portal_meds.dart';
import 'package:tess/doctor_screen/patient_portal/patient_portal_payment.dart';
import 'package:tess/doctor_screen/patient_portal/patient_portal_tansfer_to_another_doctor.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Doctor Test Request App',
    home: patient_portal_labs(),
  ));
}

class patient_portal_labs extends StatefulWidget {
  @override
  _RequestTestScreenState createState() => _RequestTestScreenState();
}

class _RequestTestScreenState extends State<patient_portal_labs> {
  List<String> selectedLabTests = [];
  List<String> selectedRadiologyTests = [];
  bool labTestActivated = false;
  bool radiologyTestActivated = false;

  String doctorSpecialty = ''; // Doctor specialty to be fetched from database

  Map<String, List<String>> labTestsBySpecialty = {};
  Map<String, List<String>> radiologyTestsBySpecialty = {};

  List<String> labTests = [];
  List<String> radiologyTests = [];

  @override
  void initState() {
    super.initState();
    _fetchDataFromDatabase();
  }

  Future<void> _fetchDataFromDatabase() async {
    // Simulate fetching doctor specialty and test codes from the database
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      doctorSpecialty = 'Cardiology'; // Example specialty, replace with fetched data

      // Example lab and radiology codes categorized by specialty
      labTestsBySpecialty = {
        'Cardiology': [
          "80053 - Comprehensive Metabolic Panel",
          "85025 - Complete Blood Count",
        ],
        'Neurology': [
          "83036 - Glycated Hemoglobin Test",
          "81001 - Urinalysis",
        ],
        'General': [
          "84443 - Thyroid Stimulating Hormone",
          "81001 - Urinalysis",
        ],
      };

      radiologyTestsBySpecialty = {
        'Cardiology': [
          "71045 - X-ray, chest, single view",
          "72148 - MRI, lumbar spine, without contrast",
        ],
        'Neurology': [
          "70551 - MRI, brain, without contrast",
          "74176 - CT, abdomen and pelvis, without contrast",
        ],
        'General': [
          "71250 - CT, thorax, without contrast",
          "74176 - CT, abdomen and pelvis, without contrast",
        ],
      };

      // Load tests based on the doctor’s specialty
      labTests = labTestsBySpecialty[doctorSpecialty] ?? [];
      radiologyTests = radiologyTestsBySpecialty[doctorSpecialty] ?? [];
    });
  }

  void _saveRequestToDatabase() {
    final requestData = {
      'selectedLabTests': labTestActivated ? selectedLabTests : ['Not Requested'],
      'selectedRadiologyTests': radiologyTestActivated ? selectedRadiologyTests : ['Not Requested'],
    };
    print('Request Data to save: $requestData');
    // Placeholder for sending `requestData` to the database
  }

  void _transferToAnotherDoctor() {
    Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const patient_portal_tansfer_to_another_doctor()),);
  }

  bool get _isTestSelected {
    return (labTestActivated && selectedLabTests.isNotEmpty) ||
           (radiologyTestActivated && selectedRadiologyTests.isNotEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Patient_portal_meds()),);
        }, icon: Icon(Icons.arrow_back_ios,color: Colors.white,),color: Colors.white,),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Doctor_Screen()),);
          }, icon: Image.asset('images/icon1.png'),color: Colors.white,)
        ],
        title: Center(child: Text('Treatment Form',style: TextStyle(color: Colors.white),)),
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
        child: ListView(
          children: [
            CheckboxListTile(
              title: Text("Activate Lab Test Request"),
              value: labTestActivated,
              onChanged: (value) {
                setState(() {
                  labTestActivated = value ?? false;
                  if (!labTestActivated) selectedLabTests.clear(); // Reset selection
                });
              },
            ),
            if (labTestActivated)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Request Lab Tests',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  _buildMultiSelectDropdown(
                    title: 'Select Lab Tests',
                    items: labTests,
                    selectedItems: selectedLabTests,
                  ),
                ],
              ),
            SizedBox(height: 24),
            CheckboxListTile(
              title: Text("Activate Radiology Test Request"),
              value: radiologyTestActivated,
              onChanged: (value) {
                setState(() {
                  radiologyTestActivated = value ?? false;
                  if (!radiologyTestActivated) selectedRadiologyTests.clear(); // Reset selection
                });
              },
            ),
            if (radiologyTestActivated)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Request Radiology Tests',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  _buildMultiSelectDropdown(
                    title: 'Select Radiology Tests (CPT Codes)',
                    items: radiologyTests,
                    selectedItems: selectedRadiologyTests,
                  ),
                ],
              ),
            SizedBox(height: 24),
            // Submit Request Button
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
                onPressed: _isTestSelected
                    ? () {
                        _saveRequestToDatabase();
                        _showConfirmationDialog();
                      }
                    : null, // Disable if no test is selected
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  'Submit Request',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 16),
            // Continue Button (Always Enabled)
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.green],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const patient_portal_payment()),);
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
            SizedBox(height: 16),
            // Transfer to Another Doctor Button
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange, Colors.red],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ElevatedButton(
                onPressed: _transferToAnotherDoctor,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  'Transfer to Another Doctor',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMultiSelectDropdown({
    required String title,
    required List<String> items,
    required List<String> selectedItems,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 16)),
          ...items.map((item) {
            return CheckboxListTile(
              title: Text(item),
              value: selectedItems.contains(item),
              onChanged: (value) {
                setState(() {
                  if (value == true) {
                    selectedItems.add(item);
                  } else {
                    selectedItems.remove(item);
                  }
                });
              },
            );
          }).toList(),
        ],
      ),
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        final labRequests = selectedLabTests.isNotEmpty ? selectedLabTests.join(", ") : "None";
        final radiologyRequests = selectedRadiologyTests.isNotEmpty ? selectedRadiologyTests.join(", ") : "None";

        return AlertDialog(
          title: Text('Request Submitted'),
          content: Text(
            'Lab Tests: $labRequests\nRadiology Tests: $radiologyRequests',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

