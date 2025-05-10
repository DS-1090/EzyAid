import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/langprovider.dart';
import 'fontprovider.dart';
import 'langschemedetailspage.dart';

class LangSchemesPage extends StatelessWidget {
  LangSchemesPage({super.key});

  final Map<String, List<String>> schemeData = {
    'hi': [
      'फीड फॉर सीड',
      'प्रधान मंत्री आवास योजना',
      'महात्मा ज्योतिबा फुले ओवरसीज विद्या निधि',
      'अपंजीकृत श्रमिकों के लिए राहत'

    ],
    'te': [
      'ఫీడ్ ఫర్ సీడ్',
      'ప్రధాన మంత్రి అవాస్ యోజన',
      'మహాత్మా జ్యోతిబా ఫూలే ఓవర్సీస్ విద్యా నిధి',
      'నమోదు కాలేని కార్మికులకు సహాయం'
    ],
  };

  @override
  Widget build(BuildContext context) {
    final fontSize = Provider.of<FontSizeProvider>(context).fontSize;

    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, _) {
        final lang = languageProvider!.currentLanguage;
        final schemes = schemeData[lang] ?? [];

        return Scaffold(
          backgroundColor: Colors.blue[50],
          appBar: AppBar(
            title: Text(
              lang == 'hi'
                  ? 'योजना'
                  : lang == 'te'
                  ? 'యోజన'
                  : 'Scheme', // Default to English
              style: TextStyle(fontSize: fontSize + 2, color: Colors.white),
            ),
            backgroundColor: Colors.lightBlue.shade600,
            iconTheme: const IconThemeData(color: Colors.white),
            actions: [
              PopupMenuButton<String>(
                icon: const Icon(Icons.language, color: Colors.white),
                onSelected: (value) {
                  languageProvider?.setLanguage(value);
                },
                itemBuilder: (context) => const [
                  PopupMenuItem(value: 'hi', child: Text('हिन्दी')),
                  PopupMenuItem(value: 'te', child: Text('తెలుగు')),
                ],
              ),
            ],
          ),
          body: schemes.isEmpty
              ? Center(
            child: Text(
              'No scheme available for selected language.',
              style: TextStyle(fontSize: fontSize),
            ),
          )
              : ListView.builder(
            itemCount: schemes.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 3,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  title: Text(
                    schemes[index],
                    style: TextStyle(fontSize: fontSize),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black54),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LangSchemeDetailsPage(
                          schemeName: schemes[index],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
