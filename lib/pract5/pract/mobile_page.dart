import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dart_ping/dart_ping.dart';

class PingIpPage extends StatefulWidget {
  @override
  _PingIpPageState createState() => _PingIpPageState();
}

class _PingIpPageState extends State<PingIpPage> {
  String? _ipAddress;
  String? _pingResult;

  @override
  void initState() {
    super.initState();
    _getIpAddress();
    _pingGoogleDNS();
  }

  // Функция для получения публичного IP через API
  Future<void> _getIpAddress() async {
    try {
      final response = await http.get(Uri.parse('https://api.ipify.org?format=json'));
      final ipData = json.decode(response.body);
      setState(() {
        _ipAddress = ipData['ip'];
      });
    } catch (error) {
      setState(() {
        _ipAddress = 'Ошибка получения IP';
      });
    }
  }

  // Функция для пинга Google DNS
  void _pingGoogleDNS() async {
    try {
      final ping = Ping('8.8.8.8', count: 5); // Пинг до Google DNS
      String result = '';
      await for (var response in ping.stream) {
        if (response.error != null) {
          result += 'Ошибка: ${response.error}\n';
        } else {
          result += 'Ответ: ${response.summary?.time!.inMilliseconds} ms\n';
        }
      }
      setState(() {
        _pingResult = result;
      });
    } catch (error) {
      setState(() {
        _pingResult = 'Ошибка при пинге';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ping & IP Address'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_ipAddress != null)
              Text('Ваш IP: $_ipAddress'),
            if (_ipAddress == null)
              CircularProgressIndicator(),
            SizedBox(height: 20),
            if (_pingResult != null)
              Text('Результат пинга:\n$_pingResult'),
            if (_pingResult == null)
              CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
