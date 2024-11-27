import 'package:flutter/material.dart';
import 'package:tess/insurance_screen/claimsManagement/ApprovedClaimScreen.dart';
import 'package:tess/insurance_screen/claimsManagement/ApprovedOutOfNetworkScreen.dart';
import 'package:tess/insurance_screen/claimsManagement/OutOfNetworkPendingScreen.dart';
import 'package:tess/insurance_screen/claimsManagement/PendingClaimScreen.dart';
import 'package:tess/insurance_screen/claimsManagement/RejectedClaimScreen.dart';
import 'package:tess/insurance_screen/claimsManagement/RejectedOutOfNetworkScreen.dart';
import 'package:tess/insurance_screen/maininsurancescreen.dart';

class ClaimsManagementScreen extends StatefulWidget {
  const ClaimsManagementScreen({super.key});

  @override
  _ClaimsManagementScreenState createState() => _ClaimsManagementScreenState();
}

class _ClaimsManagementScreenState extends State<ClaimsManagementScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String searchQuery = '';
  List<Map<String, dynamic>> claims = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    fetchClaimsData();
  }

  Future<void> fetchClaimsData() async {
    await Future.delayed(const Duration(seconds: 2));

    List<Map<String, dynamic>> fetchedClaims = [
      // Pending In-Network Example
      {
        'id': 'CLM-001',
        'patientName': 'John Doe',
        'date': '2024-11-10',
        'status': 'Pending',
        'network': 'In-Network',
        'amount': '\$1500',
      },
      // Pending Out-of-Network Example
      {
        'id': 'CLM-002',
        'patientName': 'Alice Smith',
        'date': '2024-11-05',
        'status': 'Pending',
        'network': 'Out-of-Network',
        'amount': '\$700',
      },
      // Approved In-Network Example
      {
        'id': 'CLM-003',
        'patientName': 'Mike Taylor',
        'date': '2024-11-12',
        'status': 'Approved',
        'network': 'In-Network',
        'amount': '\$800',
      },
      // Approved Out-of-Network Example
      {
        'id': 'CLM-004',
        'patientName': 'Sarah Lee',
        'date': '2024-11-11',
        'status': 'Approved',
        'network': 'Out-of-Network',
        'amount': '\$1200',
      },
      // Rejected In-Network Example
      {
        'id': 'CLM-005',
        'patientName': 'Bob Johnson',
        'date': '2024-11-01',
        'status': 'Rejected',
        'network': 'In-Network',
        'amount': '\$500',
      },
      // Rejected Out-of-Network Example
      {
        'id': 'CLM-006',
        'patientName': 'Laura White',
        'date': '2024-10-28',
        'status': 'Rejected',
        'network': 'Out-of-Network',
        'amount': '\$400',
      },
    ];

    setState(() {
      claims = fetchedClaims;
      isLoading = false;
    });
  }

  void openClaimDetails(Map<String, dynamic> claim) {
    if (claim['status'] == 'Pending') {
      if (claim['network'] == 'Out-of-Network') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OutOfNetworkPendingScreen(claim: claim)),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PendingClaimScreen(claim: claim)),
        );
      }
    } else if (claim['status'] == 'Approved') {
      if (claim['network'] == 'Out-of-Network') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ApprovedOutOfNetworkScreen(claim: claim)),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ApprovedClaimScreen(claim: claim)),
        );
      }
    } else if (claim['status'] == 'Rejected') {
      if (claim['network'] == 'Out-of-Network') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RejectedOutOfNetworkScreen(claim: claim)),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RejectedClaimScreen(claim: claim)),
        );
      }
    }
  }

  List<Map<String, dynamic>> getFilteredClaims(String status) {
    return claims
        .where((claim) =>
            claim['status'] == status &&
            (claim['patientName']
                    .toLowerCase()
                    .contains(searchQuery.toLowerCase()) ||
                claim['id'].toLowerCase().contains(searchQuery.toLowerCase())))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
           Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const InsuranceRep_Screen()),
        );
        }, icon: const Icon(Icons.arrow_back_ios,color: Colors.white,)),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text('Claims Management',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blueAccent,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          tabs: const [
            Tab(text: 'Pending'),
            Tab(text: 'Approved'),
            Tab(text: 'Rejected'),
          ],
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search by Patient Name or Claim ID',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      buildClaimList('Pending'),
                      buildClaimList('Approved'),
                      buildClaimList('Rejected'),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget buildClaimList(String status) {
    final filteredClaims = getFilteredClaims(status);

    return filteredClaims.isEmpty
        ? Center(child: Text('No claims found for "$status" status.'))
        : ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: filteredClaims.length,
            itemBuilder: (context, index) {
              final claim = filteredClaims[index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(
                    'Claim ID: ${claim['id']}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Patient: ${claim['patientName']}'),
                      Text('Date: ${claim['date']}'),
                      Text('Amount: ${claim['amount']}'),
                      Text('Network: ${claim['network']}'),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Text(
                            'Status: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            claim['status'],
                            style: TextStyle(
                              color: claim['status'] == 'Approved'
                                  ? Colors.green
                                  : claim['status'] == 'Rejected'
                                      ? Colors.red
                                      : Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () => openClaimDetails(claim),
                ),
              );
            },
          );
  }
}
