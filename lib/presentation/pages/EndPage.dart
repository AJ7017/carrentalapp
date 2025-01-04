import 'package:carrentalapp/presentation/pages/car_list_screen.dart';
import 'package:flutter/material.dart';

class EndPage extends StatelessWidget {
  const EndPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff2C2B34),
        title: const Text(
          'Booking Completed',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: const Color(0xff2C2B34),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            Icon(
              Icons.check_circle_outline,
              size: 100,
              color: Colors.grey,
            ),
            const SizedBox(height: 20),
            // "Continue Booking" button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  CarListScreen(), 
                  ),
                );
              },
              child: const Text(
                'Continue Booking',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
