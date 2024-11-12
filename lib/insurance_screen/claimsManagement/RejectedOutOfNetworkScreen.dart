import 'package:flutter/material.dart';
import 'package:tess/insurance_screen/claimsManagement/ClaimsManagement.dart';
import 'package:url_launcher/url_launcher.dart';

class RejectedOutOfNetworkScreen extends StatelessWidget {
  final Map<String, dynamic> claim;

  RejectedOutOfNetworkScreen({required this.claim});

  final String rejectionReason = 'Out-of-Network Provider';
  final String rejectionDescription = 'This claim was rejected because it involves services provided by an out-of-network provider. Claims for out-of-network providers are not covered under the current insurance policy.';

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
        title: Text('Out-of-Network Rejected Claim Details',style:TextStyle(color: Colors.white),),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Claim Basic Information
            buildSectionTitle('Claim Information'),
            buildInfoRow('Claim ID', claim['id']),
            buildInfoRow('Patient Name', claim['patientName']),
            buildInfoRow('Date', claim['date']),
            buildInfoRow('Network', claim['network'], color: Colors.red),
            SizedBox(height: 20),

            // Provider Information
            buildSectionTitle('Provider Information'),
            buildEnhancedInfoRow(
              icon: Icons.local_hospital,
              label: 'Hospital',
              value: claim['hospitalName'] ?? 'Not Available',
            ),
            buildEnhancedInfoRow(
              icon: Icons.person,
              label: 'Doctor',
              value: claim['doctorName'] ?? 'Not Available',
            ),
            buildEnhancedInfoRow(
              icon: Icons.attach_money,
              label: 'Total Amount Claimed',
              value: claim['totalAmount'] != null ? '\$${claim['totalAmount']}' : 'Not Available',
            ),
            SizedBox(height: 20),

            // Rejection Details
            buildSectionTitle('Rejection Details'),
            buildRejectionCard(rejectionReason, rejectionDescription),
            SizedBox(height: 20),

            // Supporting Documents
            buildSectionTitle('Supporting Documents'),
            buildSectionSubtitle('Bills'),
            ...List.generate(3, (index) => buildDocumentContainer('Bill ${index + 1}')),

            buildSectionSubtitle('Treatment Plans'),
            ...List.generate(7, (index) => buildDocumentContainer('Treatment Plan ${index + 1}')),

            buildSectionSubtitle('Lab Results'),
            buildDocumentContainer('Lab Results'),

            buildSectionSubtitle('Radiology Results'),
            buildDocumentContainer('Radiology Results'),
          ],
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildSectionSubtitle(String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        subtitle,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget buildInfoRow(String label, dynamic value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Text(
            value?.toString() ?? 'N/A',
            style: TextStyle(
              fontSize: 16,
              color: color ?? Colors.black87,
              fontWeight: value != null ? FontWeight.w400 : FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildEnhancedInfoRow({required IconData icon, required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

  Widget buildRejectionCard(String reason, String description) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      color: Colors.red[50],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reason: $reason',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(fontSize: 15, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDocumentContainer(String title) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[400]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$title (PDF)',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          IconButton(
            icon: Icon(Icons.download_rounded),
            onPressed: () async {
              const url = 'https://example.com';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
          ),
        ],
      ),
    );
  }
}
