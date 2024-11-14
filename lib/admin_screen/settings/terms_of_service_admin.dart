import 'package:flutter/material.dart';
import 'package:tess/admin_screen/settings_admin.dart';


class terms_of_service_admin extends StatelessWidget {
  const terms_of_service_admin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => settings_admin()),
            );
        }, icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
        title: const Text('Terms of Service', style: TextStyle(color: Colors.white)),
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
                "By using our pharmacy services, you agree to the following terms:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                "• You must be 18 years or older to use our prescription services.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),
              const Text(
                "• We reserve the right to update these terms at any time.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),
              const Text(
                "• Our pharmacy is not responsible for the misuse of prescribed medication.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              const Text(
                "We recommend reviewing these terms regularly to stay informed about any updates.",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              Center(
                child: const Text(
                  "Thank you for choosing our pharmacy services!",
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
