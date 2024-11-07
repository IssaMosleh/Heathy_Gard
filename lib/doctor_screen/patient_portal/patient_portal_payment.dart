import 'package:flutter/material.dart';
import 'package:tess/doctor_screen/main.dart';
import 'package:tess/doctor_screen/patient_portal/patient_portal_labs.dart';

class patient_portal_payment extends StatelessWidget {
  const patient_portal_payment({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ServiceAmountScreen(patientName: 'John Doe', insuranceName: 'HealthPlus Insurance'),
    );
  }
}

class ServiceAmountScreen extends StatefulWidget {
  final String patientName;
  final String insuranceName;

  const ServiceAmountScreen({super.key, required this.patientName, required this.insuranceName});

  @override
  _ServiceAmountScreenState createState() => _ServiceAmountScreenState();
}

class _ServiceAmountScreenState extends State<ServiceAmountScreen> {
  List<Map<String, dynamic>> icd10Codes = []; // Will be populated with database data
  int selectedIcd10Index = 0;
  double coPay = 20.0; 
  double patientContribution = 0.0;
  double outOfPocketAmount = 0.0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchDataFromDatabase(); // Fetch data from database when initializing
  }

  // Simulated database fetch function
  Future<void> _fetchDataFromDatabase() async {
    try {
      // Replace this with your actual database call
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        icd10Codes = [
          {"code": "E11", "visitAmount": 5000.0},
          {"code": "I10", "visitAmount": 3000.0},
          {"code": "K21", "visitAmount": 4000.0},
          {"code": "M54", "visitAmount": 2500.0},
          {"code": "N39", "visitAmount": 3500.0},
        ];
        selectedIcd10Index = 3; // Default to the first ICD-10 code
        _calculatePaymentDetails(); // Calculate based on the first ICD-10 code
        isLoading = false;
      });
    } catch (error) {
      // Handle any database errors here
      print("Failed to fetch data: $error");
    }
  }

  void _calculatePaymentDetails() {
    if (icd10Codes.isNotEmpty) {
      setState(() {
        double visitAmount = icd10Codes[selectedIcd10Index]["visitAmount"];
        patientContribution = visitAmount - coPay;
        outOfPocketAmount = coPay;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Doctor_Screen()),);
        }, icon: Image.asset('images/icon1.png'))],
        leading: IconButton(onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => patient_portal_labs()),);
        }, icon: Icon(Icons.arrow_back_ios),color: Colors.white,),
        centerTitle: true,
        title: Text(style: TextStyle(color: Colors.white),
          isLoading
              ? 'Loading...'
              : 'Service Amount',
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
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading indicator
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: TextEditingController(text: widget.patientName),
                      decoration: const InputDecoration(
                        labelText: "Patient Name",
                        border: OutlineInputBorder(),
                      ),
                      readOnly: true,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: TextEditingController(text: widget.insuranceName),
                      decoration: const InputDecoration(
                        labelText: "Insurance",
                        border: OutlineInputBorder(),
                      ),
                      readOnly: true,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: TextEditingController(
                          text: icd10Codes[selectedIcd10Index]["code"]),
                      decoration: const InputDecoration(
                        labelText: "ICD-10 Code",
                        border: OutlineInputBorder(),
                      ),
                      readOnly: true,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Visit Amount: JOD ${icd10Codes[selectedIcd10Index]["visitAmount"].toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Patient Account Contribution: JOD ${patientContribution.toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 16, color: Colors.green),
                    ),
                    Text(
                      "Out-of-Pocket (Patient): JOD ${outOfPocketAmount.toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 16, color: Colors.redAccent),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Doctor_Screen()),);
                        },
                        child: const Text("Confirm Payment"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
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
              ),
            ),
    );
  }
}