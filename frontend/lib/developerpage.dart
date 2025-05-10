import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'fontprovider.dart';
import 'package:url_launcher/url_launcher.dart';

class DeveloperPage extends StatelessWidget {
  const DeveloperPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fontSize = Provider.of<FontSizeProvider>(context).fontSize;

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text(
          'Team EzyAid',
          style: TextStyle(fontSize: fontSize + 2, color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.lightBlue.shade600,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            DeveloperCard(
              name: "Snigdha UG",
              id: "100521733050",
              github: "https://github.com/",
              email: "snigdha.udutha@gmail.com",
            ),
            const SizedBox(height: 16),
            DeveloperCard(
              name: "Divya Sahithi V",
              id: "100521733054",
              github: "https://github.com/DS-1090",
              email: "divya.yennam5544@gmail.com",
            ),
            const Divider(height: 40),
            Text(
              "Technologies Used",
              style: TextStyle(
                fontSize: fontSize + 1,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: [
                for (final tech in [
                  "Flutter", "Django", "Redis", "Debezium",
                  "Apache Kafka", "MySQL", "Apache Spark"
                ])
                  DefaultTextStyle.merge(
                    style: TextStyle(fontSize: fontSize),
                    child: Chip(label: Text(tech)),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DeveloperCard extends StatelessWidget {
  final String name;
  final String id;
  final String? github;
  final String? email;

  const DeveloperCard({
    Key? key,
    required this.name,
    required this.id,
    this.github,
    this.email,
  }) : super(key: key);

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final fontSize = Provider.of<FontSizeProvider>(context).fontSize;

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name,
                style: TextStyle(
                    fontSize: fontSize + 2, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text("Roll No: $id",
                style:
                TextStyle(fontSize: fontSize, color: Colors.grey[700])),
            const SizedBox(height: 8),
            Row(
              children: [
                if (github != null)
                  IconButton(
                    icon: const Icon(Icons.code),
                    onPressed: () => _launchURL(github!),
                    tooltip: "GitHub",
                  ),
                if (email != null)
                  IconButton(
                    icon: const Icon(Icons.email),
                    onPressed: () => _launchURL('mailto:$email'),
                    tooltip: "Email",
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}