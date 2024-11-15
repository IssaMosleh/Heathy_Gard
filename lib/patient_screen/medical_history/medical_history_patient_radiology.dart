import 'package:flutter/material.dart';
import 'package:tess/patient_screen/medical_history/medical_history_patient_main.dart';
import 'package:url_launcher/url_launcher.dart';

class medical_history_patient_radiology extends StatelessWidget {
  const medical_history_patient_radiology({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const RadiologyReportsScreen(),
    );
  }
}

class RadiologyReportsScreen extends StatefulWidget {
  const RadiologyReportsScreen({Key? key}) : super(key: key);

  @override
  _RadiologyReportsScreenState createState() => _RadiologyReportsScreenState();
}

class _RadiologyReportsScreenState extends State<RadiologyReportsScreen> {
  List<Map<String, dynamic>> radiologyReports = [];
  bool _isDownloading = false;

  @override
  void initState() {
    super.initState();
    fetchRadiologyReports();
  }

  void fetchRadiologyReports() async {
    await Future.delayed(Duration(seconds: 1));
    
    setState(() {
      radiologyReports = [
        {
          "type": "Chest X-Ray",
          "date": "15 September 2023",
          "findings": "No abnormalities detected",
          "comments": "Clear lungs",
          "pdfUrl": "https://example.com/radiology_report_1.pdf",
        },
        {
          "type": "CT Scan",
          "date": "10 July 2023",
          "findings": "Minor inflammation detected",
          "comments": "Follow-up required",
          "pdfUrl": "https://example.com/radiology_report_2.pdf",
        },
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Radiology Reports",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 5,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        leading: IconButton(onPressed: (){
          Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => medical_history_patient_main()),
                    );         
        }, icon: Icon(Icons.arrow_back_ios), color: Colors.white,),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...radiologyReports.map((report) => _buildRadiologyReportCard(report)).toList(),
                ],
              ),
            ),
          ),
          if (_isDownloading)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text(
                    "Downloading PDF...",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRadiologyReportCard(Map<String, dynamic> report) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                report["type"],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              Text("Date: ${report["date"]}", style: _textStyle()),
              Text("Findings: ${report["findings"]}", style: _textStyle()),
              Text("Comments: ${report["comments"]}", style: _textStyle()),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () => _downloadPdf(report["pdfUrl"]),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.blue, Colors.purple],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.download, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        "Download PDF",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle _textStyle() {
    return const TextStyle(
      fontSize: 16,
      color: Colors.black54,
    );
  }

  void _downloadPdf(String pdfUrl) async {
    final Uri url = Uri.parse(pdfUrl);

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Could not open PDF."),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}