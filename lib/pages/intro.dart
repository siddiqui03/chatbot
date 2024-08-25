// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'home.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 250, // Adjust width as needed
                height: 250, // Adjust height as needed
                child: Image.asset(
                  'assets/gif/chatbot.gif',
                ),
              ),
              const SizedBox(height: 10),
              // Text underneath the image
              const Text(
                'Hi there! meet zozo , Your Personal Chatbot',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey, // Set text color to grey
                ),
              ),
              const SizedBox(height: 20),
              // Continue button with pointer cursor
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.deepPurple[400], // Set button color to blue
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    minimumSize: const Size(250, 0), // Set minimum width
                  ),
                  onPressed: () {
                    // Navigate to the home page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const Home(), // Changed from 'home' to 'Home'
                      ),
                    );
                  },
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
