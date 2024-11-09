import 'package:flutter/material.dart';
import 'dart:math';

import 'package:tess/pharmacy_screen/main.dart';

class pharmacy_money extends StatefulWidget {
  const pharmacy_money({Key? key}) : super(key: key);

  @override
  _PharmacyMoneyScreenState createState() => _PharmacyMoneyScreenState();
}

class _PharmacyMoneyScreenState extends State<pharmacy_money> {
  double cashSales = 5000.0;
  double insuranceSales = 15000.0;
  double pendingInsuranceAmount = 3000.0;
  bool isRequestingPayment = false;

  final List<Map<String, dynamic>> transactions = [
    {
      "orderId": _generateOrderId(),
      "date": "05 November 2023",
      "customer": "John Doe",
      "payments": [
        {"source": "Cash", "amount": 200.0},
        {"source": "Insurance", "amount": 800.0},
      ],
    },
    {
      "orderId": _generateOrderId(),
      "date": "03 November 2023",
      "customer": "Jane Smith",
      "payments": [
        {"source": "Insurance", "amount": 1200.0},
      ],
    },
    {
      "orderId": _generateOrderId(),
      "date": "01 November 2023",
      "customer": "Alice Johnson",
      "payments": [
        {"source": "Insurance", "amount": 1500.0},
      ],
    },
    {
      "orderId": _generateOrderId(),
      "date": "29 October 2023",
      "customer": "Michael Brown",
      "payments": [
        {"source": "Cash", "amount": 300.0},
      ],
    },
  ];

  static String _generateOrderId() {
    final random = Random();
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return List.generate(8, (index) => chars[random.nextInt(chars.length)]).join();
  }

  void _requestPayment() {
    setState(() {
      isRequestingPayment = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        pendingInsuranceAmount = 0;
        isRequestingPayment = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Payment requested successfully')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Financial Overview",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Pharmacy_Screen(),
                      ),
                    );
          },
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSummaryCard(),
            const SizedBox(height: 20),
            _buildTransactionBreakdown(),
            const SizedBox(height: 20),
            _buildRequestPaymentSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Sales Summary",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          const Divider(),
          _buildEarningsRow("Cash Sales", cashSales, Colors.orange),
          _buildEarningsRow("Insurance Sales", insuranceSales, Colors.lightBlue),
          _buildEarningsRow("Pending Insurance Amount", pendingInsuranceAmount, Colors.redAccent),
        ],
      ),
    );
  }

  Widget _buildEarningsRow(String label, double amount, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: color.withOpacity(0.9),
            ),
          ),
          Text(
            "\$${amount.toStringAsFixed(2)}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionBreakdown() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Transaction Breakdown",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order ID: ${transaction["orderId"]}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Customer: ${transaction["customer"]}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Date: ${transaction["date"]}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Column(
                        children: List.generate(transaction["payments"].length, (i) {
                          final payment = transaction["payments"][i];
                          return Row(
                            children: [
                              Icon(
                                payment["source"] == "Insurance"
                                    ? Icons.security
                                    : Icons.account_balance_wallet,
                                color: payment["source"] == "Insurance"
                                    ? Colors.lightBlue
                                    : Colors.orange,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  "${payment["source"]}: \$${payment["amount"].toStringAsFixed(2)}",
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestPaymentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Request Payment",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Center(
          child: GestureDetector(
            onTap: pendingInsuranceAmount > 0 && !isRequestingPayment ? _requestPayment : null,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 32),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: isRequestingPayment
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      "Request Pending Payment",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
            ),
          ),
        ),
        if (pendingInsuranceAmount > 0)
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Center(
              child: Text(
                "Request to transfer pending insurance amount to your account.",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
          ),
      ],
    );
  }
}
