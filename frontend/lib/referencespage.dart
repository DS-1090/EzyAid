import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'fontprovider.dart';

class ReferenceLinksPage extends StatelessWidget {
  const ReferenceLinksPage({super.key});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  Widget buildLinkTile(BuildContext context,String title, String url) {
    final fontSize = Provider.of<FontSizeProvider>(context).fontSize;

    return ListTile(
      title: Text(title, style:  TextStyle(fontSize: fontSize + 2)),
      trailing: const Icon(Icons.open_in_new, size: 16),
      onTap: () => _launchURL(url),
    );
  }


  Widget buildCategory(BuildContext context, String categoryTitle, List<Map<String, String>> links) {
    final fontSize = Provider.of<FontSizeProvider>(context).fontSize;

    return Card(
      color: Colors.lightBlue.shade50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          categoryTitle,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: fontSize + 2, // Apply dynamic font size here
          ),
        ),
        children: links
            .map((link) => buildLinkTile(context, link['title']!, link['url']!))
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final List<Map<String, dynamic>> referenceData = [
      {
        'category': 'ICDS & Nutrition',
        'links': [
          {'title': 'ICDS Website', 'url': 'http://icds-wcd.nic.in/'},
          {'title': 'Arogya Lakshmi Guidelines', 'url': 'https://wdcw.tg.nic.in/Arogya_Lakshmi.html'},
          {'title': 'Help Desk', 'url': 'https://wdcw.tg.nic.in/contact_us.html'},
          {'title': 'Nutrition Kit', 'url': 'https://cm.telangana.gov.in/2022/12/kcr-nutrition-kit/'},
        ],
      },
      {
        'category': 'Dalit Bandhu',
        'links': [
          {'title': 'Dalit Bandhu Home Page', 'url': 'https://dalitbandhu.telangana.gov.in/Home/Index'},
          {'title': 'Kamareddy District Website', 'url': 'https://kamareddy.telangana.gov.in/scheme/dalita-bandhu-scheme/'},
          {'title': 'CM Official Website', 'url': 'https://cm.telangana.gov.in/'},
        ],
      },
      {
        'category': 'E-PASS Scholarships',
        'links': [
          {'title': 'EPASS Portal', 'url': 'https://telanganaepass.cgg.gov.in/'},
          {'title': 'Overseas Guidelines', 'url': 'https://telanganaepass.cgg.gov.in/OverseasLinks.do'},
        ],
      },
      {
        'category': 'Haritha Haram',
        'links': [
          {'title': 'Home Page', 'url': 'http://harithaharam.telangana.gov.in/Harithaharam_Home.aspx'},
          {'title': 'Vision', 'url': 'http://harithaharam.telangana.gov.in/Pages/Vision.aspx'},
        ],
      },
      {
        'category': 'Coffee Board',
        'links': [
          {'title': 'ICDP Guidelines', 'url': 'https://coffeeboard.gov.in/Schemes/ICDP_388.pdf'},
          {'title': 'Grower Registration (UMANG)', 'url': 'https://web.umang.gov.in/web_new/department?url=coffee_board%2Fservice%2F1739'},
        ],
      },
      {
        'category': 'Kalyana Lakshmi / Shaadi Mubarak',
        'links': [
          {'title': 'Official Portal', 'url': 'https://telanganaepass.cgg.gov.in/KalyanaLakshmiLinks.jsp'},
          {'title': 'Apply Online', 'url': 'https://telanganaepass.cgg.gov.in/karshakTelangana.do'},
          {'title': 'Scheme Guidelines', 'url': 'https://www.telangana.gov.in/PDFDocuments/KalyanaLakshmi-GO.pdf'},
        ],
      },
      {
        'category': 'Pradhan Mantri Awas Yojana (PMAY)',
        'links': [
          {'title': 'PMAY Urban Portal', 'url': 'https://pmay-urban.gov.in/'},
          {'title': 'PMAY Gramin Portal', 'url': 'https://pmayg.nic.in/'},
          {'title': 'Telangana Housing Board', 'url': 'https://hb.telangana.gov.in/'},
        ],
      },
      {
        'category': 'Skill Development',
        'links': [
          {'title': 'Skill India Portal', 'url': 'https://www.skillindia.gov.in/'},
          {'title': 'TASK (Telangana)', 'url': 'https://task.telangana.gov.in/'},
          {'title': 'NSDC', 'url': 'https://nsdcindia.org/'},
        ],
      },
      {
        'category': 'Health Schemes',
        'links': [
          {'title': 'Aarogyasri Telangana', 'url': 'https://aarogyasri.telangana.gov.in/'},
          {'title': 'Ayushman Bharat', 'url': 'https://pmjay.gov.in/'},
          {'title': 'Health Dept Telangana', 'url': 'https://health.telangana.gov.in/'},
        ],
      },
      {
        'category': 'Minority & ePass Schemes',
        'links': [
          {'title': 'Guideline', 'url': 'https://telanganaepass.cgg.gov.in/downloads/MInority_AOVN_GO.pdf'},
          {'title': 'Order', 'url': 'https://telanganaepass.cgg.gov.in/downloads/MInority_AOVN_GO126.pdf'},
          {'title': 'EPASS Portal', 'url': 'https://telanganaepass.cgg.gov.in/'},
          {'title': 'Revised Order', 'url': 'https://goir.telangana.gov.in/pdfshow.aspx'},
        ],
      },
      {
        'category': 'PMEGP Scheme',
        'links': [
          {'title': 'Scheme Guidelines 2023', 'url': 'https://msme.gov.in/sites/default/files/Revisedguidelines07.12.2023.pdf'},
          {'title': 'FAQs', 'url': 'https://www.kviconline.gov.in/pmegpeportal/jsp/FAQ.jsp'},
          {'title': 'Application Portal', 'url': 'https://msme.gov.in/1-prime-ministers-employment-generation-programme-pmegp'},
        ],
      },
    ];
    final fontSize = Provider.of<FontSizeProvider>(context).fontSize;

    return
      Scaffold(
      appBar: AppBar(
        title: Text('Reference Links',
          style: TextStyle(
          color: Colors.white,
            fontSize: fontSize+2
        ),),
        backgroundColor: Colors.lightBlue.shade600,
         leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: referenceData
            .map((section) => buildCategory(context, section['category'], section['links']))
            .toList(),
      ),
    );
  }
}
