



import 'package:frontend/favoritesprovider.dart';
import 'package:frontend/referencespage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'langschemespage.dart';
import 'notifypage.dart';
import 'package:flutter/material.dart';
import 'schemespage.dart';
import 'welcomepage.dart';
import 'package:provider/provider.dart';
import 'fontprovider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'meeseva_centers_page.dart';
import 'developerpage.dart';
import 'profilepage.dart';
import 'favoritesprovider.dart';
import 'favoritespage.dart';
class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool isExpanded = false;
  List<dynamic> deptCounts = [];
  List<dynamic> applicantCounts = [];
  List<dynamic> yearCounts = [];

  bool isLoading = true;
  String? errorMessagefirst, errorMessagesec, errorMessagethird;
  bool flag1=false, flag2=false,flag3=false;
  @override
  void initState() {
    super.initState();
  }

  bool isDeptLoading = false;
  bool isApplicantLoading = false;
  bool isYearLoading = false;

  Future<void> fetchDeptCounts() async {
    setState(() {
      isDeptLoading = true;
      errorMessagefirst = null;
      flag1=false;
    });

    final url = Uri.parse('http://10.0.2.2:8000/getDeptCounts/');
    //print("Yes, Deptentered------------------");

    //final url = Uri.parse('http://172.16.10.200:8000/getDeptCounts/');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          deptCounts = json.decode(response.body);
          print("Yes, Dept FEtched------------------");

          flag1=true;
        });
      } else {
        setState(() {
          errorMessagefirst = 'Failed to load data  \${response.body}';
        });
      }
    } catch (e) {
      setState(() {
        errorMessagefirst = 'Error: \$e';
      });
    } finally {
      setState(() {
        isDeptLoading = false;
      });
    }
  }

  Future<void> fetchApplicantCounts() async {
    setState(() {
      isApplicantLoading = true;
      errorMessagesec = null;
      flag2=false;
    });

    final url = Uri.parse('http://10.0.2.2:8000/getApplicantCounts/');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          applicantCounts = json.decode(response.body);
          print("Yes, Applicant FEtched------------------");

          flag2=true;
        });
      } else {
        setState(() {
          errorMessagesec = 'Failed to load data  \${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        errorMessagesec = 'Error: \$e';
      });
    } finally {
      setState(() {
        isApplicantLoading = false;
      });
    }
  }

  Future<void> fetchYearCounts() async {
    setState(() {
      isYearLoading = true;
      errorMessagethird = null;
      flag3 = false;
    });

    final url = Uri.parse('http://10.0.2.2:8000/getYearCounts/');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          yearCounts = data;
          flag3 = true;  // Set flag3 to true
          print("Year Data Fetched ------------");
        });
      } else {
        setState(() {
          errorMessagethird = 'Failed to load data (Status: \${response.statusCode})';
        });
      }
    } catch (e) {
      setState(() {
        errorMessagethird = 'Error: \$e';
      });
    } finally {
      setState(() {
        isYearLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final fontSize = Provider.of<FontSizeProvider>(context).fontSize;

    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Column(
        children: [
          const SizedBox(height: 5),
          _buildHeader(fontSize),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Row(
                  children: [
                    _buildSidebar(context),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Count of Schemes',

                              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold,color: Colors.lightBlue,),
                            ),
                            const SizedBox(height: 20),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              alignment: WrapAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: fetchDeptCounts,
                                  child: Text("Departments", style: TextStyle(fontSize: fontSize)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.lightBlue.shade600,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: fetchApplicantCounts,
                                  child: Text("Applicants", style: TextStyle(fontSize: fontSize)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.lightBlue.shade600,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: fetchYearCounts,
                                  child: Text("Year", style: TextStyle(fontSize: fontSize)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.lightBlue.shade600,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: constraints.maxHeight * 0.6,
                              child: flag1
                                  ? windowDepartments(fontSize)
                                  : flag2
                                  ? windowApplicants(fontSize)
                                  : flag3
                                  ? windowYear(fontSize)
                              //:Center(child: Text("Select the filter", style: TextStyle(fontSize: fontSize))),
                                  : SizedBox(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }


  Widget windowDepartments(double fontSize) {
    flag1 = false;
    return isDeptLoading
        ? const Center(child: CircularProgressIndicator())
        : errorMessagefirst != null
        ? Center(child: Text(errorMessagefirst!, style: TextStyle(fontSize: fontSize)))
        : _buildDeptCountsList(fontSize);
  }

  Widget windowApplicants(double fontSize) {
    flag2=false;
    return isApplicantLoading
        ? const Center(child: CircularProgressIndicator())
        : errorMessagesec != null
        ? Center(child: Text(errorMessagesec!, style: TextStyle(fontSize: fontSize)))
        : _buildApplicantCountsList(fontSize);
  }

  Widget windowYear(double fontSize) {
    flag3=false;
    return isYearLoading
        ? const Center(child: CircularProgressIndicator())
        : errorMessagethird != null
        ? Center(child: Text(errorMessagethird!, style: TextStyle(fontSize: fontSize)))
        : _buildYearCountsList(fontSize);
  }

  Widget _buildDeptCountsList(double fontSize) {
    return SizedBox(
      height: 300,
      width:300,
      child: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: deptCounts.length,
        itemBuilder: (context, index) {
          final item = deptCounts[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: ListTile(
              title: Text(item['Department'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize)),
              subtitle: Text('No of Schemes: ${item['count']}', style: TextStyle(fontSize: fontSize)),

              //subtitle: Text('No of Schemes: ${item['count']}'),
            ),
          );
        },
      ),
    );
  }

  Widget _buildApplicantCountsList(double fontSize) {
    return SizedBox(
      height: 300,
      width: 300,
      child: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: applicantCounts.length,
        itemBuilder: (context, index) {
          final item = applicantCounts[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: ListTile(
              title: Text(item['Category'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize)),
              //subtitle: Text('No of Schemes: \${item['count']}', style: TextStyle(fontSize: fontSize)),
              subtitle: Text('No of Schemes: ${item['count']}', style: TextStyle(fontSize: fontSize)),
            ),
          );
        },
      ),
    );
  }

  Widget _buildYearCountsList(double fontSize) {
    return SizedBox(
      height: 300,
      width:300,
      child: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: yearCounts.length,
        itemBuilder: (context, index) {
          final item = yearCounts[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: ListTile(
              title: Text(item['Year'].toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize)),
              //subtitle: Text('No of Schemes: \${item['count']}', style: TextStyle(fontSize: fontSize)),
              subtitle: Text('No of Schemes: ${item['count']}', style: TextStyle(fontSize: fontSize)),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(double fontSize) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.lightBlue.shade600,
        boxShadow: [
          BoxShadow(
            color: Colors.lightBlueAccent.withOpacity(0.6),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
          ),
          Expanded(
            child: Center(
              child: Text(
                "Dashboard",
                style: TextStyle(
                  fontSize: fontSize + 6,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

// _buildSidebar, _buildMenuItem, _showFontAdjustDialog, _showLogoutConfirmation, _buildButton remain unchanged

  Widget _buildSidebar(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: isExpanded ? 200 : 60,
      color: Colors.lightBlue.shade600,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment:
        isExpanded ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          // In your _buildSidebar method, add the Profile option:
          _buildMenuItem(context, Icons.account_circle, "Profile", isExpanded, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          }),


          _buildMenuItem(context, Icons.info, "Scheme Details", isExpanded, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SchemesPage()),
            );
          }),


          _buildMenuItem(context, Icons.store_mall_directory, "Meeseva Centers", isExpanded, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MeesevaCentersPage()),
            );
          }),
          _buildMenuItem(context, Icons.notification_add, "Notifications", isExpanded, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NotifyPage()),
            );          }),
          _buildMenuItem(
            context,
            Icons.text_fields,
            "Adjust Font",
            isExpanded,
                () {
              _showFontAdjustDialog(context);
            },
          ),
          _buildMenuItem(context, Icons.favorite_rounded, "Favourite Schemes", isExpanded, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FavoritesPage()),
            );
          }),
          _buildMenuItem(context, Icons.help, "References & Help", isExpanded, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ReferenceLinksPage()),
            );
          }),
          _buildMenuItem(context, Icons.language, "Language Support", isExpanded, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LangSchemesPage()),
            );
          }),
          _buildMenuItem(context, Icons.people, "Developer Connect", isExpanded, () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DeveloperPage()),
            );
          }),

          _buildMenuItem(context, Icons.logout, "Exit", isExpanded, () {
            _showLogoutConfirmation(context);
          }),
        ],
      ),
    );
  }
  Widget _buildMenuItem(
      BuildContext context,
      IconData icon,
      String title,
      bool isExpanded,
      VoidCallback onTap,
      ) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white),
            if (isExpanded) const SizedBox(width: 10),
            if (isExpanded)
              Flexible(
                child: Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showFontAdjustDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0, // Remove default elevation
        backgroundColor:
        Colors.transparent, // Make dialog background transparent
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.lightBlueAccent.withOpacity(
                  0.6,
                ), // Glowing effect
                blurRadius: 15,
                spreadRadius: 5,
              ),
            ],
          ),
          padding: const EdgeInsets.all(20),
          child: Consumer<FontSizeProvider>(
            builder: (context, fontSizeProvider, child) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Adjust Font Size",
                    style: TextStyle(
                      fontSize: fontSizeProvider.fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove, size: 30),
                        onPressed: fontSizeProvider.decreaseFontSize,
                      ),
                      Text(
                        fontSizeProvider.fontSize.toStringAsFixed(0),
                        style: TextStyle(
                          fontSize: fontSizeProvider.fontSize,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.add, size: 30),
                        onPressed: fontSizeProvider.increaseFontSize,
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue.shade600,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("Done"),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.lightBlueAccent.withOpacity(0.6),
                blurRadius: 15,
                spreadRadius: 5,
              ),
            ],
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Confirm Exit",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightBlue,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Are you sure you want to exit?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildButton("Cancel", () => Navigator.pop(context)),
                  _buildButton("Exit", () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.clear();

                    // Reset font size through the provider
                    final fontSizeProvider = Provider.of<FontSizeProvider>(context, listen: false);
                    fontSizeProvider.resetFontSize();

                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const WelcomePage()),
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }



  Widget _buildButton(String text, VoidCallback onPressed) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.lightBlue.shade600,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}

