import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/Service.dart';
import 'package:flutter_app/widgets/Appbar.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController _nameController = TextEditingController();
  File? _image1;

  Future getImage() async {
    var image = await captureImage();
    setState(() {
      _image1 = image;
    });
  }

  Future register() async {
    await save(_nameController.text, _image1);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        title: Text('Registration',style: TextStyle(color: Colors.white),),
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Register Employee',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 40),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => getImage(),
              child: Text('Capture Image'),
            ),
            _image1 != null
              ? Column(
                children: [
                  Image.file(
                      _image1!,
                       width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/2.2,
                    ),
                    Divider(),
              ElevatedButton(
              onPressed: () => register(),
              child: Text('Register'),
            ),
                ],
              )
              : Container(),
              
          ]),
      ),
    );
  }
}