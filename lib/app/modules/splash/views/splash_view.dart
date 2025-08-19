import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Image.asset(
                'assets/images/ganesha_icon.png',
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'GARUDA - YOUTH ASSOCIATION',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                  fontFamily: 'Times New Roman'),
            ),
            SizedBox(height: 6),
            Text(
              'CHAKRIYAL - 3RD WARD',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Times New Roman'),
            ),
          ],
        ),
      ),
    );
  }
}
