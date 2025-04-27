import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'fontprovider.dart';
import 'text_to_speech.dart';

class MeesevaCentersPage extends StatelessWidget {
  final List<Map<String, String>> meesevaCenters = const [

    {
      "center": "MeeSeva Center – Amberpet",
      "address": "HNo:2-2-597/1,BAGH AMBERPET",
      "phone": "9346852582"
    },
    {
      "center": "MeeSeva Center – Amberpet",
      "address": "Sh No. 2 2-1-251, Godhama Mansion (Lahari Apts), Veg Market Road , Opp Hetero Medical Shop, Hyderabad – 500044",
      "phone": "8179796126"
    },
    {
      "center": "MeeSeva Center – Amberpet",
      "address": "2-3-512/A/231, , Chenna Reddy Nagar, Near Sai Baba Temple, Amberpet, Hyderabad - 500013",
      "phone": "8179796126"
    },
    {
      "center": "MeeSeva Center – Asifnagar",
      "address": "12-2-683/3 , Pedda Sathaiah Community Hall, Gudimalkapur, Opp. Veg-Market, Asifnagar, Hyderabad – 500028",
      "phone": "9885117977"
    },
    {
      "center": "MeeSeva Center – Asifnagar",
      "address": "SHOP NO 29, Maheshwari Complex, Masab Tank X Roads, Asifnagar, Hyderabad – 500028",
      "phone": "9390722333"
    },
    {
      "center": "MeeSeva Center – Banjara Hills",
      "address": "Shop.No.8-2-268/2, Road.No.2, Near TV Office, Opp:Axis Bank, Banjara Hills, Hyderabad",
      "phone": "9949107511"
    },
    {
      "center": "MeeSeva Center – Bapuji Nagar",
      "address": "H.No.1-6-202/8/19/2/A, Bapuji Nagar, Parsigutta Road, Musheerabad, Hyderabad",
      "phone": "8143000098"
    },
    {
      "center": "MeeSeva Center – Bhadurpura",
      "address": "20-4-194/7/14/27, New Road Shah Ali Banda, Near Gowtham School, Opp Dargah, Bhadurpura, Hyderabad - 500002",
      "phone": "9030988809"
    },
    {
      "center": "MeeSeva Center – Bhadurpura",
      "address": "22-2-431/3, Cool Point, Noor Khan Bazar, Opp sambritishschool, Near lalmitti Ki Darga, Bhadurpura, Hyderabad - 500024",
      "phone": "9014163923"
    },
    {
      "center": "MeeSeva Center – Chandrayangutta",
      "address": "18-13-132-I / 30 / A, Anmol Garden, Bandlaguda, Chandrayangutta, Hyderabad – 500005",
      "phone": "9700318930"
    },
    {
      "center": "MeeSeva Center – Charminar",
      "address": "22-6-1042 , Balaji Complex, Charminar, Kalikaman, Hyderabad – 500002",
      "phone": "9346453393"
    },
    {
      "center": "MeeSeva Center – Gaddiannaram",
      "address": "16-2-740/58, Icon Home, Kalyana Nagar, Near Municipal Park, Gaddiannaram, Saidabad, Hyderabad - 500060",
      "phone": "9849437448"
    },
    {
      "center": "MeeSeva Center – Golconda",
      "address": "9-4-86/38/1, Midland Cafe, Salarjung Colony, Beside R T A Office, Golconda, Hyderabad - 500008",
      "phone": "9885125158"
    },

    {
      "center": "MeeSeva Center – Hyderguda",
      "address": "3-3-108/B, Chaitanya Villas, Hyderguda, Hyderabad",
      "phone": "9032587042"
    },
    {
      "center": "MeeSeva Center – Jawaharnagar",
      "address": "SHOP NO1 1-1-385/A/5, Bheemas residency,  Near Andhra Cafe, Jawaharnagar, Musheerabad, Hyderabad - 500020",
      "phone": "9908586325"
    },
    {
      "center": "MeeSeva Center – Kavuri Hills",
      "address": "Plot.No.515&52, Kavuri Hills,Beside Benz show Room, Hyderabad",
      "phone": "9550841658"
    },
    {
      "center": "MeeSeva Center – Kishan Bagh",
      "address": "Address: 19-5-32/b/a/32 & 33, Beside Sumaiya Masjid, Asad Baba Nagar, Kishan Bagh, Bhadurpura, Hyderabad - 500064",
      "phone": "9959164120"
    },
    {
      "center": "MeeSeva Center – Langer House",
      "address": "9-1-1/C/25, Ap Xerox Center, Defence Colony, Back Side To Golconda Mandal Office, Langer House, Hyderabad - 500008",
      "phone": "9290011114"
    },
    {
      "center": "MeeSeva Center – Marredpally",
      "address": "PLOT NO.130, Shop No 1, Trimurthy Colony, Opp: Satyanarayanan Temple, Hyderabad - 500026",
      "phone": "9885489170"
    },
    {
      "center": "MeeSeva Center – Musheerabad",
      "address": "SHOP.NO.5, G.H.M.C Parking Complex, Opposite G.P.O, Abids, Hyderabad - 500001",
      "phone": "9032397589"
    },
    {
      "center": "MeeSeva Center – Nampally",
      "address": "5/8/369/1/A, Sarwar Complex, Chirag Ali Line Abid, Tatasky Office, Nampally, Hyderabad - 500001",
      "phone": "9849584034"
    },
    {
      "center": "MeeSeva Center – Nampally",
      "address": "15-5-236/1, Balaji Traders, Osmanshahi, Gowliguda, Nampally, Hyderabad - 500012",
      "phone": "9989369404"
    },
    {
      "center": "MeeSeva Center – Panjagutta",
      "address": "Shop No:3 B Black Kanthish, Khairtabad, Panjagutta, Hyderabad",
      "phone": "9052926557"
    },
    {
      "center": "MeeSeva Center – Puranapool",
      "address": "14-10-1284, Sbh Bank Ground Floor, Bus Stop, Puranapool, Hyderabad - 500006",
      "phone": "8374966730"
    },
    {
      "center": "MeeSeva Center – Saidabad",
      "address": "16-11-20/E/2 Shop 3, Super Good Homes, Saleemnagar Malakpet, Behind Hdfc Bank Near K G H Hospital, Saidabad, Hyderabad - 500036",
      "phone": "9963444004"
    },
    {
      "center": "MeeSeva Center – Somajiguda",
      "address": "6-3-1177 / A / 2, Global Tele World, B S Mutha, Bubha View Epts, Somajiguda, Khairatabad, Hyderabad - 500016",
      "phone": "9949972135"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: ListView.builder(
        itemCount: meesevaCenters.length,
        itemBuilder: (context, index) {
          return MeeSevaCenterCard(center: meesevaCenters[index]);
        },
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
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1976D2), Color(0xFF2196F3)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
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

  @override
  Widget build(BuildContext context) {
    return Consumer<FontSizeProvider>(
      builder: (context, fontSizeProvider, _) {
        double fontSize = fontSizeProvider.fontSize;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Card(
            color: Colors.lightBlue.shade50,
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
                    ],
                  ),
                ),
                Positioned(
                  bottom: 4,
                  right: 8,
                  child: IconButton(
                    icon: Icon(
                      isSpeaking ? Icons.stop : Icons.volume_up,
                      color: Colors.blueAccent,
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