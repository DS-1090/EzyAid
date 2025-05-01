import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'schemedetailspage.dart';
import 'fontprovider.dart';
import 'text_to_speech.dart';
import 'package:http/http.dart' as http;
import 'favoritespage.dart';
import 'favoritesprovider.dart';

class SchemesPage extends StatefulWidget {
  const SchemesPage({super.key});

  @override
  _SchemesPageState createState() => _SchemesPageState();
}

class _SchemesPageState extends State<SchemesPage> {
  bool flag = false;
  List<String> selectedBeneficiaries = [];
  List<String> selectedCategories = [];
  bool showBeneficiaryDropdown = false;
  bool showCategoryDropdown = false;
  List<String> favs = [];
  List<dynamic> schemeDirectory = [];
  String error = "";
  bool isSchemeLoading = true;
  bool isTtsEnabled = false;

  final TextToSpeechService tts = TextToSpeechService();

  Future<void> fetchSchemes() async {
    setState(() {
      error = "";
      flag = false;
    });

    final url = Uri.parse('http://10.0.2.2:8000/getSchemes/');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          schemeDirectory = json.decode(response.body);
          flag = true;
        });
      } else {
        setState(() {
          error = 'Failed to load data: ${response.body}';
        });
      }
    } catch (e) {
      setState(() {
        error = 'Error: $e';
      });
    } finally {
      setState(() {
        isSchemeLoading = false;
      });
    }
  }

  final List<String> beneficiaryTypes = [
    "Woman", "Child", "Disability", "Backward", "Student", "Agriculture"
  ];

  final List<String> categories = [
    "Agriculture, Rural & Environment",
    "Health & Wellness",
    "Education & Learning",
    "Social Welfare & Empowerment",
    "Utility & Sanitation",
    "Women and Child",
    "Science, IT & Communications",
    "Business & Entrepreneurship",
    "Transport & Infrastructure",
    "Housing & Shelter",
    "Sports & Culture",
    "Banking, Financial Services and Insurance",
    "Skills & Employment"
  ];

  @override
  void initState() {
    super.initState();
    fetchSchemes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<FontSizeProvider>(
          builder: (context, fontSizeProvider, child) {
            return Text(
              "Schemes",
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSizeProvider.fontSize + 3,
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              isTtsEnabled ? Icons.volume_up : Icons.volume_off,
              color: Colors.white,
            ),
            tooltip: isTtsEnabled ? 'TTS On' : 'TTS Off',
            onPressed: () {
              setState(() {
                isTtsEnabled = !isTtsEnabled;
              });
            },
          ),

        ],
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.lightBlue.shade600, Colors.lightBlue.shade600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildFilters(),
            _buildSchemeList(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDropdown(
            title: "Beneficiary Type",
            isExpanded: showBeneficiaryDropdown,
            onToggle: () => setState(() => showBeneficiaryDropdown = !showBeneficiaryDropdown),
            items: beneficiaryTypes,
            selectedItems: selectedBeneficiaries,
            onChanged: (value) {
              setState(() {
                selectedBeneficiaries.contains(value)
                    ? selectedBeneficiaries.remove(value)
                    : selectedBeneficiaries.add(value);
              });
            },
          ),
          _buildDropdown(
            title: "Category",
            isExpanded: showCategoryDropdown,
            onToggle: () => setState(() => showCategoryDropdown = !showCategoryDropdown),
            items: categories,
            selectedItems: selectedCategories,
            onChanged: (value) {
              setState(() {
                selectedCategories.contains(value)
                    ? selectedCategories.remove(value)
                    : selectedCategories.add(value);
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required String title,
    required bool isExpanded,
    required VoidCallback onToggle,
    required List<String> items,
    required List<String> selectedItems,
    required ValueChanged<String> onChanged,
  }) {
    return Consumer<FontSizeProvider>(
      builder: (context, fontSizeProvider, child) {
        return Column(
          children: [
            ListTile(
              title: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: fontSizeProvider.fontSize,
                ),
              ),
              trailing: Icon(
                isExpanded ? Icons.expand_less : Icons.expand_more,
                color: Colors.black,
              ),
              onTap: onToggle,
            ),
            if (isExpanded)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: items.map((item) {
                    return CheckboxListTile(
                      activeColor: Colors.lightBlue.shade600,
                      title: Text(
                        item,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: fontSizeProvider.fontSize - 2,
                        ),
                      ),
                      value: selectedItems.contains(item),
                      onChanged: (bool? checked) {
                        if (checked != null) onChanged(item);
                      },
                    );
                  }).toList(),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildSchemeList() {
    if (isSchemeLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: CircularProgressIndicator(),
        ),
      );
    }

    List<dynamic> filteredSchemes = schemeDirectory.where((scheme) {
      final tags = scheme["tags"] ?? [];
      bool matchesBeneficiary = selectedBeneficiaries.isEmpty ||
          selectedBeneficiaries.any((beneficiary) =>
              tags.contains(beneficiary));

      bool matchesCategory = selectedCategories.isEmpty ||
          selectedCategories.contains(scheme["category"]);

      return matchesBeneficiary && matchesCategory;
    }).toList();

    return Consumer<FontSizeProvider>(
      builder: (context, fontSizeProvider, child) {
        // return ListView.builder(
        //   shrinkWrap: true,
        //   physics: const NeverScrollableScrollPhysics(),
        //   itemCount: filteredSchemes.length,
        //   itemBuilder: (context, index) {
        //     final scheme = filteredSchemes[index];
        //     final schemeName = scheme["scheme_name"] ?? "Unnamed Scheme";
        //
        //     return Padding(
        //       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        //       child: Card(
        //         color: Colors.lightBlue.shade50,
        //         shape: RoundedRectangleBorder(
        //           borderRadius: BorderRadius.circular(12),
        //         ),
        //         elevation: 6,
        //         shadowColor: Colors.blueAccent.withOpacity(0.3),
        //         child: ListTile(
        //           contentPadding: const EdgeInsets.all(16),
        //           title: Text(
        //             schemeName,
        //             style: TextStyle(
        //               fontSize: fontSizeProvider.fontSize + 2,
        //               fontWeight: FontWeight.bold,
        //               color: Colors.black,
        //             ),
        //           ),
        //           trailing: const Icon(Icons.arrow_forward_ios, color: Colors.lightBlue),
        //           onTap: () {
        //             Navigator.push(
        //               context,
        //               MaterialPageRoute(
        //                 builder: (context) => SchemeDetailsPage(
        //                   scheme: scheme,
        //                   favs: favs,
        //                 ),
        //               ),
        //             );
        //             if (isTtsEnabled) {
        //               tts.speak(schemeName);
        //             }
        //           },
        //         ),
        //       ),
        //     );
        //   },
        // );
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: filteredSchemes.length,
          itemBuilder: (context, index) {
            final scheme = filteredSchemes[index];
            final schemeName = scheme["scheme_name"] ?? "Unnamed Scheme";
            final favoritesProvider = Provider.of<FavoritesProvider>(context);
            final isFav = favoritesProvider.isFavorite(schemeName);

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Card(
                color: Colors.lightBlue.shade50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 6,
                shadowColor: Colors.blueAccent.withOpacity(0.3),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(
                    schemeName,
                    style: TextStyle(
                      fontSize: fontSizeProvider.fontSize + 2,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: isFav ? Colors.red : Colors.grey,
                        ),
                        tooltip: isFav ? "Remove from favorites" : "Add to favorites",
                        onPressed: () {
                          isFav
                              ? favoritesProvider.removeFavorite(schemeName)
                              : favoritesProvider.addFavorite(schemeName);
                        },
                      ),
                      const Icon(Icons.arrow_forward_ios, color: Colors.lightBlue),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SchemeDetailsPage(
                          scheme: scheme,
                          favs: favs, // optional, can be removed if not used anymore
                        ),
                      ),
                    );
                    if (isTtsEnabled) {
                      tts.speak(schemeName);
                    }
                  },
                ),
              ),
            );
          },
        );

      },
    );
  }
}