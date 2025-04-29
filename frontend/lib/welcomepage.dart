import 'package:flutter/material.dart';
import 'dashboard.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade50,
      body: Column(
        children: [
          const SizedBox(height: 5), // Offset from top

          // Top Blue Container with White Text and Glow
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 30),
            decoration: BoxDecoration(
              color: Colors.lightBlue.shade700,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.lightBlueAccent.withOpacity(0.6),
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Center(
              child: Text(
                "Welcome to EzyAid!",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // White text on blue background
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),

          // EzyAid Logo
          Expanded(
            child: Center(
              child: Image.asset(
                'assets/ezyaid.png',
                height: 350,
              ),
            ),
          ),

          const SizedBox(height: 30),

          // Get Started Button with Arrow on Right and Glow Effect
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.lightBlueAccent.withOpacity(0.6),
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: SizedBox(
              width: 180, // Adjusted button width
              height: 50, // Adjusted button height
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Dashboard(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue.shade600,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Get Started",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 5), // Space between text and icon
                    const Icon(Icons.arrow_forward),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 70), // Spacing at the bottom
        ],
      ),
    );
  }
}