import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'fontprovider.dart';
import 'text_to_speech.dart';
import 'package:url_launcher/url_launcher.dart';

class MeesevaCentersPage extends StatefulWidget {
  const MeesevaCentersPage({Key? key}) : super(key: key);

  @override
  _MeesevaCentersPageState createState() => _MeesevaCentersPageState();
}

class _MeesevaCentersPageState extends State<MeesevaCentersPage> {
  String searchText = "";


  final List<Map<String, String>> meesevaCenters = const [

    {
      "center": "MeeSeva Center – Amberpet",
      "address": "HNo:2-2-597/1,BAGH AMBERPET",
      "phone": "9346852582",
      "url":"https://www.google.com/maps?cid=15824634725145609551"
    },
    {
      "center": "MeeSeva Center – Amberpet",
      "address": "Sh No. 2 2-1-251, Godhama Mansion (Lahari Apts), Veg Market Road , Opp Hetero Medical Shop, Hyderabad – 500044",
      "phone": "8179796126",
      "url":"https://www.google.com/maps?cid=6786722791455950428"
    },
    {
      "center": "MeeSeva Center – Amberpet",
      "address": "2-3-512/A/231, , Chenna Reddy Nagar, Near Sai Baba Temple, Amberpet, Hyderabad - 500013",
      "phone": "8179796126",
      "url":"https://www.google.com/maps?cid=15464798969601881955"
    },
    {
      "center": "MeeSeva Center – Asifnagar",
      "address": "12-2-683/3 , Pedda Sathaiah Community Hall, Gudimalkapur, Opp. Veg-Market, Asifnagar, Hyderabad – 500028",
      "phone": "9885117977",
      "url": "https://www.google.com/maps?cid=1773399411684674839"
    },
    {
      "center": "MeeSeva Center – Asifnagar",
      "address": "SHOP NO 29, Maheshwari Complex, Masab Tank X Roads, Asifnagar, Hyderabad – 500028",
      "phone": "9390722333",
      "url":"https://maps.app.goo.gl/7KqbAcgBwvNBrKeC9"

    },
    {
      "center": "MeeSeva Center – Banjara Hills",
      "address": "Shop.No.8-2-268/2, Road.No.2, Near TV Office, Opp:Axis Bank, Banjara Hills, Hyderabad",
      "phone": "9949107511",
      "url":"https://www.google.com/maps?cid=12953117155603756851"
    },
    {
      "center": "MeeSeva Center – Bapuji Nagar",
      "address": "H.No.1-6-202/8/19/2/A, Bapuji Nagar, Parsigutta Road, Musheerabad, Hyderabad",
      "phone": "8143000098",
      "url":"https://maps.app.goo.gl/wz3Co4ZJLUTBGzTMA"
    },
    {
      "center": "MeeSeva Center – Bhadurpura",
      "address": "20-4-194/7/14/27, New Road Shah Ali Banda, Near Gowtham School, Opp Dargah, Bhadurpura, Hyderabad - 500002",
      "phone": "9030988809",
      "url":"https://maps.app.goo.gl/Ea1k6Eb8BNvsLZhv7"
    },
    {
      "center": "MeeSeva Center – Bhadurpura",
      "address": "22-2-431/3, Cool Point, Noor Khan Bazar, Opp sambritishschool, Near lalmitti Ki Darga, Bhadurpura, Hyderabad - 500024",
      "phone": "9014163923",
      "url":"https://maps.app.goo.gl/KNNLRAUaiqQ4VzDM7"

    },
    {
      "center": "MeeSeva Center – Chandrayangutta",
      "address": "18-13-132-I / 30 / A, Anmol Garden, Bandlaguda, Chandrayangutta, Hyderabad – 500005",
      "phone": "9700318930",
      "url":"https://maps.app.goo.gl/hxh4xrXreL5KBGPC6"
    },
    {
      "center": "MeeSeva Center – Charminar",
      "address": "22-6-1042 , Balaji Complex, Charminar, Kalikaman, Hyderabad – 500002",
      "phone": "9346453393",
      "url":"https://www.google.com/maps?cid=17148867972335488501"
    },
    {
      "center": "MeeSeva Center – Gaddiannaram",
      "address": "16-2-740/58, Icon Home, Kalyana Nagar, Near Municipal Park, Gaddiannaram, Saidabad, Hyderabad - 500060",
      "phone": "9849437448",
      "url":"https://maps.app.goo.gl/h798n4vqUbpR7FGt6"
    },
    {
      "center": "MeeSeva Center – Golconda",
      "address": "9-4-86/38/1, Midland Cafe, Salarjung Colony, Beside R T A Office, Golconda, Hyderabad - 500008",
      "phone": "9885125158",
      "url":"https://www.google.com/maps?cid=17381058730066216617"
    },

    {
      "center": "MeeSeva Center – Hyderguda",
      "address": "3-3-108/B, Chaitanya Villas, Hyderguda, Hyderabad",
      "phone": "9032587042",
      "url":"https://maps.app.goo.gl/fRwZksMcj1Yj9ytJ8"
    },
    {
      "center": "MeeSeva Center – Jawaharnagar",
      "address": "SHOP NO1 1-1-385/A/5, Bheemas residency,  Near Andhra Cafe, Jawaharnagar, Musheerabad, Hyderabad - 500020",
      "phone": "9908586325",
      "url":"https://maps.app.goo.gl/r2n37hnzf2xnn3xm8"
    },
    {
      "center": "MeeSeva Center – Kavuri Hills",
      "address": "Plot.No.515&52, Kavuri Hills,Beside Benz show Room, Hyderabad",
      "phone": "9550841658",
      "url":"https://maps.app.goo.gl/NrVQur4oYyrCqYqX8"
    },
    {
      "center": "MeeSeva Center – Kishan Bagh",
      "address": "Address: 19-5-32/b/a/32 & 33, Beside Sumaiya Masjid, Asad Baba Nagar, Kishan Bagh, Bhadurpura, Hyderabad - 500064",
      "phone": "9959164120",
      "url": "https://www.google.com/maps?cid=4080303542620730689"
    },
    {
      "center": "MeeSeva Center – Langer House",
      "address": "9-1-1/C/25, Ap Xerox Center, Defence Colony, Back Side To Golconda Mandal Office, Langer House, Hyderabad - 500008",
      "phone": "9290011114",
      "url":"https://maps.app.goo.gl/utVXoDV59qfuvf957"
    },
    {
      "center": "MeeSeva Center – Marredpally",
      "address": "PLOT NO.130, Shop No 1, Trimurthy Colony, Opp: Satyanarayanan Temple, Hyderabad - 500026",
      "phone": "9885489170",
      "url":"https://www.google.com/maps?cid=2115890186758132044"
    },
    {
      "center": "MeeSeva Center – Musheerabad",
      "address": "SHOP.NO.5, G.H.M.C Parking Complex, Opposite G.P.O, Abids, Hyderabad - 500001",
      "phone": "9032397589",
      "url":"https://maps.app.goo.gl/P1fYqJH62GB4LJNL8"
    },
    {
      "center": "MeeSeva Center – Nampally",
      "address": "5/8/369/1/A, Sarwar Complex, Chirag Ali Line Abid, Tatasky Office, Nampally, Hyderabad - 500001",
      "phone": "9849584034",
      "url":"https://maps.app.goo.gl/pSecZUFzchMXY9fA6"
    },
    {
      "center": "MeeSeva Center – Nampally",
      "address": "15-5-236/1, Balaji Traders, Osmanshahi, Gowliguda, Nampally, Hyderabad - 500012",
      "phone": "9989369404",
      "url":"https://maps.app.goo.gl/o8tKGspQvWd55THX6"
    },
    {
      "center": "MeeSeva Center – Panjagutta",
      "address": "Shop No:3 B Black Kanthish, Khairtabad, Panjagutta, Hyderabad",
      "phone": "9052926557",
      "url":"https://maps.app.goo.gl/nS8JYq6XvHejggX58"
    },
    {
      "center": "MeeSeva Center – Puranapool",
      "address": "14-10-1284, Sbh Bank Ground Floor, Bus Stop, Puranapool, Hyderabad - 500006",
      "phone": "8374966730",
      "url":"https://www.google.com/maps?cid=10690452772162772235"
    },
    {
      "center": "MeeSeva Center – Saidabad",
      "address": "16-11-20/E/2 Shop 3, Super Good Homes, Saleemnagar Malakpet, Behind Hdfc Bank Near K G H Hospital, Saidabad, Hyderabad - 500036",
      "phone": "9963444004",
      "url":"https://maps.app.goo.gl/5UrhsXUg82kjqkXG6"
    },
    {
      "center": "MeeSeva Center – Somajiguda",
      "address": "6-3-1177 / A / 2, Global Tele World, B S Mutha, Bubha View Epts, Somajiguda, Khairatabad, Hyderabad - 500016",
      "phone": "9949972135",
      "url":"https://maps.app.goo.gl/1rvibi1RsRKMm2xi9"
    },
  ];


  @override
  Widget build(BuildContext context) {
    final fontSize = Provider.of<FontSizeProvider>(context).fontSize;

    final filteredCenters = meesevaCenters.where((center) {
      final address = center["address"]?.toLowerCase() ?? "";
      final centerName = center["center"]?.toLowerCase() ?? "";
      return address.contains(searchText.toLowerCase()) || centerName.contains(searchText.toLowerCase());
    }).toList();

    return Scaffold(
      //backgroundColor: Colors.blue[50],
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: TextField(
              onChanged: (value) => setState(() => searchText = value),
              cursorColor: Colors.blue,
              decoration: InputDecoration(
                hintText: "Search by area",
                prefixIcon: Icon(Icons.search, color: Colors.lightBlue.shade600,),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.lightBlue.shade600, width: 1.0),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),

            ),
          ),
          Expanded(
            child: filteredCenters.isEmpty
                ? Center(child: Text("No results found", style: TextStyle(fontSize: fontSize)))
                : ListView.builder(
              itemCount: filteredCenters.length,
              itemBuilder: (context, index) {
                return MeeSevaCenterCard(center: filteredCenters[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Consumer<FontSizeProvider>(
        builder: (context, fontSizeProvider, child) => Text(
          "MeeSeva Centers",
          style: TextStyle(
            fontSize: fontSizeProvider.fontSize + 2,
            color: Colors.white,
          ),
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: Colors.lightBlue.shade600,  // Set the background color to blue
    );
  }

}

class MeeSevaCenterCard extends StatefulWidget {
  final Map<String, String> center;

  const MeeSevaCenterCard({required this.center});

  @override
  State<MeeSevaCenterCard> createState() => _MeeSevaCenterCardState();
}

class _MeeSevaCenterCardState extends State<MeeSevaCenterCard> {
  final TextToSpeechService ttsService = TextToSpeechService();
  bool isSpeaking = false;

  void _toggleTTS() async {
    if (isSpeaking) {
      await ttsService.stop();
    } else {
      String details =
          "${widget.center["center"]}, located at ${widget.center["address"]}, phone number ${widget.center["phone"]}.";
      await ttsService.speak(details);
    }
    setState(() {
      isSpeaking = !isSpeaking;
    });
  }
  void _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);

    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<FontSizeProvider>(
      builder: (context, fontSizeProvider, _) {
        double fontSize = fontSizeProvider.fontSize;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Card(
            color:Colors.lightBlue.shade50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 6,
            shadowColor: Colors.blueAccent.withOpacity(0.3),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.center["center"]!,
                        style: TextStyle(
                          fontSize: fontSize + 2,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.center["address"]!,
                        style: TextStyle(
                          fontSize: fontSize,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Phone: ${widget.center["phone"]}",
                        style: TextStyle(
                          fontSize: fontSize,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),

                      GestureDetector(
                        onTap: () => _launchUrl(widget.center["url"]!),
                        child: Text(
                          "Location URL: ${widget.center["url"]}",
                          style: TextStyle(
                            fontSize: fontSize,
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      )

                    ],
                  ),
                ),
                Positioned(
                  bottom: 4,
                  right: 8,
                  child: IconButton(
                    icon: Icon(
                      isSpeaking ? Icons.stop : Icons.volume_up,
                      //color: Colors.blue,
                      color: Colors.lightBlue.shade600,
                    ),
                    onPressed: _toggleTTS,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}