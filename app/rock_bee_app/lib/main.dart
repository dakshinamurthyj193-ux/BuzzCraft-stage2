import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';


void main() {
  runApp(RockBeeApp());
}

class RockBeeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  title: 'Rock Bee Monitor',
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    primarySwatch: Colors.brown,
    scaffoldBackgroundColor: Colors.white,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  ),
  home: HomeScreen(),
);

  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rock Bee Colony Monitoring')),
      body: Padding(
  padding: const EdgeInsets.all(24.0),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
     Icon(Icons.hive, size: 80, color: Colors.brown),

      SizedBox(height: 20),
      Text(
        'Rock Bee Colony Monitoring',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 30),
      ElevatedButton(
        child: Text('Report Colony'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ReportScreen()),
          );
        },
      ),
    ],
  ),
),
); 
  }
}

class ReportScreen extends StatefulWidget {
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final TextEditingController locationController = TextEditingController();
  File? _image;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Report Colony')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
    child: Column(
  crossAxisAlignment: CrossAxisAlignment.stretch,
  children: [
    Text(
      'Report Rock Bee Colony',
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
    SizedBox(height: 20),
    TextField(
      controller: locationController,
      decoration: InputDecoration(
        labelText: 'Enter Location',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
    SizedBox(height: 20),
    ElevatedButton.icon(
  icon: Icon(Icons.camera_alt),
  label: Text('Attach Image'),
  onPressed: () async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
    );

    if (image != null) {
  setState(() {
    _image = File(image.path);
  });

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Image attached successfully')),
  );
}

  },
),
if (_image != null) ...[
  const SizedBox(height: 16),
  Image.file(
    _image!,
    height: 150,
    fit: BoxFit.cover,
  ),
],


    SizedBox(height: 20),
    ElevatedButton(
      child: Text('Submit Report'),
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => SuccessScreen()),
        );
      },
    ),
  ],
),

      ),
    );
  }
}

class SuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Success')),
     body: Center(
  child: Padding(
    padding: const EdgeInsets.all(24.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.check_circle, size: 80, color: Colors.green),
        SizedBox(height: 20),
        Text(
          'Report submitted successfully!',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 30),
        ElevatedButton(
          child: Text('Back to Home'),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => HomeScreen()),
              (route) => false,
            );
          },
        ),
      ],
    ),
  ),
)
    );
  }
}