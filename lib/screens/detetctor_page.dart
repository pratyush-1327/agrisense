import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:agrisense/apis/api_service_tf.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DetetctorPage extends StatefulWidget {
  DetetctorPage({super.key});

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
        title: Text('plant_disease_detector'.tr()),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (_image != null)
                Image.file(_image!, height: 250)
              else
                Container(
                  height: 250,
                  width: double.infinity,
                  color: Colors.grey[200],
                  child: Center(child: Text("noImageSelectedDetector".tr())),
                ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: Icon(Icons.image),
                label: Text("pickImageDetector".tr()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              if (_isLoading)
                CircularProgressIndicator()
              else if (_result != null)
                Column(
                  children: [
                    Text(
                      "Prediction: $_result",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Confidence: ${_confidence?.toStringAsFixed(2)}%",
                      style: TextStyle(fontSize: 16),
                    ),
                    if (_result == "Strawberry___Leaf_scorch")
                      Column(
                        children: [
                          Text(
                            "suggestionTitle".tr(),
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ),
                          Text(
                            "suggestionStrawberryLeafScorchText".tr(),
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    if (_result == "Apple___Apple_scab")
                      Column(
                        children: [
                          Text(
                            "suggestionTitle".tr(),
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ),
                          Text(
                            "suggestionAppleScabText".tr(),
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    if (_result == "Peach___Bacterial_spot")
                      Column(
                        children: [
                          Text(
                            "suggestionTitle".tr(),
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ),
                          Text(
                            "suggestionPeachBacterialSpotText".tr(),
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    if (_result == "Apple___Black_rot")
                      Column(
                        children: [
                          Text(
                            "suggestionTitle".tr(),
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ),
                          Text(
                            "suggestionAppleBlackRotText".tr(),
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    if (_result == "Apple___Cedar_apple_rust")
                      Column(
                        children: [
                          Text(
                            "suggestionTitle".tr(),
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ),
                          Text(
                            "suggestionAppleCedarAppleRustText".tr(),
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    if (_result == "Apple___healthy")
                      Column(
                        children: [
                          Text(
                            "suggestionTitle".tr(),
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ),
                          Text(
                            "suggestionAppleHealthyText".tr(),
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    if (_result == "Blueberry___healthy")
                      Column(
                        children: [
                          Text(
                            "suggestionTitle".tr(),
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ),
                          Text(
                            "suggestionBlueberryHealthyText".tr(),
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    if (_result == "Cherry_(including_sour)___Powdery_mildew")
                      Column(
                        children: [
                          Text(
                            "suggestionTitle".tr(),
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ),
                          Text(
                            "suggestionCherryPowderyMildewText".tr(),
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    if (_result == "Cherry_(including_sour)___healthy")
                      Column(
                        children: [
                          Text(
                            "suggestionTitle".tr(),
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ),
                          Text(
                            "suggestionCherryHealthyText".tr(),
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    if (_result ==
                        "Corn_(maize)___Cercospora_leaf_spot Gray_leaf_spot")
                      Column(
                        children: [
                          Text(
                            "suggestionTitle".tr(),
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ),
                          Text(
                            "suggestionCornCercosporaLeafSpot".tr(),
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    if (_result == "Corn_(maize)___Common_rust_")
                      Column(
                        children: [
                          Text(
                            "suggestionTitle".tr(),
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ),
                          Text(
                            "suggestionCornCommonRust".tr(),
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    if (_result == "Corn_(maize)___Northern_Leaf_Blight")
                      Column(
                        children: [
                          Text(
                            "suggestionTitle".tr(),
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ),
                          Text(
                            "suggestionCornNorthernLeafBlight".tr(),
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    if (_result == "Corn_(maize)___healthy")
                      Column(
                        children: [
                          Text(
                            "suggestionTitle".tr(),
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ),
                          Text(
                            "health".tr(),
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    if (_result == "Grape___Black_rot")
                      Column(
                        children: [
                          Text(
                            "suggestionTitle".tr(),
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ),
                          Text(
                            "suggestionGrapeBlackRot".tr(),
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    if (_result == "Grape___Esca_(Black_Measles)")
                      Column(
                        children: [
                          Text(
                            "suggestionTitle".tr(),
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ),
                          Text(
                            "suggestionGrapeEsca".tr(),
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    if (_result == "Grape___Leaf_blight_(Isariopsis_Leaf_Spot)")
                      Column(
                        children: [
                          Text(
                            "suggestionTitle".tr(),
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ),
                          Text(
                            "suggestionGrapeLeafBlight".tr(),
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    if (_result == "Grape___healthy")
                      Column(
                        children: [
                          Text(
                            "suggestionTitle".tr(),
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ),
                          Text(
                            "health".tr(),
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    if (_result == "Orange___Haunglongbing_(Citrus_greening)")
                      Column(
                        children: [
                          Text(
                            "suggestionTitle".tr(),
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ),
                          Text(
                            "suggestionOrangeHaunglongbing".tr(),
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    if (_result == "Peach___healthy")
                      Column(
                        children: [
                          Text(
                            "suggestionTitle".tr(),
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ),
                          Text(
                            "health".tr(),
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    if (_result == "Pepper,_bell___Bacterial_spot")
                      Column(
                        children: [
                          Text(
                            "suggestionTitle".tr(),
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ),
                          Text(
                            "suggestionPepperBacterialSpot".tr(),
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    if (_result == "Pepper,_bell___healthy")
                      Column(
                        children: [
                          Text(
                            "suggestionTitle".tr(),
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ),
                          Text(
                            "health".tr(),
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    if (_result == "Potato___Early_blight")
                      Column(
                        children: [
                          Text(
                            "suggestionTitle".tr(),
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ),
                          Text(
                            "suggestionPotatoEarlyBlight".tr(),
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    if (_result == "Potato___Late_blight")
                      Column(
                        children: [
                          Text(
                            "suggestionTitle".tr(),
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ),
                          Text(
                            "suggestionPotatoLateBlight".tr(),
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    if (_result == "Potato___healthy")
                      Column(
                        children: [
                          Text(
                            "suggestionTitle".tr(),
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ),
                          Text(
                            "health".tr(),
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    if (_result == "Raspberry___healthy")
                      Column(
                        children: [
                          Text(
                            "suggestionTitle".tr(),
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ),
                          Text(
                            "health".tr(),
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    if (_result == "Soybean___healthy")
                      Column(
                        children: [
                          Text(
                            "suggestionTitle".tr(),
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ),
                          Text(
                            "health".tr(),
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    if (_result == "Squash___Powdery_mildew")
                      Column(
                        children: [
                          Text(
                            "suggestionTitle".tr(),
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ),
                          Text(
                            "suggestionSquashPowderyMildew".tr(),
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    if (_result == "Strawberry___healthy")
                      Column(
                        children: [
                          Text(
                            "suggestionTitle".tr(),
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ),
                          Text(
                            "health".tr(),
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    if (_result == "Tomato___Bacterial_spot")
                      Column(
                        children: [
                          Text(
                            "suggestionTitle".tr(),
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ),
                          Text(
                            "suggestionTomatoBacterialSpot".tr(),
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    if (_result == "Tomato___Early_blight")
                      Column(
                        children: [
                          Text(
                            "suggestionTitle".tr(),
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ),
                          Text(
                            "suggestionTomatoEarlyBlight".tr(),
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    if (_result == "Tomato___Late_blight")
                      Column(
                        children: [
                          Text(
                            "suggestionTitle".tr(),
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ),
                          Text(
                            "suggestionTomatoLateBlight".tr(),
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    if (_result == "Tomato___Leaf_Mold")
                      Column(
                        children: [
                          Text(
                            "suggestionTitle".tr(),
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ),
                          Text(
                            "suggestionTomatoLeafMold".tr(),
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    if (_result == "Tomato___Septoria_leaf_spot")
                      Column(
                        children: [
                          Text(
                            "suggestionTitle".tr(),
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ),
                          Text(
                            "suggestionTomatoSeptoriaLeafSpot".tr(),
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    if (_result ==
                        "Tomato___Spider_mites Two-spotted_spider_mite")
                      Column(
                        children: [
                          Text(
                            "suggestionTitle".tr(),
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ),
                          Text(
                            "suggestionTomatoSpiderMites".tr(),
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    if (_result == "Tomato___Target_Spot")
                      Column(
                        children: [
                          Text(
                            "suggestionTitle".tr(),
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ),
                          Text(
                            "suggestionTomatoTargetSpot".tr(),
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    if (_result == "Tomato___Tomato_Yellow_Leaf_Curl_Virus")
                      Column(
                        children: [
                          Text(
                            "suggestionTitle".tr(),
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ),
                          Text(
                            "suggestionTomatoYellowLeafCurlVirus".tr(),
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    if (_result == "Tomato___Tomato_mosaic_virus")
                      Column(
                        children: [
                          Text(
                            "suggestionTitle".tr(),
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ),
                          Text(
                            "suggestionTomatoMosaicVirus".tr(),
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    if (_result == "Tomato___healthy")
                      Column(
                        children: [
                          Text(
                            "suggestionTitle".tr(),
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ),
                          Text(
                            "health".tr(),
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
