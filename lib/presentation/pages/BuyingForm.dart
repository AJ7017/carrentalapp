import 'package:carrentalapp/presentation/pages/EndPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BuyingForm extends StatefulWidget {
  final String carModel;
  final double pricePerHour;

  const BuyingForm({super.key, required this.carModel, required this.pricePerHour});

  @override
  State<BuyingForm> createState() => _BuyingFormState();
}

class _BuyingFormState extends State<BuyingForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController idCardController = TextEditingController();
  final TextEditingController hoursController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  double totalBill = 0.0;

  void calculateBill() {
    final hours = int.tryParse(hoursController.text) ?? 0;
    if (hours > 0) {
      setState(() {
        totalBill = hours * widget.pricePerHour;
      });
    } else {
      setState(() {
        totalBill = 0.0;
      });
    }
  }

  Future<void> saveToFirestore() async {
    final registrationData = {
      'name': nameController.text.trim(),
      'contactNumber': contactController.text.trim(),
      'email': emailController.text.trim(),
      'address': addressController.text.trim(),
      'idCardNumber': idCardController.text.trim(),
      'carModel': widget.carModel,
      'hours': int.tryParse(hoursController.text.trim()) ?? 0,
      'totalBill': totalBill,
      'timestamp': FieldValue.serverTimestamp(),
    };

    try {
      await FirebaseFirestore.instance.collection('registrations').add(registrationData);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registration successful!")),
      );
      Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const EndPage(), 
      ),
    );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving registration: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff2C2B34),
        title: Text(
          "Car Rental - ${widget.carModel}",
          style: const TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: const Color(0xff2C2B34),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Register for ${widget.carModel}",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              _buildInputField(
                controller: nameController,
                label: "Full Name",
                icon: Icons.person,
              ),
              const SizedBox(height: 20),
              _buildInputField(
                controller: contactController,
                label: "Contact Number",
                icon: Icons.phone,
                inputType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Contact Number is required";
                  }
                  if (value.length != 11 || !RegExp(r'^\d+$').hasMatch(value)) {
                    return "Enter a valid 11-digit Contact Number";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 5),
              const Text(
                "Note: Enter an 11-digit contact number without dashes.",
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 20),
              _buildInputField(
                controller: emailController,
                label: "Email Address",
                icon: Icons.email,
                inputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              _buildInputField(
                controller: addressController,
                label: "Address",
                icon: Icons.home,
              ),
              const SizedBox(height: 20),
              _buildInputField(
                controller: idCardController,
                label: "ID Card Number",
                icon: Icons.credit_card,
                inputType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "ID Card Number is required";
                  }
                  if (value.length != 13 || !RegExp(r'^\d+$').hasMatch(value)) {
                    return "Enter a valid 13-digit ID Card Number";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 5),
              const Text(
                "Note: Enter a 13-digit ID Card Number without dashes.",
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 20),
              _buildInputField(
                controller: hoursController,
                label: "Hours to Rent",
                icon: Icons.timer,
                inputType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter the number of hours";
                  }
                  if (int.tryParse(value) == null || int.parse(value) <= 0) {
                    return "Enter a valid number of hours";
                  }
                  return null;
                },
                onChanged: (_) => calculateBill(),
              ),
              const SizedBox(height: 30),
              Text(
                "Total Bill: \$${totalBill.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      saveToFirestore();
                    }
                  },
                  child: const Text(
                    "Submit",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required IconData icon,
    TextInputType inputType = TextInputType.text,
    TextEditingController? controller,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      style: const TextStyle(color: Colors.white),
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        prefixIcon: Icon(icon, color: Colors.white),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
