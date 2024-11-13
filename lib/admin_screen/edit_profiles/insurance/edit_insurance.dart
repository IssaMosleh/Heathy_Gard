import 'package:flutter/material.dart';
import 'package:tess/admin_screen/edit_profiles/edit_profiles_main.dart';
import 'package:tess/admin_screen/edit_profiles/insurance/show_details_companies.dart';

class InsuranceCompany {
  final String id;
  final String name;
  final String imageUrl;

  InsuranceCompany({required this.id, required this.name, required this.imageUrl});
}

class InsuranceCompanySearchScreen extends StatefulWidget {
  const InsuranceCompanySearchScreen({Key? key}) : super(key: key);

  @override
  _InsuranceCompanySearchScreenState createState() => _InsuranceCompanySearchScreenState();
}

class _InsuranceCompanySearchScreenState extends State<InsuranceCompanySearchScreen> {
  List<InsuranceCompany> insuranceCompanies = [
    InsuranceCompany(id: '001', name: 'Allianz', imageUrl: 'https://via.placeholder.com/150'),
    InsuranceCompany(id: '002', name: 'MetLife', imageUrl: 'https://via.placeholder.com/150'),
    InsuranceCompany(id: '003', name: 'Cigna', imageUrl: 'https://via.placeholder.com/150'),
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    List<InsuranceCompany> filteredInsuranceCompanies = insuranceCompanies
        .where((company) =>
            searchQuery.isEmpty ||
            company.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
            company.id.contains(searchQuery))
        .toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const edit_profiles_main()),
            );
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: const Text(
          "Search Insurance Companies",
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

            // List of insurance company cards with navigation
            Expanded(
              child: ListView.builder(
                itemCount: filteredInsuranceCompanies.length,
                itemBuilder: (context, index) {
                  final company = filteredInsuranceCompanies[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(company.imageUrl),
                        radius: 30,
                      ),
                      title: Text(
                        company.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      subtitle: Text(
                        'ID: ${company.id}',
                        style: TextStyle(
                          color: Colors.blueGrey[800],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.blueGrey[800],
                        size: 16,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const InsuranceCompanyDetails(),
                          ),
                        );
                      },
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
