import 'package:flutter/material.dart';
import 'package:tess/patient_screen/main.dart';
import 'package:tess/patient_screen/patient_appointmnet/patient_appointment_selecthospital_search.dart';
import 'package:tess/patient_screen/patient_appointmnet/patient_appointment_typeofvist.dart';

class patient_appointment_selecthospital extends StatelessWidget {
  const patient_appointment_selecthospital({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HospitalListScreen(),
    );
  }
}

class HospitalListScreen extends StatelessWidget {
  final List<Map<String, String>> hospitals = [
    {
      "name": "Jordan Hospital",
      "location": "Shmeisani",
      "image": "images/hospital_image.png"
    },
    {
      "name": "Specialty Hospital",
      "location": "Amman",
      "image": "images/hospital_image.png"
    },
    {
      "name": "Al Khalidi Hospital",
      "location": "Jabal Amman",
      "image": "images/hospital_image.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              "Step 2 of 4: Choose Hospital",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => patient_appointment_typeofvist()),
              );
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          ),
          actions: [
            IconButton(
              onPressed: () {
                showFilterBottomSheet(context);
              },
              icon: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Image.asset('images/settings.png'),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    "Hospital List",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => patient_appointment_selecthospital_search()),
                      );
                    },
                    icon: Image.asset("images/search.png"),
                  ),
                  IconButton(
                    onPressed: () {
                      showFilterBottomSheet(context);
                    },
                    icon: Image.asset("images/settings.png"),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                "Find the hospital or Clinic you want",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: hospitals.length,
                itemBuilder: (context, index) {
                  final hospital = hospitals[index];
                  return GestureDetector(
                    onTap: () {
                      print("${hospital['name']} clicked");
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 3,
                      margin: const EdgeInsets.only(bottom: 16),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                hospital["image"]!,
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              hospital["name"]!,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              hospital["location"]!,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showFilterBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Filter (Hospital)",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _buildFilterButton("Zarqa"),
                _buildFilterButton("Amman"),
                _buildFilterButton("Irbid"),
                _buildFilterButton("Ajloun"),
                _buildFilterButton("Karak"),
                _buildFilterButton("Aqaba"),
                _buildFilterButton("Madaba"),
                _buildFilterButton("Jerash"),
                _buildFilterButton("Salt"),
                _buildFilterButton("Mafraq"),
                _buildFilterButton("Ma'an"),
                _buildFilterButton("Tafilah"),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("10km"),
                Text("20km"),
                Text("30km"),
              ],
            ),
            Slider(
              value: 20,
              min: 10,
              max: 30,
              divisions: 2,
              label: "20km",
              onChanged: (double value) {},
            ),
          ],
        ),
      );
    },
  );
}

Widget _buildFilterButton(String text) {
  return OutlinedButton(
    onPressed: () {},
    child: Text(text),
    style: OutlinedButton.styleFrom(
      backgroundColor: Colors.blue.shade50,
      foregroundColor: Colors.blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
  );
}
