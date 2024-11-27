import 'package:flutter/material.dart';
import 'package:tess/admin_screen/add_new_users/add_new_main.dart';
import 'package:tess/admin_screen/edit_profiles/doctor/doctor_insurance_main.dart';

class doctor_add_new extends StatelessWidget {
  const doctor_add_new({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "My Info",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DoctorScreen(),
    );
  }
}

class DoctorScreen extends StatefulWidget {
  const DoctorScreen({super.key});

  @override
  _DoctorScreenState createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController doctorNameController = TextEditingController();
  final TextEditingController doctorIDController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController languagesController = TextEditingController();
  final TextEditingController medicalSchoolController = TextEditingController();
  final TextEditingController residencyController = TextEditingController();

  List<TextEditingController> certificationsControllers = [TextEditingController()];
  List<TextEditingController> achievementsControllers = [TextEditingController()];

  final List<String> specializations = ["Cardiology", "Dermatology", "Pediatrics", "Radiology"];
  final List<String> hospitals = ["Massachusetts General Hospital", "Mayo Clinic", "Johns Hopkins"];
  final List<String> insuranceCompanies = ["Allianz", "Cigna", "MetLife", "Blue Cross"];

  String selectedSpecialization = "";
  List<String> affiliatedHospitals = [""];
  List<String> affiliatedInsurances = [""];

  void addCertification() {
    setState(() {
      certificationsControllers.add(TextEditingController());
    });
  }

  void addAchievement() {
    setState(() {
      achievementsControllers.add(TextEditingController());
    });
  }

  void removeCertification(int index) {
    setState(() {
      certificationsControllers.removeAt(index);
    });
  }

  void removeAchievement(int index) {
    setState(() {
      achievementsControllers.removeAt(index);
    });
  }

  void addAffiliatedHospital() {
    setState(() {
      affiliatedHospitals.add(hospitals.first);
    });
  }

  void addAffiliatedInsurance() {
    setState(() {
      affiliatedInsurances.add(insuranceCompanies.first);
    });
  }

  void removeAffiliatedHospital(int index) {
    setState(() {
      affiliatedHospitals.removeAt(index);
    });
  }

  void removeAffiliatedInsurance(int index) {
    setState(() {
      affiliatedInsurances.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const add_new_main()),
            );
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        centerTitle: true,
        title: const Text(
          "Doctor's Portal",
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
                title: 'Doctor Information',
                children: [
                  buildEditableField("Name", doctorNameController),
                  buildEditableField("Doctor ID", doctorIDController),
                  buildEditableField("Gender", genderController),
                  buildEditableField("Date of Birth", dobController),
                  buildDropdownField("Specialization", selectedSpecialization, specializations, (value) {
                    setState(() {
                      selectedSpecialization = value!;
                    });
                  }),
                  buildEditableField("Experience", experienceController),
                  buildEditableField("Contact Number", contactController),
                  buildEditableField("Email", emailController),
                  buildEditableField("Languages Spoken", languagesController),
                ],
              ),
              const SizedBox(height: 20),

              InfoContainer(
                title: 'Education',
                children: [
                  buildEditableField("Medical School", medicalSchoolController),
                  buildEditableField("Residency", residencyController),
                ],
              ),
              const SizedBox(height: 20),

              // Certifications
              InfoContainer(
                title: 'Certifications',
                children: [
                  ...certificationsControllers.asMap().entries.map((entry) {
                    int index = entry.key;
                    TextEditingController controller = entry.value;
                    return Row(
                      children: [
                        Expanded(child: buildEditableField("Certification", controller)),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => removeCertification(index),
                        ),
                      ],
                    );
                  }),
                  TextButton.icon(
                    onPressed: addCertification,
                    icon: const Icon(Icons.add, color: Colors.blue),
                    label: const Text("Add Certification", style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Achievements
              InfoContainer(
                title: 'Special Achievements',
                children: [
                  ...achievementsControllers.asMap().entries.map((entry) {
                    int index = entry.key;
                    TextEditingController controller = entry.value;
                    return Row(
                      children: [
                        Expanded(child: buildEditableField("Achievement", controller)),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => removeAchievement(index),
                        ),
                      ],
                    );
                  }),
                  TextButton.icon(
                    onPressed: addAchievement,
                    icon: const Icon(Icons.add, color: Colors.blue),
                    label: const Text("Add Achievement", style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Affiliated Hospitals
              InfoContainer(
                title: 'Affiliated Hospitals',
                children: [
                  ...affiliatedHospitals.asMap().entries.map((entry) {
                    int index = entry.key;
                    String value = entry.value;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: value.isEmpty ? null : value,
                              items: hospitals
                                  .map((hospital) => DropdownMenuItem(
                                        value: hospital,
                                        child: Text(
                                          hospital,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  affiliatedHospitals[index] = newValue!;
                                });
                              },
                              decoration: const InputDecoration(
                                labelText: "Affiliated Hospital",
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => removeAffiliatedHospital(index),
                          ),
                        ],
                      ),
                    );
                  }),
                  TextButton.icon(
                    onPressed: addAffiliatedHospital,
                    icon: const Icon(Icons.add, color: Colors.blue),
                    label: const Text("Add Affiliated Hospital", style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Affiliated Insurance Companies
              InfoContainer(
                title: 'Affiliated Insurance Companies',
                children: [
                  ...affiliatedInsurances.asMap().entries.map((entry) {
                    int index = entry.key;
                    String value = entry.value;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: value.isEmpty ? null : value,
                              items: insuranceCompanies
                                  .map((company) => DropdownMenuItem(
                                        value: company,
                                        child: Text(
                                          company,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  affiliatedInsurances[index] = newValue!;
                                });
                              },
                              decoration: const InputDecoration(
                                labelText: "Affiliated Insurance",
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => removeAffiliatedInsurance(index),
                          ),
                        ],
                      ),
                    );
                  }),
                  TextButton.icon(
                    onPressed: addAffiliatedInsurance,
                    icon: const Icon(Icons.add, color: Colors.blue),
                    label: const Text("Add Affiliated Insurance", style: TextStyle(color: Colors.blue)),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Save Changes Button
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

  Widget buildEditableField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return "Field can't be empty";
          return null;
        },
      ),
    );
  }

  Widget buildDropdownField(String label, String value, List<String> items, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: value.isEmpty ? null : value,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        items: items.map((item) => DropdownMenuItem(
          value: item,
          child: Text(
            item,
            overflow: TextOverflow.ellipsis,
          ),
        )).toList(),
      ),
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
