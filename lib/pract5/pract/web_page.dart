import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ConnectionCountryPage extends StatefulWidget {
  const ConnectionCountryPage({super.key});

  @override
  State<ConnectionCountryPage> createState() => _ConnectionCountryPageState();
}

class _ConnectionCountryPageState extends State<ConnectionCountryPage> {
  String _connectionStatus = 'Unknown';
  String? _country;
  final Connectivity _connectivity = Connectivity();

  @override
  void initState() {
    super.initState();
    _checkConnection();
  }

  Future<void> _checkConnection() async {
    var connectivityResult = (await _connectivity.checkConnectivity())[0];
    String connectionType;
    if (connectivityResult == ConnectivityResult.mobile) {
      connectionType = 'Mobile';
    } else if (connectivityResult == ConnectivityResult.wifi) {
      connectionType = 'WiFi';
    } else {
      connectionType = 'No Internet';
    }

    setState(() {
      _connectionStatus = connectionType;
    });

    if (connectionType != 'No Internet') {
      _fetchCountry();
    }
  }

  Future<void> _fetchCountry() async {
    try {
      // Получаем публичный IP
      final ipResponse = await http.get(Uri.parse('https://api.ipify.org?format=json'));
      print(ipResponse);
      final ip = json.decode(ipResponse.body)['ip'];

      // Используем IP для получения информации о стране
      final locationResponse = await http.get(Uri.parse('https://ipapi.co/$ip/json/'));
      final locationData = json.decode(locationResponse.body);

      setState(() {
        _country = locationData['country_name'];
      });
    } catch (error) {
      setState(() {
        _country = 'Could not fetch location';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Connection Status: $_connectionStatus'),
            if (_country != null) Text('Country: $_country'),
            if (_country == null && _connectionStatus != 'No Internet')
              CircularProgressIndicator(),
            if (_connectionStatus == 'No Internet')
              Text('No connection to the internet'),
            FloatingActionButton(onPressed: _checkConnection,
              child: Icon(Icons.refresh),)
          ],
        ),
      );
  }
}