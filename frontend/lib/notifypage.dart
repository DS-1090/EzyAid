import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'fontprovider.dart';

class NotifyPage extends StatefulWidget {
  const NotifyPage({Key? key}) : super(key: key);
  @override
  State<NotifyPage> createState() => _NotifyPageState();
}

class _NotifyPageState extends State<NotifyPage> {
  List<dynamic> _logs = [];
  bool _loading = true;
  String _error = '';
  @override
  void initState() {
    super.initState();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:8000/getNotifications'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _logs = data['notifications'];
          print(_logs);
          _loading = false;
        });
      } else {
        setState(() {
          _error = 'Failed to load logs. Status code: ${response.statusCode}';
          _loading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error fetching logs: $e';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final fontSize = Provider.of<FontSizeProvider>(context).fontSize;

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Notifications', style: TextStyle(color: Colors.white, fontSize: fontSize + 2)),
        backgroundColor: Colors.lightBlue.shade600,
      ),

      body: _loading
          ? Center(child: CircularProgressIndicator())
          : _error.isNotEmpty
          ? Center(child: Text(_error, style: TextStyle(fontSize: fontSize)))
          : ListView.builder(
        itemCount: _logs.length,
        itemBuilder: (context, index) {
          var notification = _logs[index];

          List<Widget> notificationFields = [];
          notification.forEach((key, value) {
            if (value != null && value.isNotEmpty) {
              notificationFields.add(
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      Text(
                        "$key: ",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87, fontSize: fontSize),
                      ),
                      Expanded(
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.black54, fontSize: fontSize),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          });

          return Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: notificationFields,
              ),
            ),
          );
        },
      ),
    );
  }
}
