import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      body: Stack(
        children: [
          // Background decorative elements
          Positioned(
            top: -50,
            right: -30,
            child: Opacity(
              opacity: 0.1,
              child: Icon(
                Icons.light_mode,
                size: 200,
                color: Colors.orange,
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            left: -30,
            child: Opacity(
              opacity: 0.1,
              child: Icon(
                Icons.light_mode,
                size: 200,
                color: Colors.orange,
              ),
            ),
          ),
          
          // Main content
          SizedBox.expand(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated container for the image
                AnimatedContainer(
                  duration: Duration(milliseconds: 800),
                  curve: Curves.easeInOut,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 2,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Hero(
                    tag: 'ganesha-icon',
                    child: Image.asset(
                      'assets/images/ganesha_icon.png',
                      fit: BoxFit.contain,
                      height: 150,
                      width: 150,
                    ),
                  ),
                ),
                
                SizedBox(height: 24),
                
                // Organization name with improved styling
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.deepOrange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'GARUDA - YOUTH ASSOCIATION',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange.shade800,
                      fontFamily: 'Times New Roman',
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                
                SizedBox(height: 12),
                
                // Location with improved styling
                Text(
                  'CHAKRIYAL - 3RD WARD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    fontFamily: 'Times New Roman',
                    letterSpacing: 1.1,
                  ),
                ),
                
                SizedBox(height: 32),
                
                // Loading indicator
                SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange),
                    strokeWidth: 2,
                  ),
                ),
              ],
            ),
          ),
          
          // Decorative border
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 4,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.orange.shade300,
                    Colors.deepOrange,
                    Colors.orange.shade300,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 4,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.orange.shade300,
                    Colors.deepOrange,
                    Colors.orange.shade300,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}