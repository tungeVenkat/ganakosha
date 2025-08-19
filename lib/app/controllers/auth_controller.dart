// import 'package:get/get.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';

// class AuthController extends GetxController {
//   RxString role = 'viewer'.obs; // default
//   Rxn<User> user = Rxn<User>();

//   @override
//   void onInit() {
//     super.onInit();
//     _initAuth();
//   }

//   void _initAuth() {
//     FirebaseAuth.instance.authStateChanges().listen((u) async {
//       if (u == null) {
//         // Silent sign-in for EVERY device (no UI)
//         final cred = await FirebaseAuth.instance.signInAnonymously();
//         user.value = cred.user;
//       } else {
//         user.value = u;
//       }

//       // Ensure a users/{uid} doc exists (viewer by default)
//       await _ensureUserDoc();

//       // Load role from Firestore
//       await _loadRole();

//       // Helpful: print UID once so you can copy it from logs
//       if (kDebugMode) {
//         // You will use this UID to grant admin role in Firestore
//         // Look for this in the debug console once.
//         // Copy it and keep it.
//         print('🆔 Current UID: ${FirebaseAuth.instance.currentUser?.uid}');
//       }
//     });
//   }

//   Future<void> _ensureUserDoc() async {
//     final uid = FirebaseAuth.instance.currentUser!.uid;
//     final ref = FirebaseFirestore.instance.collection('users').doc(uid);
//     final snap = await ref.get();
//     if (!snap.exists) {
//       await ref.set({
//         'role': 'viewer',
//         'createdAt': FieldValue.serverTimestamp(),
//       });
//     }
//   }

//   Future<void> _loadRole() async {
//     final uid = FirebaseAuth.instance.currentUser!.uid;
//     final ref = FirebaseFirestore.instance.collection('users').doc(uid);
//     final snap = await ref.get();
//     role.value = (snap.data()?['role'] ?? 'viewer').toString();
//   }

//   bool get isAdmin => role.value == 'admin';
// }
