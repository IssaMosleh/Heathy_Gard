import 'package:flutter/material.dart';
import 'package:tess/admin_screen/add_new_users/doctor/doctor_add_new.dart';
import 'package:tess/admin_screen/add_new_users/hospital/new_hospital.dart';
import 'package:tess/admin_screen/add_new_users/insurance/insurance_add.dart';
import 'package:tess/admin_screen/add_new_users/insurance_represenitive/insurance_represenitive_add.dart';
import 'package:tess/admin_screen/add_new_users/patient/patient_add.dart';
import 'package:tess/admin_screen/main.dart';

class add_new_main extends StatelessWidget {
  const add_new_main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56.0),
          child: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 0,
            title: ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Colors.blue, Colors.purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: const Text(
                "Select Screen",
                style: TextStyle(
                  color: Colors.white, // This color is ignored due to the shader
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AdminScreen()),
                );
              },
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AdminScreen()),
                    );
                  },
                  icon: Image.asset(
                    'images/icon1.png', // Replace with your icon path
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1.0),
              child: Container(
                color: Colors.black,
                height: 1.0,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select One Of The Below Entities',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  shrinkWrap: true, // Added shrinkWrap to handle overflow
                  children: [
                    _buildOptionCard(
                      context,
                      'Hospital',
                      'images/Hospital.png', // Replace with your image path
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const new_hospital()),
                        );
                      },
                    ),
                    _buildOptionCard(
                      context,
                      'Patient',
                      'images/personalinfo.png', // Replace with your image path
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const patient_add()),
                        );
                      },
                    ),
                    _buildOptionCard(
                      context,
                      'Insurance',
                      'images/healthinsurance.png', // Replace with your image path
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const insurance_add()),
                        );
                      },
                    ),
                    _buildOptionCard(
                      context,
                      'Doctor',
                      'images/doctorss.png', // Replace with your new image path
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const doctor_add_new()),
                        );
                      },
                    ),
                    _buildOptionCard(
                      context,
                      'Insurance Representative',
                      'images/insurance_represenitive.jpg', // Replace with the actual path of the image
                      onTap: () {
                         Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const insurance_represenitive_add()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionCard(
    BuildContext context,
    String title,
    String imagePath, {
    required VoidCallback onTap,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 3,
      child: InkWell(
        onTap: onTap, // Use the specific onTap callback for this card
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                width: 60,
                height: 60,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
