import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:tess/lab_radiology_screen/my_hospital/my_hospital.dart';


class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Doctor's Portal",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FacilityDetailScreen_LAB(),
    );
  }
}

class FacilityDetailScreen_LAB extends StatefulWidget {
  const FacilityDetailScreen_LAB({super.key});

  @override
  _FacilityDetailScreenState createState() => _FacilityDetailScreenState();
}

class _FacilityDetailScreenState extends State<FacilityDetailScreen_LAB> {
  String doctorName = "Dr. Issa Mosleh";
  String hospitalName = "Jordan Hospital";
  String specialization = "General Care";
  String imageUrl = "https://your-image-url.com/image.jpg";
  Map<String, String> workingHours = {
    "Sunday": "08:00 AM - 01:00 PM",
    "Monday": "08:00 AM - 01:00 PM",
    "Tuesday": "08:00 AM - 01:00 PM",
    "Wednesday": "08:00 AM - 01:00 PM",
    "Thursday": "08:00 AM - 12:00 PM",
    "Friday": "Closed",
  };
  int visitsThisYear = 150;
  double moneyMade = 20000.0;
  List<String> insuranceCompanies = ["Allianz", "MetLife", "Cigna", "AXA"];

  late Map<String, String> editableWorkingHours;

  @override
  void initState() {
    super.initState();
    editableWorkingHours = Map.from(workingHours);
  }

  void openEditDialog() async {
    final updatedWorkingHours = await showDialog<Map<String, String>>(
      context: context,
      builder: (BuildContext context) {
        return EditWorkingHoursDialog(workingHours: editableWorkingHours);
      },
    );

    if (updatedWorkingHours != null) {
      setState(() {
        editableWorkingHours = updatedWorkingHours;
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
              MaterialPageRoute(builder: (context) => const MyHospital_LAB()),
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
          child: Center(
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
                      Container(
                        width: containerWidth,
                        height: containerWidth * 0.6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.grey.shade200,
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                                child: Text("[Image not available]",
                                    style: TextStyle(color: Colors.red)));
                          },
                        ),
                      ),
                      const SizedBox(height: 12),
                      buildLabel("Doctor Name"),
                      gradientText(doctorName, isEditable: false), // Set to grey
                      const SizedBox(height: 8),
                      buildLabel("Hospital"),
                      gradientText(hospitalName, isEditable: false), // Set to grey
                      const SizedBox(height: 8),
                      buildLabel("Specialization"),
                      gradientText(specialization, isEditable: false), // Set to grey
                      const SizedBox(height: 8),
                      buildLabel("Time"),
                      const SizedBox(height: 8),
                      ...editableWorkingHours.entries.map((entry) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: gradientText("${entry.key}: ${entry.value}", isEditable: true),
                        );
                      }),
                      const SizedBox(height: 8),
                      buildLabel("Visits This Year"),
                      gradientText(visitsThisYear.toString(), isEditable: false), // Set to grey
                      const SizedBox(height: 8),
                      buildLabel("Insurance Claim Money"),
                      gradientText("\$${moneyMade.toStringAsFixed(2)}", isEditable: false), // Set to grey
                      const SizedBox(height: 8),
                      buildLabel("Insurance Companies"),
                      ...insuranceCompanies.map((company) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: gradientText(company, isEditable: false), // Set to grey
                        );
                      }),
                      const SizedBox(height: 16),
                      Center(
                        child: ElevatedButton(
                          onPressed: openEditDialog,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text("Edit"),
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

  Widget gradientText(String text, {bool isEditable = true}) {
    return isEditable
        ? ShaderMask(
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
          )
        : Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          );
  }
}

class EditWorkingHoursDialog extends StatefulWidget {
  final Map<String, String> workingHours;

  const EditWorkingHoursDialog({super.key, required this.workingHours});

  @override
  _EditWorkingHoursDialogState createState() => _EditWorkingHoursDialogState();
}

class _EditWorkingHoursDialogState extends State<EditWorkingHoursDialog> {
  late Map<String, MaskedTextController> startControllers;
  late Map<String, MaskedTextController> endControllers;
  late Map<String, bool> closedDays;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    startControllers = {};
    endControllers = {};
    closedDays = {};

    for (var entry in widget.workingHours.entries) {
      var times = entry.value.split(" - ");

      bool isClosed = entry.value == "Closed";
      closedDays[entry.key] = isClosed;

      startControllers[entry.key] = MaskedTextController(
        mask: '00:00',
        text: isClosed || times.isEmpty || times[0] == '' ? "" : times[0],
      );
      endControllers[entry.key] = MaskedTextController(
        mask: '00:00',
        text: isClosed || times.length < 2 || times[1] == '' ? "" : times[1],
      );
    }
  }

  @override
  void dispose() {
    for (var controller in startControllers.values) {
      controller.dispose();
    }
    for (var controller in endControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  String? _validateTimeFormat(String? value) {
    final timeFormat = RegExp(r"^(0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$");
    if (value == null || value.isEmpty) {
      return 'Time cannot be empty';
    } else if (!timeFormat.hasMatch(value)) {
      return 'Enter a valid time (e.g., 08:00)';
    }
    return null;
  }

  String? _validateTimeLogic(String startTime, String endTime) {
    if (startTime.isEmpty || endTime.isEmpty) {
      return null;
    }

    try {
      final start = DateTime.parse("1970-01-01 $startTime:00");
      final end = DateTime.parse("1970-01-01 $endTime:00");

      if (end.isBefore(start)) {
        return 'End time must be after start time';
      }
    } catch (e) {
      return 'Invalid time format';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.95,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Edit Working Hours",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Column(
                    children: startControllers.entries.map((entry) {
                      final day = entry.key;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "$day Hours",
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Checkbox(
                                  value: closedDays[day],
                                  onChanged: (value) {
                                    setState(() {
                                      closedDays[day] = value ?? false;
                                      if (closedDays[day] == true) {
                                        startControllers[day]!.clear();
                                        endControllers[day]!.clear();
                                      }
                                    });
                                  },
                                ),
                                const Text("Closed"),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: TextFormField(
                                      controller: startControllers[day],
                                      enabled: !closedDays[day]!,
                                      decoration: const InputDecoration(
                                        labelText: "Start (hh:mm)",
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 10.0),
                                        errorStyle: TextStyle(
                                            fontSize: 12, color: Colors.red),
                                      ),
                                      validator: (value) {
                                        if (closedDays[day]!) return null;
                                        String? basicValidation = _validateTimeFormat(value);
                                        String? logicalValidation = _validateTimeLogic(value ?? "", endControllers[day]!.text);
                                        return basicValidation ?? logicalValidation;
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: TextFormField(
                                      controller: endControllers[day],
                                      enabled: !closedDays[day]!,
                                      decoration: const InputDecoration(
                                        labelText: "End (hh:mm)",
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 10.0, horizontal: 10.0),
                                        errorStyle: TextStyle(
                                            fontSize: 12, color: Colors.red),
                                      ),
                                      validator: (value) {
                                        if (closedDays[day]!) return null;
                                        String? basicValidation = _validateTimeFormat(value);
                                        String? logicalValidation = _validateTimeLogic(startControllers[day]!.text, value ?? "");
                                        return basicValidation ?? logicalValidation;
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Cancel"),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final updatedWorkingHours = {
                              for (var day in startControllers.keys)
                                day: closedDays[day]!
                                    ? "Closed"
                                    : "${startControllers[day]!.text} - ${endControllers[day]!.text}"
                            };
                            Navigator.of(context).pop(updatedWorkingHours);
                          }
                        },
                        child: const Text("Save"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
