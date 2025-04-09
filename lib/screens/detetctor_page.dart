import 'dart:io';

import 'package:agrisense/apis/api_service_tf.dart';
import 'package:easy_localization/easy_localization.dart'; // Import easy_localization
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DetetctorPage extends StatefulWidget {
  const DetetctorPage({super.key});

  @override
  State<DetetctorPage> createState() => _DetetctorPageState();
}

class _DetetctorPageState extends State<DetetctorPage> {
  File? _image;
  String? _result;
  double? _confidence;
  bool _isLoading = false;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        _image = File(picked.path);
        _isLoading = true;
        _result = null;
        _confidence = null;
      });

      final response = await ApiService.predictDisease(_image!);

      setState(() {
        _result = response['class'];
        _confidence = response['confidence'];
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('detectorPageTitle'.tr()), // Translate
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            if (_image != null)
              Image.file(_image!, height: 250)
            else
              Container(
                height: 250,
                width: double.infinity,
                color: Colors.grey[200],
                child: Center(child: Text("noImageSelected".tr())), // Translate
              ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.image),
              label: Text("pickImageButton".tr()), // Translate
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            if (_isLoading)
              const CircularProgressIndicator()
            else if (_result != null)
              Column(
                children: [
                  Text(
                    "${'predictionLabel'.tr()} $_result", // Translate
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${'confidenceLabel'.tr()} ${_confidence?.toStringAsFixed(2)}%", // Translate
                    style: const TextStyle(fontSize: 16),
                  ),
                  if (_result == "Strawberry___Leaf_scorch")
                    Column(
                      children: [
                        Text(
                          "suggestionsLabel".tr(), // Translate
                          style: const TextStyle(fontSize: 24, color: Colors.black),
                        ),
                        Text(
                          "suggestionStrawberryLeafScorch".tr(), // Translate
                          style: const TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  if (_result == "Apple___Apple_scab")
                    Column(
                      children: [
                        Text(
                          "suggestionsLabel".tr(), // Translate
                          style: const TextStyle(fontSize: 24, color: Colors.black),
                        ),
                        Text(
                          "suggestionAppleScab".tr(), // Translate
                          style: const TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  if (_result == "Peach___Bacterial_spot")
                    Column(
                      children: [
                        Text(
                          "suggestionsLabel".tr(), // Translate
                          style: const TextStyle(fontSize: 24, color: Colors.black),
                        ),
                        Text(
                          "suggestionPeachBacterialSpot".tr(), // Translate
                          style: const TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
