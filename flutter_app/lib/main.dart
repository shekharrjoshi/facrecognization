import 'package:flutter/material.dart';
import 'package:flutter_app/Attendance.dart';
import 'package:flutter_app/Registraion.dart';
import 'package:flutter_app/Theme.dart';
import 'package:flutter_app/widgets/Appbar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: PhotoComparePage(),
    );
  }
}

class PhotoComparePage extends StatefulWidget {
  @override
  _PhotoComparePageState createState() => _PhotoComparePageState();
}

class _PhotoComparePageState extends State<PhotoComparePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Appbar(
          title: Text(
            'Attendace',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Attendance'),
              SizedBox(height:100),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Registration()),
                  );
                },
                child: Text('Registration'),
              ),
              SizedBox(height:30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Attendance()),
                  );
                },
                child: Text('Mark Attendance'),
              ),
              
            ],
          ),
        ));
  }
}
