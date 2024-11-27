import 'package:flutter/material.dart';
import 'package:tess/admin_screen/edit_profiles/insurance_represenitive/insurance_represenitive_main.dart';

class show_details_insurance_represenitive extends StatefulWidget {
  const show_details_insurance_represenitive({super.key});

  @override
  _My_Info_insuranceState createState() => _My_Info_insuranceState();
}

class _My_Info_insuranceState extends State<show_details_insurance_represenitive> {
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
  const InsuranceRepresentativeScreen({super.key});

  @override
  _InsuranceRepresentativeScreenState createState() =>
      _InsuranceRepresentativeScreenState();
}

class _InsuranceRepresentativeScreenState
    extends State<InsuranceRepresentativeScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController representativeNameController =
      TextEditingController(text: "John Doe");
  final TextEditingController representativeIDController =
      TextEditingController(text: "IR123456");
  final TextEditingController contactNumberController =
      TextEditingController(text: "+962795716049");
  final TextEditingController emailController =
      TextEditingController(text: "john.doe@insurance.com");
  final TextEditingController supervisorNameController =
      TextEditingController(text: "Sarah Johnson");

  List<TextEditingController> certificationsControllers = [
    TextEditingController(text: "Certified Insurance Specialist")
  ];
  List<TextEditingController> achievementsControllers = [
    TextEditingController(text: "Top Performer 2022, Customer Satisfaction 2023")
  ];

  List<String> assignedRegions = ["Amman", "Irbid", "Zarqa", "Aqaba"];
  List<String> selectedRegions = ["Amman", "Irbid", "Zarqa"];

  List<String> specializedPolicies = ["Medical", "Dental", "Disability", "Life"];
  List<String> selectedPolicies = ["Medical", "Dental", "Disability"];

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
              child: const Text("Close"),
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
        leading: IconButton(onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const InsuranceRepSearchScreen()),
            );
        }, icon: const Icon(Icons.arrow_back_ios,color: Colors.white,)),
        centerTitle: true,
        title: const Text(
          "Insurance Representative",
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
                      "Contact Number", contactNumberController, Icons.phone),
                  const SizedBox(height: 12),
                  buildEditableField("Email", emailController, Icons.email),
                  const SizedBox(height: 12),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.map, color: Colors.blueAccent),
                    title: const Text("Assigned Regions"),
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
                    leading: const Icon(Icons.policy, color: Colors.blueAccent),
                    title: const Text("Specialized Policies"),
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
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => removeCertification(index),
                          ),
                        ],
                      ),
                    );
                  }),
                  TextButton.icon(
                    onPressed: addCertification,
                    icon: const Icon(Icons.add, color: Colors.blue),
                    label: const Text("Add Certification",
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
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => removeAchievement(index),
                          ),
                        ],
                      ),
                    );
                  }),
                  TextButton.icon(
                    onPressed: addAchievement,
                    icon: const Icon(Icons.add, color: Colors.blue),
                    label: const Text("Add Achievement",
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
                        const SnackBar(content: Text("Information saved successfully!")),
                      );
                      Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const InsuranceRepSearchScreen()),
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
      String label, TextEditingController controller, IconData icon) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(icon, color: Colors.blueAccent),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return "Field can't be empty";
        return null;
      },
    );
  }
}

class InfoContainer extends StatefulWidget {
  final String title;
  final List<Widget> children;

  const InfoContainer({super.key, required this.title, required this.children});

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
