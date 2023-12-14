import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class MyStatefulWidget extends StatefulWidget {
  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  PlatformFile? pickedFile;

  Future uploadFile() async {
    final path = 'files/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    ref.putFile(file);
    print('done........👍👍👍');
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) {
      return;
    }
    setState(() {
      pickedFile = result.files.first;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Picker Example'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              selectFile();
              print('Button 1 pressed');
            },
            child: Text('Select File'),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              uploadFile();
              print('Button 2 pressed');
            },
            child: Text('Button 2'),
          ),
          SizedBox(height: 16),
          // Container for image preview
          pickedFile != null
              ? Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      Text(
                        'Image Preview:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 50),
                      // Display the image preview here
                      Image.file(
                        File(pickedFile!.path!),
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                )
              : Container(), // Empty container if no file is selected
        ],
      ),
    );
  }
}
