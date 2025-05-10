
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'fontprovider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  Future<Map<String, String>> _getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String? firstName = prefs.getString('firstName');
    String? lastName = prefs.getString('lastName');
    String? age = prefs.getString('age');


    return {
      'firstName': firstName ?? 'N/A',
      'lastName': lastName ?? 'N/A',
      'age': age ?? 'N/A',

    };
  }

  @override
  Widget build(BuildContext context) {
    final fontSize = Provider.of<FontSizeProvider>(context).fontSize;

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(fontSize: fontSize + 2, color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.lightBlue.shade600,
      ),
      body: FutureBuilder<Map<String, String>>(
        future: _getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            final data = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Icon(Icons.person_rounded, size: 80, color: Colors.blue[400]),
                      ),
                      const SizedBox(height: 20),
                      ProfileRow(label: "First Name", value: data['firstName']!, fontSize: fontSize),
                      ProfileRow(label: "Last Name", value: data['lastName']!, fontSize: fontSize),
                      ProfileRow(label: "Age", value: data['age']!, fontSize: fontSize),

                    ],
                  ),
                ),
              ),
            );
          }

          return const Center(
            child: Text(
              "No data available",
              style: TextStyle(fontSize: 18),
            ),
          );
        },
      ),
    );
  }
}

class ProfileRow extends StatelessWidget {
  final String label;
  final String value;
  final double fontSize;

  const ProfileRow({
    Key? key,
    required this.label,
    required this.value,
    required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              "$label:",
              style: TextStyle(fontSize: fontSize + 1, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value,
              style: TextStyle(fontSize: fontSize),
            ),
          ),
        ],
      ),
    );
  }
}
