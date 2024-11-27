import 'package:flutter/material.dart';
import 'package:tess/main.dart';
import 'package:tess/patient_screen/appointment_main_patient.dart';
import 'package:tess/patient_screen/mainscreenpatient.dart';
import 'package:tess/patient_screen/notification_patient.dart';
import 'package:tess/patient_screen/settings_patient/about_us_patient.dart';
import 'package:tess/patient_screen/settings_patient/help_and_support_patient.dart';
import 'package:tess/patient_screen/settings_patient/our_partners_patient.dart';
import 'package:tess/patient_screen/settings_patient/privacy_policy_patient.dart';
import 'package:tess/patient_screen/settings_patient/promotions_patient.dart';
import 'package:tess/patient_screen/settings_patient/terms_and_service_patient.dart';

class settings_patient extends StatelessWidget {
  const settings_patient({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
      home: SettingsScreen(),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
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
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        children: [
          SettingsTile(
            icon: Icons.info,
            title: 'About Us',
            iconColor: Colors.blue,
            onTap: () {
               Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const about_us_patient()),
                    ); 
            },
          ),
          SettingsTile(
            icon: Icons.local_offer,
            title: 'Promotions',
            iconColor: Colors.green,
            onTap: () {
               Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const promotions_patient()),
                    ); 
            },
          ),
          SettingsTile(
            icon: Icons.business,
            title: 'Our Partners',
            iconColor: Colors.purple,
            onTap: () {
              Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const our_partners_patient()),
                    ); 
            },
          ),
          SettingsTile(
            icon: Icons.privacy_tip,
            title: 'Privacy Policy',
            iconColor: Colors.indigo,
            onTap: () {
              Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const privacy_policy_patient()),
                    ); 
            },
          ),
          SettingsTile(
            icon: Icons.article,
            title: 'Terms of Service',
            iconColor: Colors.teal,
            onTap: () {
              Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const terms_and_service_patient()),
                    ); 
            },
          ),
          SettingsTile(
            icon: Icons.notifications,
            title: 'Notifications',
            iconColor: Colors.orange,
            trailing: Switch(
              value: notificationsEnabled,
              onChanged: (bool value) {
                setState(() {
                  notificationsEnabled = value;
                });
              },
            ), onTap: () {  },
          ),
          SettingsTile(
            icon: Icons.help_outline,
            title: 'Help & Support',
            iconColor: Colors.blueGrey,
            onTap: () {
              Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const help_and_support_patient()),
                    ); 
            },
          ),
          SettingsTile(
            icon: Icons.logout,
            title: 'Sign Out',
            iconColor: Colors.red,
            onTap: () {
              Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MainApp()),
                    ); 
            },
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        margin: const EdgeInsets.symmetric(horizontal: 32.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
             IconButton(
                onPressed: () {
                   Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Patient_Screen()),
                    );         
                },
                icon: Image.asset('images/icon1.png', width: 30, height: 30),
              ),
              IconButton(
                onPressed: () {
                   Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const appointment_main_patient()),
                    );         
                },
                icon: Image.asset('images/icon2.png', width: 30, height: 30),
              ),
              IconButton(
                onPressed: () {
                   Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const notification_patient()),
                    );         
                },
                icon: Image.asset('images/icon3.png', width: 30, height: 30),
              ),
              IconButton(
                onPressed: () {
                   Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const settings_patient()),
                    );         
                },
                icon: Image.asset('images/icon4.png', width: 30, height: 30),
              ),
          ],
        ),
      ),

    );
  }
}

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color iconColor;
  final Widget? trailing;
  final VoidCallback onTap;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.iconColor,
    this.trailing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: iconColor.withOpacity(0.2),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        trailing: trailing ?? const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 18),
        onTap: onTap,
      ),
    );
  }
}