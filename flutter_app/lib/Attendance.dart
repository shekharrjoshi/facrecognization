import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/Service.dart';
import 'package:flutter_app/widgets/Appbar.dart';
import 'package:geolocator/geolocator.dart';

class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  File? _image1;
  String name = '';
  Position? position;
  bool isLoading = true;

  Future getImage() async {
    var image = await captureImage();
    setState(() {
      _image1 = image;
    });
    final storedData = await load();
    String result = await compareImages(_image1, File(storedData['image']));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result)),
    );
    setState(() {
      name = storedData['name'];
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation().then((currLoc) {
      load().then((value) {
        if (value != null) {
          if (value['latitude'] == currLoc.latitude &&
              value['longitude'] == currLoc.longitude) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('Currently you are not in office premises.')),
            );
            return;
          } else {
            setState(() => position = currLoc);
          }
        }
      });
    }).catchError((err) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(err.toString())));
    }).whenComplete(() => setState(() => isLoading = false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
          title: Text(
            'Attendace',
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back))),
      body: isLoading ? Center(child: CircularProgressIndicator()) : Container(
        padding: EdgeInsets.all(20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _image1 != null ? Divider() : Container(),
              _image1 != null
                  ? Image.file(
                      _image1!,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2,
                    )
                  : Container(),
              _image1 != null ? Divider() : Container(),
              Text(
                name,
                style: TextStyle(fontSize: 24),
              ),
              ElevatedButton(
                onPressed: position != null ? () => getImage() : null,
                child: Text('Sign In'),
              ),
            ]),
      ),
    );
  }
}
