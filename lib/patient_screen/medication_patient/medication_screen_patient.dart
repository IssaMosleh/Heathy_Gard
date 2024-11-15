import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tess/patient_screen/medication_patient/medication_patient_main.dart';

class medication_patient_patient extends StatelessWidget {
  const medication_patient_patient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MedicationScreen(),
    );
  }
}

class MedicationScreen extends StatefulWidget {
  const MedicationScreen({Key? key}) : super(key: key);

  @override
  _MedicationScreenState createState() => _MedicationScreenState();
}

class _MedicationScreenState extends State<MedicationScreen> {
  List<Map<String, dynamic>> medications = [
    {
      'image': 'images/panadol.png',
      'name': 'Panadol Extra',
      'dosage': '2 - Medication Strips',
      'duration': '6 months',
      'status': 'Active',
      'dosageInstruction': 'Take 1 tablet daily',
      'refillLimit': 3,
      'refillCount': 3,
      'nextRefillDate': DateTime.now().add(Duration(days: 7)),
    },
    {
      'image': 'images/panadol.png',
      'name': 'Aspirin',
      'dosage': '1 - Medication Strip',
      'duration': '1 month',
      'status': 'Active',
      'dosageInstruction': 'Take 2 tablets twice daily',
      'refillLimit': 2,
      'refillCount': 0,
      'nextRefillDate': DateTime.now(),
    },
    {
      'image': 'images/panadol.png',
      'name': 'Vitamin C',
      'dosage': '1 - Bottle',
      'duration': '3 months',
      'status': 'Finished',
      'dosageInstruction': 'Take 1 tablet daily',
      'refillLimit': 1,
      'refillCount': 1,
      'nextRefillDate': null,
    },
    {
      'image': 'images/insulin.png',
      'name': 'Insulin',
      'dosage': '1 - Vial',
      'duration': 'Monthly',
      'status': 'Active',
      'dosageInstruction': 'Inject 10 units twice daily',
      'refillLimit': 5,
      'refillCount': 4,
      'nextRefillDate': DateTime.now().add(Duration(days: 1)),
    },
  ];

  void _requestRefill(int index) {
    DateTime now = DateTime.now();
    DateTime? nextRefillDate = medications[index]['nextRefillDate'];
    int refillLimit = medications[index]['refillLimit'];
    int refillCount = medications[index]['refillCount'];

    if (medications[index]['status'] == 'Finished') {
      _showDialog("Refill Failed", "This medication is finished. Please visit your doctor.");
    } else if (refillCount >= refillLimit) {
      _showDialog("Refill Failed", "All refills have been used. Please visit your doctor.");
    } else if (nextRefillDate != null && now.isBefore(nextRefillDate)) {
      _showDialog("Refill Failed", "You can request a refill after ${DateFormat.yMMMd().format(nextRefillDate)}.");
    } else {
      setState(() {
        medications[index]['refillCount'] += 1;
        medications[index]['nextRefillDate'] = now.add(Duration(days: 30));
      });
      _showDialog("Refill Successful", "Your refill request for ${medications[index]['name']} has been processed.");
    }
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: AppBar(
          centerTitle: true,
          title: const Text(
            "Medications",
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => medication_patient_main()),
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            children: medications.map((medication) {
              int index = medications.indexOf(medication);
              return MedicationCard(
                medication: medication,
                onRequestRefill: () => _requestRefill(index),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class MedicationCard extends StatelessWidget {
  final Map<String, dynamic> medication;
  final VoidCallback onRequestRefill;

  const MedicationCard({Key? key, required this.medication, required this.onRequestRefill}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime? nextRefillDate = medication['nextRefillDate'];
    int refillCount = medication['refillCount'];
    int refillLimit = medication['refillLimit'];
    bool isFinished = medication['status'] == 'Finished';

    return SizedBox(
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 4.0,
        shadowColor: Colors.blue.withOpacity(0.3),
        margin: const EdgeInsets.only(bottom: 16.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: AssetImage(medication['image']),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        medication['name'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        medication['dosage'],
                        style: const TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      Text(
                        medication['duration'],
                        style: const TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      Text(
                        medication['status'],
                        style: const TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Next refill: ${isFinished || refillLimit == 0 ? "None" : (nextRefillDate != null ? DateFormat.yMMMd().format(nextRefillDate) : "None")}",
                        style: const TextStyle(fontSize: 14, color: Colors.red),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Refills used: $refillCount / $refillLimit",
                        style: const TextStyle(fontSize: 14, color: Colors.green),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(height: 32.0),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  medication['dosageInstruction'],
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ),
              const SizedBox(height: 8.0),
              Center(
                child: medication['status'] == 'Finished'
                    ? const SizedBox.shrink()
                    : refillCount >= refillLimit
                        ? const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              "Please visit your doctor",
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : Container(
                            width: 250,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Colors.blue, Colors.purple],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: TextButton(
                              onPressed: onRequestRefill,
                              child: const Text(
                                'Request Refill',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
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