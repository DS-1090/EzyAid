import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'fontprovider.dart';
import 'text_to_speech.dart'; // Import the TextToSpeechService

class SchemeDetailsPage extends StatefulWidget {
  final Map<String, dynamic> scheme;
  final List<String> favs;

  const SchemeDetailsPage({
    super.key,
    required this.scheme,
    required this.favs,
  });

  @override
  State<SchemeDetailsPage> createState() => _SchemeDetailsPageState();
}

class _SchemeDetailsPageState extends State<SchemeDetailsPage>
    with SingleTickerProviderStateMixin {
  bool isLiked = false;
  bool isTtsEnabled = false;
  final TextToSpeechService tts = TextToSpeechService();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _loadLikeState();

    // Initialize the TabController with length 4 (number of tabs)
    _tabController = TabController(length: 4, vsync: this);

    // Add a listener to handle the tab change and speak the current tab text if TTS is enabled
    _tabController.addListener(() {
      if (!isTtsEnabled || !_tabController.indexIsChanging) return;
      _speakCurrentTabText();
    });
  }

  @override
  void dispose() {
    _tabController.dispose(); // Dispose the controller when the widget is removed
    tts.stop(); // Stop any speech if the widget is disposed
    super.dispose();
  }

  Future<void> _loadLikeState() async {
    setState(() {
      isLiked = widget.favs.contains(widget.scheme["scheme_name"]);
    });
  }

  Future<void> updateFavorites(Map<String, dynamic> scheme, bool liked) async {
    final schemeId = scheme["scheme_name"];
    setState(() {
      if (liked) {
        if (!widget.favs.contains(schemeId)) {
          widget.favs.add(schemeId);
        }
      } else {
        widget.favs.remove(schemeId);
      }
    });
  }

  void _speakCurrentTabText() {
    final index = _tabController.index;
    String text = "";
    switch (index) {
      case 0:
        text = widget.scheme["detailed_description"] ?? "";
        break;
      case 1:
        text = widget.scheme["benefits"] ?? "";
        break;
      case 2:
        text = widget.scheme["eligibility_criteria"] ?? "";
        break;
      case 3:
        text = widget.scheme["application_process"] ?? "";
        break;
    }

    if (text.isNotEmpty) {
      tts.speak(text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final fontSize = Provider.of<FontSizeProvider>(context).fontSize;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.scheme["scheme_name"]!,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: fontSize + 4,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                isTtsEnabled ? Icons.volume_up : Icons.volume_off,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  isTtsEnabled = !isTtsEnabled;
                  if (isTtsEnabled) {
                    _speakCurrentTabText();
                  } else {
                    tts.stop();
                  }
                });
              },
            ),
            IconButton(
              icon: Icon(
                isLiked ? Icons.favorite : Icons.favorite_border,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  isLiked = !isLiked;
                  updateFavorites(widget.scheme, isLiked);
                });
              },
            ),
          ],
          iconTheme: const IconThemeData(color: Colors.white),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1976D2), Color(0xFF2196F3)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          bottom: TabBar(
            controller: _tabController, // Set the controller for the TabBar
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: const [
              Tab(text: "Details"),
              Tab(text: "Benefits"),
              Tab(text: "Eligibility"),
              Tab(text: "Application"),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController, // Set the controller for the TabBarView
          children: [
            _buildTabContent(context, widget.scheme["detailed_description"] ?? "", fontSize),
            _buildTabContent(context, widget.scheme["benefits"] ?? "", fontSize),
            _buildTabContent(context, widget.scheme["eligibility_criteria"] ?? "", fontSize),
            _buildTabContent(context, widget.scheme["application_process"] ?? "", fontSize),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(BuildContext context, String content, double fontSize) {
    return Container(
      color: Colors.lightBlue.shade50,
      padding: const EdgeInsets.all(16),
      child: Text(
        content,
        style: TextStyle(
          fontSize: fontSize,
          color: Colors.black87,
        ),
      ),
    );
  }
}