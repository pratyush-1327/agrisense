import 'dart:io';

import 'package:agrisense/apis/api_service_tf.dart';
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
        title: const Text('🌿 Plant Disease Detector'),
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
                child: const Center(child: Text("No image selected")),
              ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.image),
              label: const Text("Pick Image"),
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
                    "Prediction: $_result",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Confidence: ${_confidence?.toStringAsFixed(2)}%",
                    style: const TextStyle(fontSize: 16),
                  ),
                  if (_result == "Strawberry___Leaf_scorch")
                    Column(
                      children: [
                        const Text(
                          "Suggestions :",
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                        const Text(
                          " 🍓 Use resistant strawberry varieties like 'Earliglow' or 'Surecrop' to reduce the risk of infection.\n ✂️ Remove and destroy infected leaves as soon as symptoms (purple or dark brown spots, scorched edges) appear to stop spread.\n 🌧️ Avoid overhead watering; use drip irrigation to prevent moisture buildup on leaves.\n",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  if (_result == "Apple___Apple_scab")
                    Column(
                      children: [
                        const Text(
                          "Suggestions :",
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                        const Text(
                          " 🍎 Remove galls from infected cedar trees within a 5-mile radius during late fall or early spring to reduce spore dispersal.\n 🌳 Prune infected apple branches to remove visible signs of the disease.\n 🍄 Apply fungicide treatments containing myclobutanil or propiconazole during early stages of infection, following label instructions.\n",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  if (_result == "Peach___Bacterial_spot")
                    Column(
                      children: [
                        const Text(
                          "Suggestions :",
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                        const Text(
                          " 🍑 Prune infected branches during dormancy to remove sources of bacteria.\n 🍂 Rake and destroy fallen leaves to reduce overwintering inoculum.\n 🚿 Apply copper-based bactericides in early spring before bud break, following label instructions.\n",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  if (_result == "Apple___Black_rot")
                    Column(
                      children: [
                        const Text(
                          "Suggestions :",
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                        const Text(
                          " 🍎 Prune and destroy infected branches and mummified fruit to reduce fungal inoculum.\n 🍂 Rake and remove fallen leaves to eliminate overwintering sites for the fungus.\n 🍄 Apply fungicide treatments containing captan or mancozeb during early stages of infection, following label instructions.\n",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  if (_result == "Apple___Cedar_apple_rust")
                    Column(
                      children: [
                        const Text(
                          "Suggestions :",
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                        const Text(
                          " 🍎 Remove galls from infected cedar trees within a 5-mile radius during late fall or early spring to reduce spore dispersal.\n 🌳 Prune infected apple branches to remove visible signs of the disease.\n 🍄 Apply fungicide treatments containing myclobutanil or propiconazole during early stages of infection, following label instructions.\n",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  if (_result == "Apple___healthy")
                    Column(
                      children: [
                        const Text(
                          "Suggestions :",
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                        const Text(
                          " 🍎 Maintain tree vigor through proper watering, fertilization, and pruning practices.\n 🐛 Monitor for pests and diseases regularly, and implement appropriate control measures when necessary.\n 🍂 Remove fallen leaves and debris from around the base of the tree to reduce overwintering sites for pathogens.\n",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  if (_result == "Blueberry___healthy")
                    Column(
                      children: [
                        const Text(
                          "Suggestions :",
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                        const Text(
                          " 🫐 Ensure proper soil drainage and pH levels suitable for blueberry growth.\n 💧 Water plants regularly, especially during dry periods, to maintain adequate soil moisture.\n 🌿 Prune bushes annually to remove dead, damaged, or diseased wood and promote air circulation.\n",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  if (_result == "Cherry_(including_sour)___Powdery_mildew")
                    Column(
                      children: [
                        const Text(
                          "Suggestions :",
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                        const Text(
                          " 🍒 Prune trees to improve air circulation and reduce humidity within the canopy.\n 🚿 Avoid overhead watering to minimize leaf wetness and humidity.\n 🍄 Apply fungicide treatments containing sulfur or copper-based compounds during early stages of infection, following label instructions.\n",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  if (_result == "Cherry_(including_sour)___healthy")
                    Column(
                      children: [
                        const Text(
                          "Suggestions :",
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                        const Text(
                          " 🍒 Maintain tree vigor through proper watering, fertilization, and pruning practices.\n 🐛 Monitor for pests and diseases regularly, and implement appropriate control measures when necessary.\n 🍂 Remove fallen leaves and debris from around the base of the tree to reduce overwintering sites for pathogens.\n",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  if (_result == "Corn_(maize)___Cercospora_leaf_spot Gray_leaf_spot")
                    Column(
                      children: [
                        const Text(
                          "Suggestions :",
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                        const Text(
                          " 🌽 Select resistant corn hybrids to reduce susceptibility to Cercospora leaf spot.\n 🔄 Rotate crops with non-host plants to break the disease cycle.\n 🍄 Apply fungicide treatments containing strobilurins or triazoles during early stages of infection, following label instructions.\n",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  if (_result == "Corn_(maize)___Common_rust_")
                    Column(
                      children: [
                        const Text(
                          "Suggestions :",
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                        const Text(
                          " 🌽 Plant resistant corn hybrids to minimize rust development.\n 🔄 Rotate crops with non-host plants to reduce rust inoculum levels.\n 🍄 Apply fungicide treatments containing strobilurins or triazoles during early stages of infection, following label instructions.\n",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  if (_result == "Corn_(maize)___Northern_Leaf_Blight")
                    Column(
                      children: [
                        const Text(
                          "Suggestions :",
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                        const Text(
                          " 🌽 Choose resistant corn hybrids to reduce disease severity.\n 🔄 Rotate crops with non-host plants to break the disease cycle.\n 🍄 Apply fungicide treatments containing strobilurins or triazoles during early stages of infection, following label instructions.\n",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  if (_result == "Corn_(maize)___healthy")
                    Column(
                      children: [
                        const Text(
                          "Suggestions :",
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                        const Text(
                          " 🌽 Ensure proper soil fertility and drainage to promote healthy plant growth.\n 💧 Water plants regularly, especially during critical growth stages, to prevent moisture stress.\n 🌿 Monitor for pests and diseases regularly, and implement appropriate control measures when necessary.\n",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  if (_result == "Grape___Black_rot")
                    Column(
                      children: [
                        const Text(
                          "Suggestions :",
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                        const Text(
                          " 🍇 Prune and destroy infected canes and mummified fruit to reduce fungal inoculum.\n 🍂 Rake and remove fallen leaves to eliminate overwintering sites for the fungus.\n 🍄 Apply fungicide treatments containing captan or mancozeb during early stages of infection, following label instructions.\n",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  if (_result == "Grape___Esca_(Black_Measles)")
                    Column(
                      children: [
                        const Text(
                          "Suggestions :",
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                        const Text(
                          " 🍇 Prune infected cordons and trunks to remove diseased wood.\n 🐛 Protect pruning wounds with wound protectants to prevent fungal infection.\n 🌿 Maintain vine vigor through proper watering, fertilization, and soil management practices.\n",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  if (_result == "Grape___Leaf_blight_(Isariopsis_Leaf_Spot)")
                    Column(
                      children: [
                        const Text(
                          "Suggestions :",
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                        const Text(
                          " 🍇 Prune and destroy infected leaves and canes to reduce fungal inoculum.\n 🚿 Avoid overhead watering to minimize leaf wetness and humidity.\n 🍄 Apply fungicide treatments containing copper-based compounds during early stages of infection, following label instructions.\n",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  if (_result == "Grape___healthy")
                    Column(
                      children: [
                        const Text(
                          "Suggestions :",
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                        const Text(
                          " 🍇 Ensure proper soil drainage and pH levels suitable for grape growth.\n 💧 Water plants regularly, especially during dry periods, to maintain adequate soil moisture.\n 🌿 Prune vines annually to remove dead, damaged, or diseased wood and promote air circulation.\n",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  if (_result == "Orange___Haunglongbing_(Citrus_greening)")
                    Column(
                      children: [
                        const Text(
                          "Suggestions :",
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                        const Text(
                          " 🍊 Remove and destroy infected trees to prevent further spread of the disease.\n 🐛 Control Asian citrus psyllids, the insect vector of Huanglongbing, through insecticide applications.\n 🌿 Plant disease-free citrus trees from reputable nurseries.\n",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  if (_result == "Peach___healthy")
                    Column(
                      children: [
                        const Text(
                          "Suggestions :",
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                        const Text(
                          " 🍑 Maintain tree vigor through proper watering, fertilization, and pruning practices.\n 🐛 Monitor for pests and diseases regularly, and implement appropriate control measures when necessary.\n 🍂 Remove fallen leaves and debris from around the base of the tree to reduce overwintering sites for pathogens.\n",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  if (_result == "Pepper,_bell___Bacterial_spot")
                    Column(
                      children: [
                        const Text(
                          "Suggestions :",
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                        const Text(
                          " 🌶️ Use disease-free transplants to prevent introduction of the pathogen.\n 🚿 Avoid overhead watering to minimize leaf wetness and humidity.\n 🍄 Apply copper-based bactericides in early spring before bud break, following label instructions.\n",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  if (_result == "Pepper,_bell___healthy")
                    Column(
                      children: [
                        const Text(
                          "Suggestions :",
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                        const Text(
                          " 🌶️ Ensure proper soil drainage and fertility to promote healthy plant growth.\n 💧 Water plants regularly, especially during dry periods, to maintain adequate soil moisture.\n 🌿 Monitor for pests and diseases regularly, and implement appropriate control measures when necessary.\n",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  if (_result == "Potato___Early_blight")
                    Column(
                      children: [
                        const Text(
                          "Suggestions :",
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                        const Text(
                          " 🥔 Select resistant potato varieties to reduce disease severity.\n 🔄 Rotate crops with non-host plants to break the disease cycle.\n 🍄 Apply fungicide treatments containing chlorothalonil or mancozeb during early stages of infection, following label instructions.\n",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  if (_result == "Potato___Late_blight")
                    Column(
                      children: [
                        const Text(
                          "Suggestions :",
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                        const Text(
                          "Suggestions :",
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                        const Text(
                          " 🥔 Choose resistant potato varieties to reduce disease severity.\n 🚿 Avoid overhead watering to minimize leaf wetness and humidity.\n 🍄 Apply fungicide treatments containing chlorothalonil or mancozeb during early stages of infection, following label instructions.\n",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  if (_result == "Potato___healthy")
                    Column(
                      children: [
                        const Text(
                          "Suggestions :",
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                        const Text(
                          " 🥔 Ensure proper soil drainage and fertility to promote healthy plant growth.\n 💧 Water plants regularly, especially during dry periods, to maintain adequate soil moisture.\n 🌿 Monitor for pests and diseases regularly, and implement appropriate control measures when necessary.\n",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  if (_result == "Raspberry___healthy")
                    Column(
                      children: [
                        const Text(
                          "Suggestions :",
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                        const Text(
                          " 🌿 Ensure proper soil drainage and fertility to promote healthy plant growth.\n 💧 Water plants regularly, especially during dry periods, to maintain adequate soil moisture.\n 🌿 Prune canes annually to remove dead, damaged, or diseased wood and promote air circulation.\n",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  if (_result == "Soybean___healthy")
                    Column(
                      children: [
                        const Text(
                          "Suggestions :",
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                        const Text(
                          " 🌱 Ensure proper soil drainage and fertility to promote healthy plant growth.\n 💧 Water plants regularly, especially during dry periods, to maintain adequate soil moisture.\n 🌿 Monitor for pests and diseases regularly, and implement appropriate control measures when necessary.\n",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  if (_result == "Squash___Powdery_mildew")
                    Column(
                      children: [
                        const Text(
                          "Suggestions :",
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                        const Text(
                          " 🎃 Prune plants to improve air circulation and reduce humidity within the canopy.\n 🚿 Avoid overhead watering to minimize leaf wetness and humidity.\n 🍄 Apply fungicide treatments containing sulfur or copper-based compounds during early stages of infection, following label instructions.\n",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  if (_result == "Strawberry___healthy")
                    Column(
                      children: [
                        const Text(
                          "Suggestions :",
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                        const Text(
                          " 🍓 Ensure proper soil drainage and fertility to promote healthy plant growth.\n 💧 Water plants regularly, especially during dry periods, to maintain adequate soil moisture.\n 🌿 Monitor for pests and diseases regularly, and implement appropriate control measures when necessary.\n",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  if (_result == "Tomato___Bacterial_spot")
                    Column(
                      children: [
                        const Text(
                          "Suggestions :",
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                        const Text(
                          " 🍅 Use disease-free transplants to prevent introduction of the pathogen.\n 🚿 Avoid overhead watering to minimize leaf wetness and humidity.\n 🍄 Apply copper-based bactericides in early spring before bud break, following label instructions.\n",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  if (_result == "Tomato___Early_blight")
                    Column(
                      children: [
                        const Text(
                          "Suggestions :",
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                        const Text(
                          " 🍅 Select resistant tomato varieties to reduce disease severity.\n 🔄 Rotate crops with non-host plants to break the disease cycle.\n 🍄 Apply fungicide treatments containing chlorothalonil or mancozeb during early stages of infection, following label instructions.\n",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  if (_result == "Tomato___Late_blight")
                    Column(
                      children: [
                        const Text(
                          "Suggestions :",
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                        const Text(
                          " 🍅 Choose resistant tomato varieties to reduce disease severity.\n 🚿 Avoid overhead watering to minimize leaf wetness and humidity.\n 🍄 Apply fungicide treatments containing chlorothalonil or mancozeb during early stages of infection, following label instructions.\n",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  if (_result == "Tomato___Leaf_Mold")
                    Column(
                      children: [
                        const Text(
                          "Suggestions :",
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                        const Text(
                          " 🍅 Prune plants to improve air circulation and reduce humidity within the canopy.\n 🚿 Avoid overhead watering to minimize leaf wetness and humidity.\n 🍄 Apply fungicide treatments containing chlorothalonil or mancozeb during early stages of infection, following label instructions.\n",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  if (_result == "Tomato___Septoria_leaf_spot")
                    Column(
                      children: [
                        const Text(
                          "Suggestions :",
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                        const Text(
                          " 🍅 Prune and destroy infected leaves to reduce fungal inoculum.\n 🚿 Avoid overhead watering to minimize leaf wetness and humidity.\n 🍄 Apply fungicide treatments containing chlorothalonil or mancozeb during early stages of infection, following label instructions.\n",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  if (_result == "Tomato___Spider_mites Two-spotted_spider_mite")
                    Column(
                      children: [
                        const Text(
                          "Suggestions :",
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                        const Text(
                          " 🍅 Introduce predatory mites to control spider mite populations.\n 🚿 Apply strong jets of water to dislodge spider mites from plant foliage.\n 🌿 Use insecticidal soap or horticultural oil to suffocate spider mites, following label instructions.\n",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  if (_result == "Tomato___Target_Spot")
                    Column(
                      children: [
                        const Text(
                          "Suggestions :",
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                        const Text(
                          " 🍅 Prune and destroy infected leaves to reduce fungal inoculum.\n 🚿 Avoid overhead watering to minimize leaf wetness and humidity.\n 🍄 Apply fungicide treatments containing chlorothalonil or mancozeb during early stages of infection, following label instructions.\n",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  if (_result == "Tomato___Tomato_Yellow_Leaf_Curl_Virus")
                    Column(
                      children: [
                        const Text(
                          "Suggestions :",
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                        const Text(
                          " 🍅 Remove and destroy infected plants to prevent further spread of the virus.\n 🐛 Control whiteflies, the insect vector of Tomato Yellow Leaf Curl Virus, through insecticide applications.\n 🌿 Use insect-proof screens in greenhouses to exclude whiteflies.\n",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  if (_result == "Tomato___Tomato_mosaic_virus")
                    Column(
                      children: [
                        const Text(
                          "Suggestions :",
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                        const Text(
                          " 🍅 Remove and destroy infected plants to prevent further spread of the virus.\n 🌿 Disinfect tools and equipment regularly to prevent mechanical transmission of the virus.\n 🐛 Control aphids, which can transmit Tomato Mosaic Virus, through insecticide applications.\n",
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      ],
                    ),
                  if (_result == "Tomato___healthy")
                    Column(
                      children: [
                        const Text(
                          "Suggestions :",
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                        const Text(
                          " 🍅 Ensure proper soil drainage and fertility to promote healthy plant growth.\n 💧 Water plants regularly, especially during dry periods, to maintain adequate soil moisture.\n 🌿 Monitor for pests and diseases regularly, and implement appropriate control measures when necessary.\n",
                          style: TextStyle(fontSize: 18, color: Colors.black),
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
