import 'package:agrisense/stories/insurance.dart';
import 'package:agrisense/stories/mutualfund.dart';
import 'package:agrisense/stories/ppf.dart';
import 'package:agrisense/stories/stocks.dart';
import 'package:agrisense/widgets/story_widget.dart';
import 'package:easy_localization/easy_localization.dart'; // Import easy_localization
import 'package:flutter/material.dart';
import 'package:agrisense/screens/chat_screen.dart';
import 'package:agrisense/stories/tax.dart';

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
                          'storyScreenTitlePart1'.tr(), // Translate
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
                      'storyScreenSubtitle'.tr(), // Translate
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'storyScreenSwipeHint'.tr(), // Translate
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
              'storyScreenExploreText'.tr(), // Translate
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
                        title: 'storyFertilizer'.tr(), // Translate
                        category: "",
                        destination: const Mutualfund()),
                    CategoriesCardWidget(
                        image:
                            'https://i.pinimg.com/736x/8d/5a/81/8d5a810550412343448b04a8a3d8514d.jpg',
                        title: 'storyPestControl'.tr(), // Translate
                        category: "",
                        destination: const Stocks()),
                    CategoriesCardWidget(
                        image:
                            'https://i.pinimg.com/736x/19/88/4f/19884f2d8458859e1e16ee8df537698d.jpg',
                        title: 'storyIrrigation'.tr(), // Translate
                        category: "",
                        destination: const Tax()),
                    CategoriesCardWidget(
                        image:
                            'https://i.pinimg.com/736x/bb/bb/dc/bbbbdcc3673e13a12be1ed13583e92b3.jpg',
                        title: 'storySoilHealth'.tr(), // Translate
                        category: "",
                        destination: const Insurance()),
                    CategoriesCardWidget(
                        image:
                            'https://i.pinimg.com/736x/bc/70/c7/bc70c75d189c386df8c4dfc60583cc93.jpg',
                        title: 'storyCropRotation'.tr(), // Translate
                        category: "",
                        destination: const Ppf()),
                    CategoriesCardWidget(
                        image:
                            'https://i.pinimg.com/736x/3d/40/e6/3d40e65295b74559cc150660a509cb4f.jpg',
                        title: 'storySensors'.tr(), // Translate
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
