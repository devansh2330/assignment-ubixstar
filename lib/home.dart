import 'dart:io';

import 'package:assignment_ubixstar/constants.dart';
import 'package:assignment_ubixstar/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controllerName = TextEditingController();
  File? selectedImage;

  String imageUrl = '';
  void saveButtonUsed() async {
    if (selected[0] == false && selected[1] == false) {
      messageBox = !messageBox;
      return;
    }

    String itemName = _controllerName.text;

    //Create a Map of data
    Map<String, String> dataToSend = {
      'text': itemName,
      'image': imageUrl,
    };

    //Add a new item
    FirebaseFirestore.instance.collection('ubixstar').add(dataToSend);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Data updated successfully!'),
        backgroundColor: Colors.green[200],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          title: const Text(
            'Assignment App',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(
                      color: Colors.white,
                      width: 10,
                    )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: selected[0],
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: const BoxDecoration(color: Colors.grey),
                        child: TextField(
                          controller: _controllerName,
                          cursorColor: Colors.grey,
                          decoration:
                              const InputDecoration(hintText: 'Enter Text'),
                          style: const TextStyle(fontSize: 25),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: selected[1],
                      child: GestureDetector(
                        child: Container(
                          alignment: Alignment.center,
                          height: 250,
                          width: double.infinity,
                          decoration: const BoxDecoration(color: Colors.grey),
                          child: selectedImage != null
                              ? Image.file(selectedImage!)
                              : const Text(
                                  'Upload Image',
                                  style: TextStyle(fontSize: 25),
                                ),
                        ),
                        onTap: () async {
                          ImagePicker imagePicker = ImagePicker();
                          XFile? file = await imagePicker.pickImage(
                              source: ImageSource.camera);
                          print('${file?.path} hii');
                          if (file == null) return;
                          setState(() {
                            selectedImage = File(file.path);
                          });

                          String uniqueFileName =
                              DateTime.now().microsecondsSinceEpoch.toString();

                          Reference referenceRoot =
                              FirebaseStorage.instance.ref();
                          Reference referenceDirImages =
                              referenceRoot.child('images');

                          Reference referenceImageToUpload =
                              referenceDirImages.child(uniqueFileName);

                          try {
                            await referenceImageToUpload
                                .putFile(File(file.path));
                            imageUrl =
                                await referenceImageToUpload.getDownloadURL();
                            print('url for image: $imageUrl');
                          } catch (error) {
                            print('error ');
                          }
                        },
                      ),
                    ),
                    Visibility(
                      visible: messageBox,
                      child: Container(
                        child: selected[0] == false &&
                                selected[1] == false &&
                                selected[2] == false
                            ? Text(none, style: const TextStyle(fontSize: 25))
                            : (selected[0] == false &&
                                    selected[1] == false &&
                                    selected[2] == true
                                ? Text(saveOnly,
                                    style: const TextStyle(fontSize: 25))
                                : const Text('')),
                      ),
                    ),
                    Visibility(
                      visible: selected[2],
                      child: GestureDetector(
                        child: Container(
                          height: 40,
                          width: 70,
                          decoration: BoxDecoration(
                              color: Colors.green[200],
                              border: Border.all(
                                color: Colors.black,
                              )),
                          alignment: Alignment.center,
                          child: const Text('Save'),
                        ),
                        onTap: () async {
                          setState(() {
                            saveButtonUsed();
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              child: Container(
                height: 40,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.green[200],
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.black,
                    )),
                alignment: Alignment.center,
                child: const Text('Add Widgets'),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ImportWidgetWindow(),
                  ),
                );
              },
            )
          ],
        ));
  }
}
