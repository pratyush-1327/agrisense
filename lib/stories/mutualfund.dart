import 'package:flutter/material.dart';

class Mutualfund extends StatelessWidget {
  const Mutualfund({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        // centerTitle: true,
        title: const Text('Fertilizer Application'),
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
                          'https://i.pinimg.com/736x/47/a2/44/47a244fb7954c7075a55f1c14c4d0af5.jpg',
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
                        ' Fertilizer Application: The Right Time, Right Amount',
                        style: TextStyle(
                            fontSize: 33, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        'Applying fertilizers at the correct time and in the right quantity is crucial for healthy crops and maximum yield. Nitrogen-based fertilizers, such as urea, should be applied in split doses rather than all at once. For example, in wheat farming, the first dose should be applied during sowing, while the second dose should be added at the tillering stage to support growth.\nTo prevent nutrient loss, always apply fertilizers early in the morning or late in the evening when temperatures are lower. This reduces evaporation and ensures better absorption.\n Additionally, avoid broadcasting fertilizers on dry soil—instead, apply them when the soil has some moisture to enhance nutrient uptake. By following these best practices, farmers can optimize fertilizer efficiency, reduce costs, and improve soil health over time.',
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
