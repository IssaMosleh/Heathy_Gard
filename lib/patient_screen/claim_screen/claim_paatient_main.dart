import 'package:flutter/material.dart';
import 'package:tess/patient_screen/claim_screen/claim_patient_add_claim.dart';
import 'package:tess/patient_screen/claim_screen/claim_patient_infroduction.dart';

class claim_paatient_main extends StatelessWidget {
  const claim_paatient_main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ClaimCenterScreen(),
    );
  }
}

class ClaimCenterScreen extends StatefulWidget {
  const ClaimCenterScreen({Key? key}) : super(key: key);

  @override
  _ClaimCenterScreenState createState() => _ClaimCenterScreenState();
}

class _ClaimCenterScreenState extends State<ClaimCenterScreen> {
  void _addNewClaim() {
     Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => claim_patient_add_claim()),
                    );         
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Claim Center',style: TextStyle(color: Colors.white),),
          leading: IconButton(onPressed: (){
            Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => claim_patient_infroduction()),
                    );         
          }, icon: Icon(Icons.arrow_back_ios),color: Colors.white,),
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
          bottom: const TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: 'Active Claims'),
              Tab(text: 'Accepted Claims'),
              Tab(text: 'Denied Claims'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ClaimsList(claimStatus: 'Active'),
            ClaimsList(claimStatus: 'Accepted'),
            ClaimsList(claimStatus: 'Denied'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addNewClaim,
          backgroundColor: Colors.blue,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}

class ClaimsList extends StatelessWidget {
  final String claimStatus;

  const ClaimsList({Key? key, required this.claimStatus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Updated dummy data with 9 entries representing claims with additional details
    final List<Map<String, String>> claims = List.generate(9, (index) {
      return {
        'id': 'CLM${1000 + index}',
        'date': '2024-10-${index + 1 < 10 ? '0${index + 1}' : index + 1}',
        'amount': '\$${(100 + index * 50)}',
        'hospital': 'Hospital ${index + 1}',
        'doctor': 'Dr. ${['Smith', 'Johnson', 'Lee', 'Brown', 'Wilson', 'Taylor', 'Clark', 'Davis', 'White'][index]}'
      };
    });

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: claims.map((claim) => _buildClaimCard(claim)).toList(),
        ),
      ),
    );
  }

  Widget _buildClaimCard(Map<String, String> claim) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 6.0,
      shadowColor: Colors.blue.withOpacity(0.3),
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Claim ID: ${claim['id']}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Date: ${claim['date']}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  'Amount: ${claim['amount']}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Hospital: ${claim['hospital']}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Doctor: ${claim['doctor']}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.bottomRight,
              child: Icon(
                claimStatus == 'Active'
                    ? Icons.timelapse
                    : claimStatus == 'Accepted'
                        ? Icons.check_circle
                        : Icons.cancel,
                color: claimStatus == 'Active'
                    ? Colors.orange
                    : claimStatus == 'Accepted'
                        ? Colors.green
                        : Colors.red,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}