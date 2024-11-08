import 'package:flutter/material.dart';
import 'package:tess/patient_screen/patient_appointmnet/patient_appointment_confirmchoices.dart';
import 'package:tess/patient_screen/patient_appointmnet/patient_appointment_pick_date.dart';

class patient_appointment_payment extends StatefulWidget {
  final String doctorSpecialty; // Pass doctor specialty to fetch relevant prices

  const patient_appointment_payment({Key? key, required this.doctorSpecialty})
      : super(key: key);

  @override
  _PatientAppointmentPaymentState createState() =>
      _PatientAppointmentPaymentState();
}

class _PatientAppointmentPaymentState extends State<patient_appointment_payment> {
  double doctorFee = 0.0;
  double serviceCharge = 0.0;
  double totalAmount = 0.0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPrices();
  }

  Future<void> _fetchPrices() async {
    // Simulate a database fetch with a delay
    final prices = await fetchPricesFromDatabase(widget.doctorSpecialty);
    
    setState(() {
      doctorFee = prices['doctorFee'] ?? 0.0;
      serviceCharge = prices['serviceCharge'] ?? 0.0;
      totalAmount = doctorFee + serviceCharge;
      isLoading = false;
    });
  }

  Future<Map<String, double>> fetchPricesFromDatabase(String specialty) async {
    // Replace this with actual database code to fetch prices
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
    
    // Mock data based on specialty
    switch (specialty) {
      case "Cardiologist":
        return {"doctorFee": 70.0, "serviceCharge": 40.0};
      case "Dermatologist":
        return {"doctorFee": 50.0, "serviceCharge": 30.0};
      case "Pediatrician":
        return {"doctorFee": 60.0, "serviceCharge": 35.0};
      default:
        return {"doctorFee": 50.0, "serviceCharge": 30.0};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
             Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => patient_appointment_pick_date()),
                          );
          },
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
        title: const Text(
          "Service Cost Estimation",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Service Details",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Diagnosis Service",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              Icon(Icons.medical_services,
                                  color: Colors.blueAccent),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Doctor's Fee",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black54),
                              ),
                              Text(
                                "JOD $doctorFee",
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black87),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Service Charge",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black54),
                              ),
                              Text(
                                "JOD $serviceCharge",
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black87),
                              ),
                            ],
                          ),
                          const Divider(height: 32, color: Colors.grey),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Total Amount",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                "JOD $totalAmount",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.blue, Colors.purple],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 12),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const patient_appointment_confirmchoices()),
                          );
                        },
                        child: const Text(
                          "Confirm",
                          style: TextStyle(
                            fontSize: 16,
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
    );
  }
}
