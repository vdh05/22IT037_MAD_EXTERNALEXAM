import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/database_service.dart';
import 'screens/home_screen.dart';
import 'models/user_model.dart';
import 'screens/auth_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize local database
  await DatabaseService().initialize();
  
  // Initialize Firebase with options
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "YOUR_API_KEY",
      authDomain: "your-app.firebaseapp.com",
      projectId: "your-app-id",
      storageBucket: "your-app.appspot.com",
      messagingSenderId: "123456789012",
      appId: "1:123456789012:web:abc123def456",
    ),
  );
  
  runApp(const MaterialTrackingApp());
}

class MaterialTrackingApp extends StatelessWidget {
  const MaterialTrackingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material Tracking & Costing',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const AuthScreen(),
    );
  }
}
