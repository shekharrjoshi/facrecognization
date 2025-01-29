import 'dart:convert';
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';


Future<void> save(String name, File? _image1) async {
  final position = await getCurrentLocation();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = {'name': name, 'image': _image1!.path, 'latitude': position.latitude, 'longitude': position.longitude};
    await prefs.setString('data', json.encode(data));
  }

  Future<dynamic> load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('data');
    if (data != null) {
      final decodedData = json.decode(data);
      return decodedData;
    }else{
      return null;
    }
  }

  Future<File> captureImage() async {
      final ImagePicker _picker = ImagePicker();
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }else{
      return File('');
    }
  }

  Future compareImages(File? image1,  File? image2) async {
    if (image1 != null && image2 != null) {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://3.110.44.135:5000/compare'),
      );
      request.files.add(await http.MultipartFile.fromPath(
        'image1',
        image1.path,
        contentType: MediaType('image', 'jpeg'), // Explicitly specify MIME type
      ));
      request.files.add(await http.MultipartFile.fromPath(
        'image2',
        image2.path,
        contentType: MediaType('image', 'jpeg'), // Explicitly specify MIME type
      ));
      var res = await request.send();
      var responseData = await res.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      var responseJson = json.decode(responseString);
      if (responseJson.containsKey('match')) {
        return responseJson['match']?'Images match!':'Images do not match.';
        
      } else {
        return responseJson['error'];
      }
    }
  }

  Future<Position> getCurrentLocation() async {
    // Check permissions
    if (await Permission.location.request().isGranted) {
      // Get the current location
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      return position;
      
    } else {
      throw Exception('Location permission not granted');
    }
  }