import 'package:agrisense/stories/insurance.dart';
import 'package:agrisense/stories/mutualfund.dart';
import 'package:agrisense/stories/ppf.dart';
import 'package:agrisense/stories/stocks.dart';
import 'package:agrisense/stories/tax.dart';
import 'package:agrisense/widgets/story_widget.dart';
import 'package:flutter/material.dart';
import 'package:agrisense/screens/chat_screen.dart';

class StoryScreen extends StatelessWidget {
  const StoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      //   centerTitle: true,
      //   title: const Text(
      //     'agrisense - AI Financial Advisor',
      //     style: TextStyle(fontWeight: FontWeight.bold),
      //   ),
      // ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).colorScheme.surfaceContainerHighest),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'AgriSense ',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.energy_savings_leaf,
                          size: 40,
                        )
                      ],
                    ),
                    Text(
                      'Next-gen AI-powered agricultural advisor to enhance your farming efficiency and sustainability.',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Swipe to access your agriculture assistant →',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              'Explore smart farming techniques to improve yields, reduce costs, and build a sustainable agricultural future below ↓ ',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    CategoriesCardWidget(
                        image:
                            'https://i.pinimg.com/736x/47/a2/44/47a244fb7954c7075a55f1c14c4d0af5.jpg',
                        title: 'Fertilizer Application',
                        category: "",
                        destination: const Mutualfund()),
                    CategoriesCardWidget(
                        image:
                            'https://i.pinimg.com/736x/8d/5a/81/8d5a810550412343448b04a8a3d8514d.jpg',
                        title: 'Organic Pest Control',
                        category: "",
                        destination: const Stocks()),
                    CategoriesCardWidget(
                        image:
                            'https://i.pinimg.com/736x/19/88/4f/19884f2d8458859e1e16ee8df537698d.jpg',
                        title: 'Smart Irrigation',
                        category: "",
                        destination: const Tax()),
                    CategoriesCardWidget(
                        image:
                            'https://i.pinimg.com/736x/bb/bb/dc/bbbbdcc3673e13a12be1ed13583e92b3.jpg',
                        title: 'Soil Health',
                        category: "",
                        destination: const Insurance()),
                    CategoriesCardWidget(
                        image:
                            'https://i.pinimg.com/736x/bc/70/c7/bc70c75d189c386df8c4dfc60583cc93.jpg',
                        title: 'Crop Rotation',
                        category: "",
                        destination: const Ppf()),
                    CategoriesCardWidget(
                        image:
                            'https://i.pinimg.com/736x/3d/40/e6/3d40e65295b74559cc150660a509cb4f.jpg',
                        title: 'Sensors',
                        category: "",
                        destination: const ChatScreen()),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
