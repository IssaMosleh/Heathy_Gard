import 'package:flutter/material.dart';
import 'package:tess/patient_screen/settings_patient.dart';
import 'package:url_launcher/url_launcher.dart';

class promotions_patient extends StatelessWidget {
  const promotions_patient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PromotionScreen(),
    );
  }
}

class PromotionScreen extends StatefulWidget {
  const PromotionScreen({Key? key}) : super(key: key);

  @override
  _PromotionScreenState createState() => _PromotionScreenState();
}

class _PromotionScreenState extends State<PromotionScreen> {
  List<Map<String, dynamic>> insurancePlans = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPromotions();
  }

  Future<void> fetchPromotions() async {
    // Simulate fetching data from a database
    await Future.delayed(const Duration(seconds: 2)); // Simulated network delay
    setState(() {
      insurancePlans = [
        {
          'company': 'ABC Health Insurance',
          'plan': 'Comprehensive Health Plan',
          'description': 'Full coverage including hospitalization, surgeries, and outpatient care.',
          'customerCount': 27666,
          'url': 'https://example.com/abc-health',
        },
        {
          'company': 'Healthy Life Insurance',
          'plan': 'Family Protection Plan',
          'description': 'A family plan that covers medical expenses and annual checkups.',
          'customerCount': 14350,
          'url': 'https://example.com/healthy-life',
        },
        {
          'company': 'SecureWell Insurance',
          'plan': 'Senior Citizen Health Plan',
          'description': 'Plan for senior citizens, covering critical illnesses and more.',
          'customerCount': 10880,
          'url': 'https://example.com/securewell',
        },
        {
          'company': 'HealthPlus',
          'plan': 'Basic Health Plan',
          'description': 'Affordable health plan covering major medical expenses and emergencies.',
          'customerCount': 35680,
          'url': 'https://example.com/healthplus',
        },
      ];
      isLoading = false;
    });
  }

  Future<void> launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
           Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => settings_patient()),
                    ); 
        }, icon: Icon(Icons.arrow_back_ios), color: Colors.white,),
        title: const Text('Insurance Promotions', style: TextStyle(color: Colors.white),),
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
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: insurancePlans.length,
                itemBuilder: (context, index) {
                  final plan = insurancePlans[index];
                  return PromotionCard(
                    company: plan['company']!,
                    planName: plan['plan']!,
                    description: plan['description']!,
                    customerCount: plan['customerCount']!,
                    url: plan['url']!,
                    onLearnMore: () => launchURL(plan['url']!),
                  );
                },
              ),
            ),
    );
  }
}

class PromotionCard extends StatelessWidget {
  final String company;
  final String planName;
  final String description;
  final int customerCount;
  final String url;
  final VoidCallback onLearnMore;

  const PromotionCard({
    Key? key,
    required this.company,
    required this.planName,
    required this.description,
    required this.customerCount,
    required this.url,
    required this.onLearnMore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            company,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.people, color: Colors.blueAccent, size: 16),
              const SizedBox(width: 4),
              Text(
                'Trusted by $customerCount customers',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.blueAccent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            planName,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Button background color
                foregroundColor: Colors.white, // Button text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: onLearnMore,
              child: const Text(
                'Learn More',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}