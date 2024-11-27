import 'package:flutter/material.dart';
import 'package:tess/admin_screen/mainadminscreen.dart';
import 'package:tess/admin_screen/notification_admin.dart';
import 'package:tess/admin_screen/settings/about_us_admin.dart';
import 'package:tess/admin_screen/settings/help_support_admin.dart';
import 'package:tess/admin_screen/settings/privacy_policy_admin.dart';
import 'package:tess/admin_screen/settings/terms_of_service_admin.dart';
import 'package:tess/main.dart';



class settings_admin extends StatelessWidget {
  const settings_admin({super.key});

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
                    MaterialPageRoute(builder: (context) => const about_us_admin()),
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
                    MaterialPageRoute(builder: (context) => const privacy_policy_admin()),
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
                    MaterialPageRoute(builder: (context) => const terms_of_service_admin()),
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
                    MaterialPageRoute(builder: (context) => const help_support_admin()),
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
              MaterialPageRoute(builder: (context) => const AdminScreen()),
            );
              },
              icon: Image.asset('images/icon1.png'), // Replace with desired icon
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => notification_admin()),
            );
              },
              icon: Image.asset('images/icon3.png'), // Replace with desired icon
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const settings_admin()),
            );
              },
              icon: Image.asset('images/icon4.png'), // Replace with desired icon
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