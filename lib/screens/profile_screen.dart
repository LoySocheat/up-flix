import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = "LOY Socheat";
  String email = "loysocheat.up@gmail.com";
  String phoneNumber = "+855 123456789";
  String dateOfBirth = "January 1, 2002";

  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController birthController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: email);
    phoneController = TextEditingController(text: phoneNumber);
    birthController = TextEditingController(text: dateOfBirth);
  }

  @override
  void dispose() {
    emailController.dispose();
    phoneController.dispose();
    birthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                _showImageChangeDialog();
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.network(
                    'https://cdn.hero.page/pfp/e81f1f48-5dd7-4682-8798-b5d3b5cd4069-mysterious-gentleman-anime-guy-pfp-styles-1.png',
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  const Positioned(
                    top: 100,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/socheat.jpg'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              username,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.email),
                  SizedBox(width: 5),
                  Expanded(
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'Enter email',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.phone),
                  SizedBox(width: 5),
                  Expanded(
                    child: TextField(
                      controller: phoneController,
                      decoration: InputDecoration(
                        hintText: 'Enter phone number',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.calendar_today),
                  SizedBox(width: 5),
                  Expanded(
                    child: TextField(
                      controller: birthController,
                      decoration: InputDecoration(
                        hintText: 'Enter date of birth',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            email = emailController.text;
            phoneNumber = phoneController.text;
            dateOfBirth = birthController.text;
          });
        },
        child: Icon(Icons.save),
      ),
    );
  }

  void _showImageChangeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Change Image'),
          content: Text('This is where you can change your image.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
