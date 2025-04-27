import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: const Text('Notifications', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.lightBlue.shade700,

      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : _error.isNotEmpty
          ? Center(child: Text(_error))
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
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                      Expanded(
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.black54),
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