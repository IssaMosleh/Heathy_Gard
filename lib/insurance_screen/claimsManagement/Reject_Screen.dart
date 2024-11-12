import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tess/insurance_screen/claimsManagement/ClaimsManagement.dart';

class RejectScreen extends StatefulWidget {
  @override
  _RejectScreenState createState() => _RejectScreenState();
}

class _RejectScreenState extends State<RejectScreen> {
  String? selectedReason;
  TextEditingController descriptionController = TextEditingController();

  List<String> rejectionReasons = [
    'Insufficient Coverage',
    'Non-Approved Medication',
    'Policy Expired',
    'Pre-Existing Condition Not Covered',
    'Claim Exceeds Coverage Limit',
    'Other'
  ];

  // Method to save rejection data locally
  Future<void> saveRejectionData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('rejectionReason', selectedReason ?? '');
    await prefs.setString('rejectionDescription', descriptionController.text);

    // Print for debugging, to confirm it's saved
    print("Data saved locally: Reason - $selectedReason, Description - ${descriptionController.text}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
           Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ClaimsManagementScreen()),
        );
        }, icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text("Reject Claim",style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Reason for Rejection"),
            DropdownButton<String>(
              value: selectedReason,
              hint: Text("Select a reason"),
              onChanged: (newValue) {
                setState(() {
                  selectedReason = newValue;
                });
              },
              items: rejectionReasons.map((reason) {
                return DropdownMenuItem(
                  value: reason,
                  child: Text(reason),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text("Description"),
            TextField(
              controller: descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Provide more details...",
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                saveRejectionData();
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ClaimsManagementScreen()),
            );
              },
              child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
