import 'package:flutter/material.dart';
import 'package:tess/insurance_screen/claimsManagement/ClaimsManagement.dart';
import 'package:tess/insurance_screen/claimsManagement/Reject_Screen.dart';
import 'package:url_launcher/url_launcher.dart';

class OutOfNetworkPendingScreen extends StatelessWidget {
  final Map<String, dynamic> claim;

  const OutOfNetworkPendingScreen({super.key, required this.claim});

  @override
  Widget build(BuildContext context) {
    TextEditingController approvedAmountController = TextEditingController();

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
            buildEnhancedInfoRow(
              icon: Icons.account_balance_wallet,
              label: 'Available Balance',
              value: claim['availableBalance'] != null ? '\$${claim['availableBalance']}' : 'Not Available',
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

            const SizedBox(height: 20),
            const Divider(),

            // Approved Amount Entry
            buildSectionTitle('Insurance Approved Amount'),
            const Text(
              'Enter Approved Amount (Insurance Pricing):',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: approvedAmountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter amount',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Action Buttons
            buildActionButtons(context, approvedAmountController),
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

  Widget buildActionButtons(BuildContext context, TextEditingController approvedAmountController) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              String approvedAmountText = approvedAmountController.text;
              double requestedAmount = claim['totalAmount'];
              double availableBalance = claim['availableBalance'];
              double approvedAmount = approvedAmountText.isEmpty
                  ? requestedAmount
                  : double.tryParse(approvedAmountText) ?? requestedAmount;

              if (approvedAmount > availableBalance) {
                // Show error if insufficient balance
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Error: Insufficient available balance')),
                );
              } else if (approvedAmount > requestedAmount) {
                // Show error if amount entered is higher than requested
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Error: Approved amount must be equal to or less than the requested amount')),
                );
              } else {
                // Proceed with approval if valid amount
                Navigator.pop(context, {'status': 'Approved', 'amount': approvedAmount.toString()});
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            icon: const Icon(Icons.check, color: Colors.white),
            label: const Text(
              'Approve',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RejectScreen()),
            );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            icon: const Icon(Icons.close, color: Colors.white),
            label: const Text(
              'Reject',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
