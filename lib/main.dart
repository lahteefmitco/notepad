import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:notepad/screens/home_screen.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Request permission
  await _requestStoragePermission();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

Future<void> _requestStoragePermission() async {
 
  if (await Permission.manageExternalStorage.isGranted) {
    log("manage Storage permission already granted.");
  } else {
    PermissionStatus status = await Permission.manageExternalStorage.request();
    if (status.isGranted) {
      log("manage Storage permission granted.");
    } else if (status.isDenied) {
      log("Storage permission denied.");
    } else if (status.isPermanentlyDenied) {
      log(
          "manage Storage permission permanently denied. Please enable it in settings.");
      await openAppSettings();
    }
  }

  if (await Permission.storage.isGranted) {
    log("Storage permission already granted.");
  } else {
    PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      log("Storage permission granted.");
    } else if (status.isDenied) {
      log("Storage permission denied.");
    } else if (status.isPermanentlyDenied) {
      log(
          "Storage permission permanently denied. Please enable it in settings.");
      await openAppSettings();
    }
  }
}
