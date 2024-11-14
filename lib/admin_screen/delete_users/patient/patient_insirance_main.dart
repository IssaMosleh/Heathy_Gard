import 'package:flutter/material.dart';

class Patient {
  final String id;
  final String name;
  final String insuranceCompany;
  final String imageUrl;

  Patient({required this.id, required this.name, required this.insuranceCompany, required this.imageUrl});
}

class PatientSearchScreen_delete extends StatefulWidget {
  const PatientSearchScreen_delete({Key? key}) : super(key: key);

  @override
  _PatientSearchScreenState createState() => _PatientSearchScreenState();
}

class _PatientSearchScreenState extends State<PatientSearchScreen_delete> {
  List<Patient> patients = [
    Patient(id: '001', name: 'John Doe', insuranceCompany: 'Allianz', imageUrl: 'https://via.placeholder.com/150'),
    Patient(id: '002', name: 'Jane Smith', insuranceCompany: 'MetLife', imageUrl: 'https://via.placeholder.com/150'),
    Patient(id: '003', name: 'Alice Johnson', insuranceCompany: 'Cigna', imageUrl: 'https://via.placeholder.com/150'),
  ];

  String searchQuery = '';
  String selectedInsuranceCompany = 'All';

  @override
  Widget build(BuildContext context) {
    List<Patient> filteredPatients = patients
        .where((patient) =>
            (searchQuery.isEmpty ||
                patient.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
                patient.id.contains(searchQuery)) &&
            (selectedInsuranceCompany == 'All' || patient.insuranceCompany == selectedInsuranceCompany))
        .toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: const Text(
          "Search Patients",
          style: TextStyle(color: Colors.white),
        ),
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
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search bar
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  colors: [Colors.blue, Colors.purple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: TextField(
                onChanged: (query) {
                  setState(() {
                    searchQuery = query;
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.9),
                  labelText: 'Search by name or ID',
                  labelStyle: TextStyle(color: Colors.blueGrey[800]),
                  prefixIcon: const Icon(Icons.search, color: Colors.blue),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Filter dropdown
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  colors: [Colors.blue, Colors.purple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: DropdownButtonFormField<String>(
                value: selectedInsuranceCompany,
                onChanged: (value) {
                  setState(() {
                    selectedInsuranceCompany = value!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Filter by Insurance Company',
                  labelStyle: TextStyle(color: Colors.blueGrey[800]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.9),
                ),
                items: ['All', 'Allianz', 'MetLife', 'Cigna']
                    .map((insurance) => DropdownMenuItem(
                          value: insurance,
                          child: Text(
                            insurance,
                            style: const TextStyle(color: Colors.blue),
                          ),
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(height: 16),

            // List of patient cards with delete functionality
            Expanded(
              child: ListView.builder(
                itemCount: filteredPatients.length,
                itemBuilder: (context, index) {
                  final patient = filteredPatients[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(patient.imageUrl),
                        radius: 30,
                      ),
                      title: Text(
                        patient.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ID: ${patient.id}',
                            style: TextStyle(
                              color: Colors.blueGrey[800],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Insurance: ${patient.insuranceCompany}',
                            style: TextStyle(
                              color: Colors.blueGrey[800],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            patients.remove(patient);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${patient.name} has been deleted')),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
