import 'package:flutter/material.dart';

class InsuranceRep {
  final String id;
  final String name;
  final String insuranceCompany;
  final String imageUrl;

  InsuranceRep({required this.id, required this.name, required this.insuranceCompany, required this.imageUrl});
}

class InsuranceRepSearchScreen_delete extends StatefulWidget {
  const InsuranceRepSearchScreen_delete({Key? key}) : super(key: key);

  @override
  _InsuranceRepSearchScreenState createState() => _InsuranceRepSearchScreenState();
}

class _InsuranceRepSearchScreenState extends State<InsuranceRepSearchScreen_delete> {
  List<InsuranceRep> insuranceReps = [
    InsuranceRep(id: '001', name: 'Sam Brown', insuranceCompany: 'Allianz', imageUrl: 'https://via.placeholder.com/150'),
    InsuranceRep(id: '002', name: 'Lucy Grey', insuranceCompany: 'MetLife', imageUrl: 'https://via.placeholder.com/150'),
    InsuranceRep(id: '003', name: 'Tom White', insuranceCompany: 'Cigna', imageUrl: 'https://via.placeholder.com/150'),
  ];

  String searchQuery = '';
  String selectedInsuranceCompany = 'All';

  @override
  Widget build(BuildContext context) {
    List<InsuranceRep> filteredReps = insuranceReps
        .where((rep) =>
            (searchQuery.isEmpty ||
                rep.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
                rep.id.contains(searchQuery)) &&
            (selectedInsuranceCompany == 'All' || rep.insuranceCompany == selectedInsuranceCompany))
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
          "Search Insurance Representatives",
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

            // List of insurance rep cards with delete functionality
            Expanded(
              child: ListView.builder(
                itemCount: filteredReps.length,
                itemBuilder: (context, index) {
                  final rep = filteredReps[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(rep.imageUrl),
                        radius: 30,
                      ),
                      title: Text(
                        rep.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ID: ${rep.id}',
                            style: TextStyle(
                              color: Colors.blueGrey[800],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Insurance: ${rep.insuranceCompany}',
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
                            insuranceReps.remove(rep);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${rep.name} has been deleted')),
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
