import 'package:flutter/material.dart';
import 'package:tess/admin_screen/settings_admin.dart';


class privacy_policy_admin extends StatelessWidget {
  const privacy_policy_admin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => settings_admin()),
            );
        }, icon: Icon(Icons.arrow_back_ios),color: Colors.white,),
        title: const Text('Privacy Policy', style: TextStyle(color: Colors.white)),
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
                "At our pharmacy, we take your privacy seriously. Here's how we handle your information:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                "• We collect personal and prescription information for processing your orders.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),
              const Text(
                "• Your information is kept secure, and is only shared with healthcare providers when necessary.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),
              const Text(
                "• We comply with privacy regulations to protect your health data.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                "We understand the importance of your privacy and are committed to protecting it. If you have any questions regarding our privacy policy, feel free to contact us.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Center(
                child: const Text(
                  "Thank you for trusting us!",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
