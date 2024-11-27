import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:tess/admin_screen/edit_profiles/hospital/edit_hospital.dart';

class HospitalShowDetails extends StatelessWidget {
  const HospitalShowDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Doctor's Portal",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FacilityDetailScreen(),
    );
  }
}

class FacilityDetailScreen extends StatefulWidget {
  const FacilityDetailScreen({super.key});

  @override
  _FacilityDetailScreenState createState() => _FacilityDetailScreenState();
}

class _FacilityDetailScreenState extends State<FacilityDetailScreen> {
  String hospitalName = "Jordan Hospital";
  String location = "Amman";
  String imageUrl = "https://your-image-url.com/image.jpg"; // Default image URL
  File? _imageFile; // To hold the selected image
  
  List<String> insuranceCompanies = ["Allianz", "MetLife", "Cigna", "AXA"];
  final List<String> predefinedInsuranceCompanies = ["Allianz", "MetLife", "Cigna", "AXA", "Blue Cross", "United Health"];
  final List<String> jordanCities = [
    "Amman", "Irbid", "Zarqa", "Jerash", "Ajloun", 
    "Madaba", "Salt", "Mafraq", "Aqaba", "Karak", 
    "Ma'an", "Tafilah"
  ];

  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController.text = hospitalName;
  }

  // Image picker function
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void addInsuranceCompany(String company) {
    if (!insuranceCompanies.contains(company)) {
      setState(() {
        insuranceCompanies.add(company);
      });
    }
  }

  void deleteInsuranceCompany(String company) {
    setState(() {
      insuranceCompanies.remove(company);
    });
  }

  void openAddInsuranceDialog() async {
    final newCompany = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AddInsuranceDialog(predefinedCompanies: predefinedInsuranceCompanies);
      },
    );

    if (newCompany != null && newCompany.isNotEmpty) {
      addInsuranceCompany(newCompany);
    }
  }

  void saveChanges() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        hospitalName = nameController.text;
        Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EditHospital()),
            );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width * 0.8;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("My Hospitals", style: TextStyle(color: Colors.white)),
        leading: IconButton(
          onPressed: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EditHospital()),
            );
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
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
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  width: containerWidth,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 4,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Hospital Image and Information with edit button
                      Stack(
                        children: [
                          Container(
                            width: containerWidth,
                            height: containerWidth * 0.6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.grey.shade200,
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: _imageFile != null
                                ? Image.file(_imageFile!, fit: BoxFit.cover)
                                : Image.network(
                                    imageUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Center(
                                          child: Text("[Image not available]",
                                              style: TextStyle(color: Colors.red)));
                                    },
                                  ),
                          ),
                          Positioned(
                            right: 8,
                            top: 8,
                            child: IconButton(
                              icon: const Icon(Icons.edit, color: Colors.white),
                              onPressed: _pickImage,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      
                      // Hospital Name with validation
                      buildLabel("Hospital Name"),
                      TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          hintText: "Enter hospital name",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a hospital name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      
                      // Location (City) selection
                      buildLabel("Location"),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: location,
                        decoration: const InputDecoration(
                          labelText: "Select City",
                          border: OutlineInputBorder(),
                        ),
                        items: jordanCities.map((city) {
                          return DropdownMenuItem(
                            value: city,
                            child: Text(city),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            location = value!;
                          });
                        },
                      ),
                      const SizedBox(height: 8),
                      
                      // Insurance Companies
                      buildLabel("Insurance Companies"),
                      // List of Insurance Companies with delete button for each
                      ...insuranceCompanies.map((company) {
                        return ListTile(
                          title: gradientText(company),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => deleteInsuranceCompany(company),
                          ),
                        );
                      }),
                      const SizedBox(height: 16),
                      
                      // Add Insurance Company Button
                      Center(
                        child: ElevatedButton(
                          onPressed: openAddInsuranceDialog,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text("Add Insurance Company",style: TextStyle(color: Colors.white),),
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Save Changes Button
                      Center(
                        child: ElevatedButton(
                          onPressed: saveChanges,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text("Save Changes",style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget gradientText(String text) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Colors.blue, Colors.purple],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

class AddInsuranceDialog extends StatelessWidget {
  final List<String> predefinedCompanies;
  
  const AddInsuranceDialog({super.key, required this.predefinedCompanies});

  @override
  Widget build(BuildContext context) {
    String? selectedCompany;

    return AlertDialog(
      title: const Text("Select Insurance Company"),
      content: DropdownButtonFormField<String>(
        items: predefinedCompanies.map((company) {
          return DropdownMenuItem(value: company, child: Text(company));
        }).toList(),
        onChanged: (value) {
          selectedCompany = value;
        },
        decoration: const InputDecoration(
          labelText: "Choose Company",
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            if (selectedCompany != null) {
              Navigator.of(context).pop(selectedCompany);
            }
          },
          child: const Text("Add"),
        ),
      ],
    );
  }
}
