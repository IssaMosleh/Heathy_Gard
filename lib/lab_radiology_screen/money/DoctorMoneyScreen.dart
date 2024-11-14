import 'package:flutter/material.dart';

class DoctorMoneyScreen_LAB extends StatefulWidget {
  const DoctorMoneyScreen_LAB({Key? key}) : super(key: key);

  @override
  _DoctorMoneyScreenState createState() => _DoctorMoneyScreenState();
}

class _DoctorMoneyScreenState extends State<DoctorMoneyScreen_LAB> {
  double outOfPocketEarnings = 5000.0;
  double insuranceEarnings = 15000.0;
  double pendingInsuranceAmount = 3000.0;
  bool isRequestingPayment = false;

  final List<Map<String, dynamic>> transactions = [
    {
      "date": "05 November 2023",
      "patient": "John Doe",
      "payments": [
        {"source": "Out-of-Pocket", "amount": 200.0},
        {"source": "Insurance", "amount": 800.0},
      ],
    },
    {
      "date": "03 November 2023",
      "patient": "Jane Smith",
      "payments": [
        {"source": "Insurance", "amount": 1200.0},
      ],
    },
    {
      "date": "01 November 2023",
      "patient": "Alice Johnson",
      "payments": [
        {"source": "Insurance", "amount": 1500.0},
      ],
    },
    {
      "date": "29 October 2023",
      "patient": "Michael Brown",
      "payments": [
        {"source": "Out-of-Pocket", "amount": 300.0},
      ],
    },
  ];

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
        title: const Text("Financial Overview",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
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
            "Earnings Summary",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          const Divider(),
          _buildEarningsRow("Out-of-Pocket Earnings", outOfPocketEarnings, Colors.orange),
          _buildEarningsRow("Insurance Earnings", insuranceEarnings, Colors.lightBlue),
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
                        "Patient: ${transaction["patient"]}",
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
                  colors: [Colors.blue, Colors.purple],
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
