import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tess/admin_screen/add_new_users/add_new_main.dart';
import 'dart:io';

import 'package:tess/admin_screen/edit_profiles/insurance/edit_insurance.dart';

class insurance_add extends StatelessWidget {
  const insurance_add({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Insurance Company Portal",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InsuranceDetailScreen(),
    );
  }
}

class InsuranceDetailScreen extends StatefulWidget {
  @override
  _InsuranceDetailScreenState createState() => _InsuranceDetailScreenState();
}

class _InsuranceDetailScreenState extends State<InsuranceDetailScreen> {
  String insuranceName = "";
  String location = "";
  String imageUrl = "https://your-image-url.com/image.jpg";
  File? _imageFile;

  List<String> affiliatedHospitals = [];
  final List<String> predefinedHospitals = ["Jordan Hospital", "Amman Medical Center", "City Health Clinic", "National Health Institute"];
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

  void addAffiliatedHospital(String hospital) {
    if (!affiliatedHospitals.contains(hospital)) {
      setState(() {
        affiliatedHospitals.add(hospital);
      });
    }
  }

  void deleteAffiliatedHospital(String hospital) {
    setState(() {
      affiliatedHospitals.remove(hospital);
    });
  }

  void openAddHospitalDialog() async {
    final newHospital = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AddHospitalDialog(predefinedHospitals: predefinedHospitals);
      },
    );

    if (newHospital != null && newHospital.isNotEmpty) {
      addAffiliatedHospital(newHospital);
    }
  }

  void saveChanges() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        insuranceName = nameController.text;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Changes saved successfully")),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => add_new_main(),
          ),
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
        title: const Text("Insurance Company Details", style: TextStyle(color: Colors.white)),
        leading: IconButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => add_new_main(),
            ),
          ),
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
                      // Insurance Image and Information with edit button
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
                              icon: Icon(Icons.edit, color: Colors.white),
                              onPressed: _pickImage,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      
                      // Insurance Name with validation
                      buildLabel("Insurance Company Name"),
                      TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          hintText: "Enter insurance company name",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an insurance company name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      
                      // Location (City) selection
                      buildLabel("Location"),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        value: location.isEmpty ? null : location,
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a location';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 8),
                      
                      // Affiliated Hospitals
                      buildLabel("Affiliated Hospitals"),
                      // List of Affiliated Hospitals with delete button for each
                      ...affiliatedHospitals.map((hospital) {
                        return ListTile(
                          title: gradientText(hospital),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => deleteAffiliatedHospital(hospital),
                          ),
                        );
                      }).toList(),
                      const SizedBox(height: 16),
                      
                      // Add Hospital Button
                      Center(
                        child: ElevatedButton(
                          onPressed: openAddHospitalDialog,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text("Add Affiliated Hospital"),
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
                          child: const Text("Save Changes"),
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
      shaderCallback: (bounds) => LinearGradient(
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

class AddHospitalDialog extends StatelessWidget {
  final List<String> predefinedHospitals;
  
  AddHospitalDialog({required this.predefinedHospitals});

  @override
  Widget build(BuildContext context) {
    String? selectedHospital;

    return AlertDialog(
      title: const Text("Select Affiliated Hospital"),
      content: DropdownButtonFormField<String>(
        items: predefinedHospitals.map((hospital) {
          return DropdownMenuItem(value: hospital, child: Text(hospital));
        }).toList(),
        onChanged: (value) {
          selectedHospital = value;
        },
        decoration: InputDecoration(
          labelText: "Choose Hospital",
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select a hospital';
          }
          return null;
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            if (selectedHospital != null) {
              Navigator.of(context).pop(selectedHospital);
            }
          },
          child: const Text("Add"),
        ),
      ],
    );
  }
}
