import 'package:flutter/material.dart';
import 'package:tess/pharmacy_screen/mainscreenpharmacy.dart';
import 'package:tess/pharmacy_screen/order_pharmacy/changehistory.dart';
import 'package:tess/pharmacy_screen/order_pharmacy/completed_orders.dart';
import 'package:tess/pharmacy_screen/order_pharmacy/pending_order_introduction.dart';

class PharmacyOrderScreen extends StatefulWidget {
  const PharmacyOrderScreen({super.key});

  @override
  _PharmacyOrderScreenState createState() => _PharmacyOrderScreenState();
}

class _PharmacyOrderScreenState extends State<PharmacyOrderScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  String _searchText = "";
  String _orderTypeFilter = "All";

  // Simulated database for JTN code lookup
  final Map<String, String> jtnCodeDatabase = {
    "JTN123": "Ibuprofen 200mg",
    "JTN456": "Amoxicillin 500mg",
    "JTN789": "Metformin 500mg",
    "JTN012": "Atorvastatin 20mg",
  };

  List<Map<String, dynamic>> activeOrders = [];
  List<Map<String, dynamic>> orderHistory = [];
  List<Map<String, dynamic>> changeHistory = []; // Data for Change History

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this); // 3 tabs now
    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text.toLowerCase();
      });
    });
    _fetchOrders(); // Simulate fetching data
  }

  Future<void> _fetchOrders() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
    setState(() {
      activeOrders = List.generate(10, (index) {
        return {
          "orderId": "DOC${10000 + index}",
          "orderType": "Doctor Order",
          "status": "Pending",
          "doctor": "Dr. John Doe",
          "specialty": "Cardiology",
          "patient": "Patient ${index + 1}",
          "medications": ["JTN123", "JTN456"],
          "date": "10 November 2023",
        };
      });

      orderHistory = List.generate(10, (index) {
        return {
          "orderId": "DOC${20000 + index}",
          "orderType": "Completed Order",
          "status": "Completed",
          "doctor": "Dr. Jane Smith",
          "specialty": "Pediatrics",
          "patient": "John Doe ${index + 1}",
          "medications": ["JTN789", "JTN012"],
          "date": "08 November 2023",
          "completedDate": "09 November 2023",
          "pharmacyDoctorId": "DOC678",
          "pharmacyDoctorName": "Dr. Adam Brown",
          "moneyPaid": "100 JOD",
        };
      });

      // Sample Change History with order type
      changeHistory = List.generate(10, (index) {
        return {
          "orderId": "DOC${30000 + index}",
          "status": "Change Meds",
          "orderType": "Change Meds", // Replaced reason with order type
          "doctor": "Dr. Smith",
          "patient": "Alice Johnson ${index + 1}",
          "medications": ["JTN123", "JTN456"],
          "date": "12 November 2023",
        };
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _showFilterDialog() async {
    final selectedFilter = await showDialog<String>(
      context: context,
      builder: (context) => FilterDialog(initialFilter: _orderTypeFilter),
    );
    if (selectedFilter != null) {
      setState(() {
        _orderTypeFilter = selectedFilter;
      });
    }
  }

  List<Map<String, dynamic>> _filterOrders(List<Map<String, dynamic>> orders) {
    return orders.where((order) {
      final orderId = order["orderId"].toString().toLowerCase();
      final patient = order["patient"].toString().toLowerCase();
      final orderType = order["orderType"].toString().toLowerCase();
      final matchesSearch = orderId.contains(_searchText) || patient.contains(_searchText) || orderType.contains(_searchText);
      final matchesOrderType = _orderTypeFilter == "All" || order["orderType"] == _orderTypeFilter;
      return matchesSearch && matchesOrderType;
    }).toList();
  }

  String getMedicineName(String jtnCode) {
    return jtnCodeDatabase[jtnCode] ?? "Unknown Medicine";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white), // iOS-style back arrow icon
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Pharmacy_Screen()),
            ),
        ),
        title: const Text(
          "Pharmacy Orders",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.white),
            onPressed: _showFilterDialog,
          ),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Active Orders'),
            Tab(text: 'Order History'),
            Tab(text: 'Change History'), // New Tab
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search by Order ID, Patient Name, or Order Type",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildScrollableOrderList(_filterOrders(activeOrders)),
                _buildScrollableOrderList(_filterOrders(orderHistory), isHistory: true),
                _buildChangeHistoryList(_filterOrders(changeHistory)), // Apply filter to Change History too
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScrollableOrderList(List<Map<String, dynamic>> orders, {bool isHistory = false}) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: orders.map((order) {
          return Material(
            color: Colors.white,
            elevation: isHistory ? 2 : 0,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              onTap: () {
                if (order["status"] == "Pending") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PharmacyDispenseIntroduction(),
                    ),
                  );
                } else if (order["status"] == "Completed") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CompletedOrderScreen(order: order, getMedicineName: getMedicineName),
                    ),
                  );
                }
              },
              borderRadius: BorderRadius.circular(12),
              splashColor: Colors.grey.withOpacity(0.2),
              highlightColor: Colors.grey.withOpacity(0.1),
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 16), // Added margin for space between cards
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order ID: ${order["orderId"]}",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Order Type: ${order["orderType"]}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Patient: ${order["patient"]}",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      "Date: ${order["date"]}",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildChangeHistoryList(List<Map<String, dynamic>> orders) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: orders.map((order) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0), // Adds space between each card
            child: Material(
              color: Colors.white,
              elevation: 2,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ChangeHistoryScreen()), // Navigate to Change History Screen
                  );
                },
                borderRadius: BorderRadius.circular(12),
                splashColor: Colors.grey.withOpacity(0.2),
                highlightColor: Colors.grey.withOpacity(0.1),
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order ID: ${order["orderId"]}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Order Type: ${order["orderType"]}",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Patient: ${order["patient"]}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "Date: ${order["date"]}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// Filter Dialog for Order Type
class FilterDialog extends StatefulWidget {
  final String initialFilter;
  const FilterDialog({required this.initialFilter, super.key});

  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  late String _selectedFilter;

  @override
  void initState() {
    super.initState();
    _selectedFilter = widget.initialFilter;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Filter by Order Type"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile<String>(
            title: const Text("All"),
            value: "All",
            groupValue: _selectedFilter,
            onChanged: (value) {
              setState(() {
                _selectedFilter = value!;
              });
            },
          ),
          RadioListTile<String>(
            title: const Text("Doctor Order"),
            value: "Doctor Order",
            groupValue: _selectedFilter,
            onChanged: (value) {
              setState(() {
                _selectedFilter = value!;
              });
            },
          ),
          RadioListTile<String>(
            title: const Text("Refill Order"),
            value: "Refill Order",
            groupValue: _selectedFilter,
            onChanged: (value) {
              setState(() {
                _selectedFilter = value!;
              });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(_selectedFilter),
          child: const Text("Apply"),
        ),
      ],
    );
  }
}

