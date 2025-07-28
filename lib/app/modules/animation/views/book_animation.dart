import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

class BookAnimationView extends StatelessWidget {
  void _goToDonorEntryPage() {
    Get.toNamed(AppRoutes.DONOR_ENTRY);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      body: Center(
        child: GestureDetector(
          onTap: _goToDonorEntryPage,
          child: Container(
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.deepOrange, width: 2),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.deepOrange.withOpacity(0.3),
                  blurRadius: 20,
                  spreadRadius: 2,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            width: 320,
            height: 480,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  // Golden gradient background
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.orange.shade100,
                          Colors.orange.shade50,
                          Colors.orange.shade100,
                        ],
                      ),
                    ),
                  ),

                  // Subtle divine light effect
                  Positioned(
                    top: -50,
                    left: -50,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.orange.withOpacity(0.1),
                      ),
                    ),
                  ),

                  // Divine light effect 2
                  Positioned(
                    bottom: -30,
                    right: -30,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.deepOrange.withOpacity(0.1),
                      ),
                    ),
                  ),

                  // Ganesha image with modern touch
                  Positioned.fill(
                    child: Opacity(
                      opacity: 0.2,
                      child: Image.asset(
                        'assets/images/gani.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  // Decorative border elements
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.deepOrange.withOpacity(0.1),
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(12)),
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.deepOrange.withOpacity(0.1),
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(12)),
                      ),
                    ),
                  ),

                  // Main content
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Om symbol decoration
                        Icon(
                          Icons.radio_button_checked,
                          color: Colors.deepOrange,
                          size: 30,
                        ),
                        SizedBox(height: 8),

                        // Title with modern typography
                        // Text("|| ગણપતિ બપ્પા મોર્યા ||",  // Gujarati text
                        //     style: TextStyle(
                        //         fontWeight: FontWeight.bold,
                        //         fontSize: 22,
                        //         color: Colors.deepOrange,
                        //         fontFamily: 'TiroDevanagari')),

                        Text("|| గణపతి బప్పా మోరియా ||", // Telugu text
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: Colors.deepOrange)),

                        SizedBox(height: 16),

                        // Organization name with decorative elements
                        Stack(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                        thickness: 1.5,
                                        color: Colors.deepOrange),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Icon(Icons.star,
                                        color: Colors.deepOrange, size: 16),
                                  ),
                                  Expanded(
                                    child: Divider(
                                        thickness: 1.5,
                                        color: Colors.deepOrange),
                                  ),
                                ],
                              ),
                            ),
                            Center(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                color: Colors.orange.shade50,
                                child: Text("GARUDA - Youth Association",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.deepOrange)),
                              ),
                            ),
                          ],
                        ),

                        Text("Chakriyal, Sangareddy Dist.",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.deepOrange.shade700)),

                        SizedBox(height: 24),

                        Container(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.deepOrange, width: 1.5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 4), // Reduced padding
                                child: Icon(Icons.circle,
                                    size: 6,
                                    color: Colors.deepOrange), // Smaller icon
                              ),
                              Text("Vinayaka Chavithi",
                                  style: TextStyle(
                                      fontSize: 18, // Reduced from 22
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepOrange)),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 4), // Reduced padding
                                child: Icon(Icons.circle,
                                    size: 6,
                                    color: Colors.deepOrange), // Smaller icon
                              ),
                              Text("2025",
                                  style: TextStyle(
                                      fontSize: 18, // Reduced from 28
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepOrange.shade800)),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 4), // Reduced padding
                                child: Icon(Icons.circle,
                                    size: 6,
                                    color: Colors.deepOrange), // Smaller icon
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 24),

                        // Donation text with animated touch
                        AnimatedContainer(
                          duration: Duration(milliseconds: 500),
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.deepOrange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text("Donation Entry Register",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.deepOrange.shade800)),
                        ),

                        SizedBox(height: 16),

                        // Decorative element
                        Icon(Icons.arrow_downward,
                            color: Colors.deepOrange.withOpacity(0.7)),
                      ],
                    ),
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
