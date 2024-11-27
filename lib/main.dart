import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tess/admin_screen/mainadminscreen.dart';
import 'package:tess/doctor_screen/mainscreendoctor.dart';
import 'package:tess/forgetpass.dart';
import 'package:tess/insurance_screen/maininsurancescreen.dart';
import 'package:tess/lab_radiology_screen/main.dart';
import 'package:tess/patient_screen/mainscreenpatient.dart';
import 'package:tess/pharmacy_screen/mainscreenpharmacy.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MainApp()));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  _MainAppState createState() => _MainAppState();
}

// Mock database for roles
final Map<String, String> mockDatabase = {
  "123": "patient",
  "456": "doctor",
  "789": "lab",
  "111": "insurance",
  "222": "pharmacy",
  "333": "admin",
};

// Function to get user role based on ID
String getRole(String userId) {
  return mockDatabase[userId] ??
      "undefined"; // returns role or "undefined" if userId doesn't exist
}

class _MainAppState extends State<MainApp> {
    TextEditingController nationalNumberController = TextEditingController();
  // Function to launch URLs
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.35,
                width: double.infinity,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: Image.asset(
                        "images/Vector.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 40,
                      left: 0,
                      right: 0,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            "images/logo.png",
                            height: MediaQuery.of(context).size.height * 0.1,
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Healthy Guard",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Colors.purple, Colors.blue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: const Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: TextField(
                  controller: nationalNumberController,
                  decoration: InputDecoration(
                    hintText: 'National ID Number',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 20.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Password',
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 20.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  String role = getRole(nationalNumberController.text);
                  print("Login button pressed");
                  if (role == "patient") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Patient_Screen()),
                    );
                  } else if (role == "doctor") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Doctor_Screen()),
                    );
                  } else if (role == "lab") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Doctor_LAB()),
                    );
                  } else if (role == "insurance") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const InsuranceRep_Screen()),
                    );
                  } else if (role == "pharmacy") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Pharmacy_Screen()),
                    );
                  } else if (role == "admin") {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AdminScreen()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text("Role not found for number: $nationalNumberController.text")),
                    );
                  }
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.8,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(
                      colors: [Colors.purple, Colors.blue],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Colors.blue, Colors.purple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const forgetpassmain(),
                      ),
                    );
                  },
                  child: const Text(
                    'Forgot your password?',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      _launchURL('https://twitter.com');
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.xTwitter,
                      color: Colors.black,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _launchURL('https://facebook.com');
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.facebook,
                      color: Colors.blue,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _launchURL('https://instagram.com');
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.instagram,
                      color: Colors.red,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _launchURL('https://linkedin.com');
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.linkedin,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
