import 'package:flutter/material.dart';
import 'package:tess/doctor_screen/history/history_visits.dart';
class patient_history_same_doctor extends StatelessWidget {
  const patient_history_same_doctor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HistoryScreen(),
    );
  }
}

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final List<Map<String, dynamic>> appointments = [
    {
      "date": "23",
      "month": "October",
      "specialty": "General Care",
      "doctor": "Dr. Mohamed Jarwan",
      "patient": "Othman Othman",
      "time": "Sunday, 9:30 AM",
      "prescriptionDetails": "Prescription Details",
      "includeLabReports": true,
      "includeRadiology": true,
      "medication": "Amoxicillin 500mg",
      "dosage": "Take one tablet twice daily",
      "issuedDate": "23 October 2023",
      "nextAppointment": "Sunday, 9:30 AM",
      "ICD10": "J01",
      "disease": "Acute Sinusitis",
      "labReport": {
        "type": "Blood Test",
        "date": "22 October 2023",
        "findings": "Hemoglobin: 13.5 g/dL",
        "comments": "Levels are normal",
      },
      "radiologyReport": {
        "type": "X-Ray",
        "date": "20 October 2023",
        "summary": "No fractures detected",
        "notes": "No abnormalities",
      },
    },
    // Additional appointments with similar structure...
  ];

  final double monthContainerWidth = 95.0;
  final String targetDoctor = "Dr. Mohamed Jarwan"; // Doctor's name for filtering

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "History",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const history_visits(),
              ),
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
        elevation: 4.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: List.generate(appointments.length, (index) {
              final appointment = appointments[index];
              if (appointment["doctor"] == targetDoctor) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: _buildAppointmentCard(context, appointment),
                );
              } else {
                return Container();
              }
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildAppointmentCard(BuildContext context, Map<String, dynamic> appointment) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: monthContainerWidth,
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      appointment["date"] ?? "-",
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      appointment["month"] ?? "-",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointment["specialty"] ?? "Specialty not available",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Doctor: ${appointment["doctor"] ?? "N/A"}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                    Text(
                      "Patient: ${appointment["patient"] ?? "N/A"}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "ICD-10 Code: ${appointment["ICD10"] ?? "N/A"}, Disease: ${appointment["disease"] ?? "N/A"}",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                appointment["time"] ?? "Time not specified",
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
              TextButton(
                onPressed: () {
                  _showPrescriptionDetailsDialog(context, appointment);
                },
                child: Text(
                  "View Details",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.blue[700],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showPrescriptionDetailsDialog(BuildContext context, Map<String, dynamic> appointment) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.medical_services, color: Colors.blue, size: 28),
                      SizedBox(width: 8),
                      Text(
                        "Prescription Details",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  _buildDetailRow("Specialty", appointment["specialty"]),
                  const Divider(),
                  _buildDetailRow("Doctor", appointment["doctor"]),
                  const Divider(),
                  _buildDetailRow("ICD-10 Code", appointment["ICD10"]),
                  const Divider(),
                  _buildDetailRow("Disease", appointment["disease"]),
                  const Divider(),
                  _buildDetailRow("Medication", appointment["medication"]),
                  const Divider(),
                  _buildDetailRow("Dosage", appointment["dosage"]),
                  const Divider(),
                  _buildDetailRow("Issued Date", appointment["issuedDate"]),
                  const Divider(),
                  _buildDetailRow("Next Appointment", appointment["nextAppointment"]),
                  if (appointment["includeLabReports"] == true && appointment["labReport"] != null) ...[
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Icon(Icons.analytics, color: Colors.orange, size: 24),
                        const SizedBox(width: 8),
                        Text(
                          "Lab Reports",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange[700],
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    _buildDetailRow("Report Type", appointment["labReport"]["type"]),
                    _buildDetailRow("Report Date", appointment["labReport"]["date"]),
                    _buildDetailRow("Key Findings", appointment["labReport"]["findings"]),
                    _buildDetailRow("Doctor’s Comments", appointment["labReport"]["comments"]),
                  ],
                  if (appointment["includeRadiology"] == true && appointment["radiologyReport"] != null) ...[
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Icon(Icons.image, color: Colors.purple, size: 24),
                        const SizedBox(width: 8),
                        Text(
                          "Radiology",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple[700],
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    _buildDetailRow("Imaging Type", appointment["radiologyReport"]["type"]),
                    _buildDetailRow("Scan Date", appointment["radiologyReport"]["date"]),
                    _buildDetailRow("Findings Summary", appointment["radiologyReport"]["summary"]),
                    _buildDetailRow("Radiologist’s Notes", appointment["radiologyReport"]["notes"]),
                  ],
                  const SizedBox(height: 16),
                  TextButton(
                    child: const Text("Close", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, dynamic value) {
    final displayValue = value ?? "Not available";
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: Text(
              displayValue,
              style: const TextStyle(color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}
