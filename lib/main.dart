import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Test()

    );
  }
}

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  FilePickerResult?  pickedFile;
  String? nameFile;

  void pickDocument() async {
    pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );

    print('file select $pickedFile');
    print(p.extension(pickedFile?.files.first.name as String));
    print(pickedFile?.files.first.name);
    nameFile=pickedFile?.files.first.name as String;
    final extension = pickedFile?.files.first.path ?.split(".").last;
    print('extension $extension') ;
  }
  //final FirebaseStorage storage = FirebaseStorage.instance;

  void uploadFile() async {
    if (pickedFile != null) {
      Uint8List? fileBytes = pickedFile?.files.first.bytes;
      String? fileName = pickedFile?.files.first.name;

      // Upload file
      //await FirebaseStorage.instance.ref('uploads/$fileName').putData(fileBytes!);
    }
    /*Reference ref = storage.ref().child(pickedFile?.paths as String);
      UploadTask uploadTask = ref.putFile(pickedFile);
      TaskSnapshot taskSnapshot = await uploadTask.onComplete;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      print('File Uploaded! Download Link: $downloadUrl');*/
  }
  @override
  Widget build(BuildContext context) {

    return Container(
      child:  ElevatedButton(
          onPressed: (){
            pickDocument();
            setState((){});
          },
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 200,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xff7c94b6),
                  image:  DecorationImage(
                    image: FileImage(pickedFile != null ? File(pickedFile?.files.first.path as String) : File('/data/user/0/com.example.document_picker/cache/file_picker/iStock_000063634661_Large.jpg')),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Text(pickedFile!=null ? pickedFile?.files.first.name as String :'here') ,
              ),
              Container(
                child: Text(pickedFile!=null ? pickedFile?.files.first.name as String :'......',
                  style: const TextStyle(fontSize: 16, color: Colors.red),),
              )
            ],
          )

      ),
    );
  }
}


