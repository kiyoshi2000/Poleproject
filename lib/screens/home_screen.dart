import 'package:app1/Typewriter.dart';
import 'package:app1/views/camera_view.dart';
import 'package:flutter/material.dart';

//import 'package:app1/screens/camera_screen.dart'; // Import the CameraScreen

import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showButton = false;
  bool _showDialog = true;

  @override
  void initState() {
    super.initState();
    _loadDialogPreference();
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _showButton = true;
      });
    });
  }

  _loadDialogPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool showDialog = (prefs.getBool('showDialog') ?? true);
    setState(() {
      _showDialog = showDialog;
    });
  }

  _updateDialogPreference(bool showDialog) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('showDialog', showDialog);
  }

  void _showTermsOfUseDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        bool _isChecked = false;
        bool _hasScrolledToEnd = false;
        ScrollController _scrollController = ScrollController();

        _scrollController.addListener(() {
          if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {
            setState(() {
              _hasScrolledToEnd = true;
            });
          }
        });

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Terms of Use'),
              content: SingleChildScrollView(
                controller: _scrollController,
                child: ListBody(
                  children: <Widget>[
                    Text(
                      'Last updated: 2021-04-01',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    Text(
                      '1. Acceptance of Terms',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                        'By downloading, accessing, or using the Motion Speech application (“Application”), you agree to be bound by these terms of use (“Terms”). If you do not agree to these Terms, do not use the Application.'),
                    Text(
                      '2. Description of Service',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                        'The Application provides translation of sign language into spoken language and vice versa. It is intended to facilitate communication for deaf and hard-of-hearing individuals. The Application may require internet access and appropriate device capabilities.'),
                    Text(
                      '3. User Responsibilities',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\t •	3.1 Legal Use:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                        'You agree to use the Application only for lawful purposes and in a way that does not infringe the rights of, restrict, or inhibit anyone else\'s use and enjoyment of the Application'),
                    Text(
                      '\t •	3.2 Accurate Information:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                        'You are responsible for ensuring that any information you provide is accurate and up-to-date.'),
                    Text(
                      '\t •	3.3 Security: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                        'You are responsible for maintaining the confidentiality of any login information and are fully responsible for all activities that occur under your account.'), // Closed properly here
                    Text(
                      '4. Intellectual Property',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\t •	4.1 Ownership: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                        'The Application and its original content, features, and functionality are and will remain the exclusive property of Motion Speech and its licensors.'), // Closed properly here
                    Text(
                      '\t •	4.2 Restrictions: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                        'Copying, redistribution, retransmission, publication, or commercial exploitation of downloaded material is strictly prohibited without the express written consent of Motion Speech.'), // Closed properly here
                    Text(
                      '5. Privacy Policy ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                        'Your use of the Application is also governed by the Motion Speech Privacy Policy, which is incorporated herein by reference. '),
                    Text(
                      '6. Disclaimer of Warranties ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                        'The Application is provided “as is” and “as available” without any warranties of any kind, either express or implied, including but not limited to the implied warranties of merchantability, fitness for a particular purpose, or non-infringement.'),
                    Text(
                      '7. Limitation of Liability ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                        'In no event shall Motion Speech, its officers, directors, employees, or agents be liable for any indirect, incidental, special, consequential or punitive damages, or any loss of profits or revenues, whether incurred directly or indirectly, or any loss of data, use, goodwill, or other intangible losses. '),
                    Text(
                      '8. Modification of Terms ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                        'Motion Speech reserves the right to modify these Terms at any time. Your continued use of the Application after such modifications will constitute acknowledgment and agreement of the modified Terms. '),
                    Text(
                      '9. Termination ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                        'Motion Speech may terminate or suspend access to our Application immediately, without prior notice or liability, for any reason whatsoever, including, without limitation, if you breach the Terms. '),
                    Text(
                      '10. Governing Law ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                        'These Terms shall be governed and construed in accordance with the laws of the jurisdiction in which Motion Speech is established, without regard to its conflict of law provisions. '),
                    Text(
                      'Contact Information ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                        'If you have any questions about these Terms, please contact us at motion.speech@inquiries.com.'),

                    CheckboxListTile(
                      title: Text("Don't show again"),
                      value: _isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          _isChecked = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Accept'),
                  onPressed: _hasScrolledToEnd
                      ? () {
                          _updateDialogPreference(_isChecked);
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CameraView()));
                        }
                      : null,
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: Typewriter(
              text: 'Welcome to MotionSpeech',
              duration: Duration(milliseconds: 100),
            ),
          ),
          if (_showButton)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.all(20.0),
                child: ElevatedButton(
                  child: Text(
                    'Start translating',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(primary: Colors.blue),
                  onPressed: () {
                    if (_showDialog) {
                      _showTermsOfUseDialog();
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CameraView()));
                    }
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
