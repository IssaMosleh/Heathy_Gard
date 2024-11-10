import 'package:flutter/material.dart';
import 'package:tess/pharmacy_screen/settings_pharmacy.dart';

class PharmacyPartnersScreen extends StatelessWidget {
  const PharmacyPartnersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => settings_pharmacy()),
            );
        }, icon: Icon(Icons.arrow_back_ios),color: Colors.white,),
        title: const Text('Our Pharmacy Partners', style: TextStyle(color: Colors.white)),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "We work with trusted pharmaceutical companies and suppliers to bring you the best in medications and healthcare products.",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              _buildPartnerCard('PharmaCorp', 'Top supplier of generic and branded medications'),
              _buildPartnerCard('MediPharm', 'Leading distributor of over-the-counter products'),
              _buildPartnerCard('HealthPlus', 'Pharmacy with a focus on wellness and preventative care'),
              _buildPartnerCard('CareMeds', 'Affordable and accessible medications for everyone'),
              _buildPartnerCard('GlobalPharm', 'International supplier of advanced pharmaceutical products'),
              _buildPartnerCard('WellMed', 'Health-focused pharmacy with personalized services'),
              _buildPartnerCard('CureRx', 'Innovative solutions for chronic disease management'),
              _buildPartnerCard('MedLink', 'Connecting patients with the best medications and treatments'),
              _buildPartnerCard('RxPlus', 'Providing affordable solutions for healthcare needs'),
              _buildPartnerCard('PharmaGlobal', 'International pharmaceutical distributor with a focus on quality'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPartnerCard(String name, String description) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        title: Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text(description, style: const TextStyle(fontSize: 14)),
      ),
    );
  }
}
