import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';

class MacAddressPage extends StatefulWidget {
  const MacAddressPage({super.key});

  @override
  State<MacAddressPage> createState() => _MacAddressPageState();
}

class _MacAddressPageState extends State<MacAddressPage> {
  String? _macAddress;

  @override
  void initState() {
    super.initState();
    _getMacAddress();
  }

  Future<void> _getMacAddress() async {
    final info = NetworkInfo();
    String? macAddress = await info.getWifiBSSID(); // Используется BSSID как MAC
    setState(() {
      _macAddress = macAddress;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MAC Address'),
      ),
      body: Center(
        child: _macAddress != null
            ? Text('MAC Address: $_macAddress')
            : CircularProgressIndicator(),
      ),
    );
  }
}