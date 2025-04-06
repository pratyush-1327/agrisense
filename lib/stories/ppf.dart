import 'package:flutter/material.dart';

class Ppf extends StatelessWidget {
  const Ppf({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        // centerTitle: true,
        title: const Text('Crop Rotation'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 20,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    // color: Colors.amber,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          'https://i.pinimg.com/736x/bc/70/c7/bc70c75d189c386df8c4dfc60583cc93.jpg',
                        ))),

                height: 300,
                // color: Colors.amber,
              ),
              Container(
                // color: Colors.amber,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color:
                        Theme.of(context).colorScheme.surfaceContainerHighest),

                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    spacing: 20,
                    children: [
                      Text(
                        'Crop Rotation: A Simple Way to Prevent Soil Depletion',
                        style: TextStyle(
                            fontSize: 33, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        'Growing the same crop repeatedly in the same field depletes soil nutrients and increases pest problems. Crop rotation—alternating crops in different seasons—helps maintain soil fertility and reduces the risk of diseases.\nFor example, farmers can follow this rotation cycle:\n🌾 Year 1: Grow nitrogen-fixing legumes like pulses or soybeans\n🌽 Year 2: Plant a cereal crop like wheat or maize\n🥔 Year 3: Grow root crops like potatoes or onions\nThis method prevents nutrient exhaustion, disrupts pest life cycles, and improves overall soil health, leading to better yields with lower input costs.',
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
