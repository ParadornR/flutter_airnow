import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class CoordScreed extends StatefulWidget {
  const CoordScreed({super.key});

  @override
  State<CoordScreed> createState() => _CoordScreedState();
}

class _CoordScreedState extends State<CoordScreed> {
  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // ตรวจสอบว่า location service เปิดอยู่ไหม
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    // เช็คและขอ permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    // ดึงตำแหน่งปัจจุบัน
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  double latitude = 0.0;
  double longitude = 0.0;
  void _showCurrentLocation() async {
    try {
      Position position = await _getCurrentLocation();
      log('Location = [lat: ${position.latitude}, lon: ${position.longitude}]');
      latitude = position.latitude;
      longitude = position.longitude;
      setState(() {});
    } catch (e) {
      log('เกิดข้อผิดพลาด: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Text("CoordScreed"),
              Text("latitude: $latitude"),
              Text("longitude: $longitude"),
              ElevatedButton(
                onPressed: () {
                  _showCurrentLocation();
                },
                child: Text("Test geolocator"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
