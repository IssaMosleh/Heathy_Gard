import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:tess/admin_screen/Reports/reports.dart';

class ReportData {
  final String insuranceName;
  final double totalMoneySpent;
  final int totalClaims;
  final double averageClaimAmount;
  final int totalDoctors;
  final int totalPatients;
  final List<double> monthlySpending;
  final List<String> patientGenders;

  ReportData({
    required this.insuranceName,
    required this.totalMoneySpent,
    required this.totalClaims,
    required this.averageClaimAmount,
    required this.totalDoctors,
    required this.totalPatients,
    required this.monthlySpending,
    required this.patientGenders,
  })  : assert(totalMoneySpent >= 0),
        assert(totalClaims >= 0),
        assert(totalDoctors > 0),
        assert(totalPatients >= 0),
        assert(monthlySpending.isNotEmpty),
        assert(patientGenders.isNotEmpty);

  int get claimsPerDoctor => (totalClaims / totalDoctors).round();
  int get patientsPerDoctor => (totalPatients / totalDoctors).round();
  double get averageSpending => totalMoneySpent / monthlySpending.length;

  Map<String, double> get genderDistributionPercentage {
    final total = patientGenders.length;
    return {
      "Male": (patientGenders.where((g) => g == "Male").length / total) * 100,
      "Female": (patientGenders.where((g) => g == "Female").length / total) * 100,
    };
  }

  String get doctorRecommendation {
    if (patientsPerDoctor > 100) {
      return "Consider hiring more doctors.";
    } else if (claimsPerDoctor > 20) {
      return "Doctors may be overwhelmed. Evaluate workload.";
    } else {
      return "Current doctor capacity seems adequate.";
    }
  }
}

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  _AdvancedReportsScreenState createState() => _AdvancedReportsScreenState();
}

class _AdvancedReportsScreenState extends State<ReportsScreen> {
  final ReportData reportData = ReportData(
    insuranceName: "XYZ Health Insurance",
    totalMoneySpent: 250000.0,
    totalClaims: 128,
    averageClaimAmount: 1950.5,
    totalDoctors: 50,
    totalPatients: 5000,
    monthlySpending: [20000, 22000, 25000, 24000, 27000, 30000, 32000, 31000, 29000, 34000, 36000, 38000],
    patientGenders: ["Male", "Female", "Male", "Female", "Female", "Male", "Male", "Female", "Female", "Male"],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Report_main(),
              ),
            );
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: const Text(
          'Insurance Analytics Dashboard',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: Colors.white),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.purple], // Matching gradient colors from My_Info screen
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            buildOverviewSection(reportData),
            buildSectionTitle('Analytics'),
            buildGraphCard(context, title: 'Monthly Claims Over Time', chart: buildLineChart(reportData, reportData.monthlySpending, "Monthly Spending")),
            buildGraphCard(context, title: 'Claim Approvals by Type', chart: buildBarChart(reportData)),
            buildGraphCard(context, title: 'Monthly Spending Over Time', chart: buildLineChart(reportData, reportData.monthlySpending, "Spending")),
            buildGraphCard(context, title: 'Gender Distribution', chart: buildGenderPieChart(reportData)),
            buildSectionTitle('Doctor Analysis'),
            buildAnalysisSection(reportData),
          ],
        ),
      ),
    );
  }

  Widget buildOverviewSection(ReportData data) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blueAccent.withOpacity(0.2), Colors.blueAccent.withOpacity(0.1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Reports Overview',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueAccent),
          ),
          const SizedBox(height: 20),
          buildOverviewRow(Icons.business, "Insurance Name", data.insuranceName, Colors.blue),
          buildOverviewRow(Icons.attach_money, "Total Money Spent", "\$${data.totalMoneySpent.toStringAsFixed(2)}", Colors.green),
          buildOverviewRow(Icons.assignment, "Total Claims", data.totalClaims.toString(), Colors.orange),
          buildOverviewRow(Icons.calculate, "Average Claim Amount", "\$${data.averageClaimAmount.toStringAsFixed(2)}", Colors.purple),
          buildOverviewRow(Icons.attach_money, "Average Monthly Spending", "\$${data.averageSpending.toStringAsFixed(2)}", Colors.teal),
        ],
      ),
    );
  }

  Widget buildOverviewRow(IconData icon, String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: color),
          ),
        ],
      ),
    );
  }

  Widget buildGenderPieChart(ReportData data) {
    return PieChart(
      PieChartData(
        sections: data.genderDistributionPercentage.entries.map((entry) {
          return PieChartSectionData(
            value: entry.value,
            title: "${entry.key} ${entry.value.toStringAsFixed(1)}%",
            color: entry.key == "Male" ? Colors.blueAccent : Colors.pinkAccent,
            radius: 50,
            titleStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          );
        }).toList(),
        centerSpaceRadius: 30,
      ),
    );
  }

  Widget buildLineChart(ReportData data, List<double> values, String title) {
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: values.asMap().entries.map((entry) => FlSpot(entry.key + 1.0, entry.value / 1000)).toList(),
            isCurved: true,
            gradient: const LinearGradient(colors: [Colors.lightBlue, Colors.blueAccent]),
            barWidth: 4,
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [Colors.lightBlue.withOpacity(0.3), Colors.blueAccent.withOpacity(0.3)],
              ),
            ),
            dotData: const FlDotData(show: false),
          ),
        ],
        borderData: FlBorderData(show: false),
        gridData: const FlGridData(show: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 50,
              getTitlesWidget: (value, _) => Text(
                "\$${(value * 1000).toInt()}",
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 32,
              getTitlesWidget: (value, _) {
                const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
                return Text(months[value.toInt() - 1]);
              },
            ),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
      ),
    );
  }

  Widget buildBarChart(ReportData data) {
    return BarChart(
      BarChartData(
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 50,
              getTitlesWidget: (value, _) => Text(
                '\$${(value * 1000).toInt()}',
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, _) => Text(["In-Network", "Out-of-Network"][value.toInt()]),
            ),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        barGroups: [
          BarChartGroupData(x: 0, barRods: [
            BarChartRodData(toY: data.monthlySpending[0] / 1000, gradient: const LinearGradient(colors: [Colors.greenAccent, Colors.teal]), width: 18, borderRadius: BorderRadius.circular(6)),
          ]),
          BarChartGroupData(x: 1, barRods: [
            BarChartRodData(toY: data.monthlySpending[1] / 1000, gradient: const LinearGradient(colors: [Colors.redAccent, Colors.deepOrangeAccent]), width: 18, borderRadius: BorderRadius.circular(6)),
          ]),
        ],
        borderData: FlBorderData(show: false),
        gridData: const FlGridData(show: false),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildGraphCard(BuildContext context, {required String title, required Widget chart}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            SizedBox(height: 200, child: chart),
          ],
        ),
      ),
    );
  }

  Widget buildAnalysisSection(ReportData data) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Doctor Analysis", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            buildAnalysisRow("Total Doctors", data.totalDoctors.toString(), Colors.teal),
            buildAnalysisRow("Total Patients", data.totalPatients.toString(), Colors.teal),
            buildAnalysisRow("Claims per Doctor", data.claimsPerDoctor.toString(), Colors.teal),
            buildAnalysisRow("Patients per Doctor", data.patientsPerDoctor.toString(), Colors.teal),
            const SizedBox(height: 10),
            const Text("Recommendation:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.redAccent)),
            const SizedBox(height: 5),
            Text(data.doctorRecommendation, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget buildAnalysisRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(Icons.stacked_bar_chart, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: color),
          ),
        ],
      ),
    );
  }
}
