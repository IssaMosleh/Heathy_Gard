import 'package:flutter/material.dart';
import 'package:tess/insurance_screen/claimsManagement/ClaimsManagement.dart';
import 'package:url_launcher/url_launcher.dart';

class ApprovedOutOfNetworkScreen extends StatelessWidget {
  final Map<String, dynamic> claim;

  const ApprovedOutOfNetworkScreen({super.key, required this.claim});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
           Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ClaimsManagementScreen()),
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
        title: const Text('Out-of-Network Claim Details',style: TextStyle(color: Colors.white),),
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
            const SizedBox(height: 20),

            // Enhanced Provider Information Section
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
            const SizedBox(height: 20),

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
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildSectionSubtitle(String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        subtitle,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

  Widget buildDocumentContainer(String title) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 8),
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
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          IconButton(
            icon: const Icon(Icons.download_rounded),
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
