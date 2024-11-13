import 'package:flutter/material.dart';
import 'package:tess/admin_screen/add_new_users/add_new_main.dart';
import 'package:tess/admin_screen/edit_profiles/insurance_represenitive/insurance_represenitive_main.dart';

class insurance_represenitive_add extends StatefulWidget {
  const insurance_represenitive_add({Key? key}) : super(key: key);

  @override
  _My_Info_insuranceState createState() => _My_Info_insuranceState();
}

class _My_Info_insuranceState extends State<insurance_represenitive_add> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "My Info",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InsuranceRepresentativeScreen(),
    );
  }
}

class InsuranceRepresentativeScreen extends StatefulWidget {
  @override
  _InsuranceRepresentativeScreenState createState() =>
      _InsuranceRepresentativeScreenState();
}

class _InsuranceRepresentativeScreenState
    extends State<InsuranceRepresentativeScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController representativeNameController = TextEditingController();
  final TextEditingController representativeIDController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController supervisorNameController = TextEditingController();

  List<TextEditingController> certificationsControllers = [TextEditingController()];
  List<TextEditingController> achievementsControllers = [TextEditingController()];

  List<String> assignedRegions = ["Amman", "Irbid", "Zarqa", "Aqaba"];
  List<String> selectedRegions = [];

  List<String> specializedPolicies = ["Medical", "Dental", "Disability", "Life"];
  List<String> selectedPolicies = [];

  void addCertification() {
    setState(() {
      certificationsControllers.add(TextEditingController());
    });
  }

  void removeCertification(int index) {
    setState(() {
      certificationsControllers.removeAt(index);
    });
  }

  void addAchievement() {
    setState(() {
      achievementsControllers.add(TextEditingController());
    });
  }

  void removeAchievement(int index) {
    setState(() {
      achievementsControllers.removeAt(index);
    });
  }

  Future<void> openMultiSelectDialog(
      String title, List<String> items, List<String> selectedItems) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: items.map((item) {
                return CheckboxListTile(
                  value: selectedItems.contains(item),
                  title: Text(item),
                  onChanged: (bool? checked) {
                    setState(() {
                      if (checked == true) {
                        selectedItems.add(item);
                      } else {
                        selectedItems.remove(item);
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const add_new_main()),
            );
        }, icon: Icon(Icons.arrow_back_ios, color: Colors.white)),
        centerTitle: true,
        title: const Text(
          "Insurance Representative's Portal",
          style: TextStyle(color: Colors.white),
        ),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              InfoContainer(
                title: 'Representative Information',
                children: [
                  buildEditableField(
                      "Name", representativeNameController, Icons.person),
                  const SizedBox(height: 12),
                  buildEditableField("Representative ID", representativeIDController,
                      Icons.badge),
                  const SizedBox(height: 12),
                  buildEditableField(
                      "Contact Number", contactNumberController, Icons.phone, isPhone: true),
                  const SizedBox(height: 12),
                  buildEditableField("Email", emailController, Icons.email, isEmail: true),
                  const SizedBox(height: 12),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.map, color: Colors.blueAccent),
                    title: Text("Assigned Regions"),
                    subtitle: Text(selectedRegions.join(", ")),
                    onTap: () => openMultiSelectDialog(
                      "Select Assigned Regions",
                      assignedRegions,
                      selectedRegions,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.policy, color: Colors.blueAccent),
                    title: Text("Specialized Policies"),
                    subtitle: Text(selectedPolicies.join(", ")),
                    onTap: () => openMultiSelectDialog(
                      "Select Specialized Policies",
                      specializedPolicies,
                      selectedPolicies,
                    ),
                  ),
                  const SizedBox(height: 12),
                  buildEditableField(
                      "Direct Supervisor", supervisorNameController, Icons.supervisor_account),
                ],
              ),
              const SizedBox(height: 20),
              InfoContainer(
                title: 'Certifications',
                children: [
                  ...certificationsControllers.asMap().entries.map((entry) {
                    int index = entry.key;
                    TextEditingController controller = entry.value;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: buildEditableField(
                                  "Certification", controller, Icons.verified)),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => removeCertification(index),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  TextButton.icon(
                    onPressed: addCertification,
                    icon: Icon(Icons.add, color: Colors.blue),
                    label: Text("Add Certification",
                        style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              InfoContainer(
                title: 'Achievements',
                children: [
                  ...achievementsControllers.asMap().entries.map((entry) {
                    int index = entry.key;
                    TextEditingController controller = entry.value;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                              child: buildEditableField(
                                  "Achievement", controller, Icons.emoji_events)),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => removeAchievement(index),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  TextButton.icon(
                    onPressed: addAchievement,
                    icon: Icon(Icons.add, color: Colors.blue),
                    label: Text("Add Achievement",
                        style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Information saved successfully!")),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const add_new_main()),
                      );
                    }
                  },
                  child: const Text("Save Changes"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEditableField(
      String label, TextEditingController controller, IconData icon, {bool isEmail = false, bool isPhone = false}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        prefixIcon: Icon(icon, color: Colors.blueAccent),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return "Field can't be empty";
        if (isEmail && !RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value)) {
          return "Enter a valid email";
        }
        if (isPhone && !RegExp(r"^\+962\d{9}$").hasMatch(value)) {
          return "Phone number must start with +962 and have 9 digits";
        }
        return null;
      },
      keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
    );
  }
}

class InfoContainer extends StatefulWidget {
  final String title;
  final List<Widget> children;

  const InfoContainer({Key? key, required this.title, required this.children})
      : super(key: key);

  @override
  _InfoContainerState createState() => _InfoContainerState();
}

class _InfoContainerState extends State<InfoContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 4,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          const Divider(color: Colors.grey, thickness: 0.5),
          const SizedBox(height: 10),
          ...widget.children,
        ],
      ),
    );
  }
}
