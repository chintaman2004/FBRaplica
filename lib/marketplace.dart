import 'package:flutter/material.dart';

class MarketplacePage extends StatelessWidget {
  const MarketplacePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ads = [
      {
        'title': 'iPhone 14 Pro Max',
        'price': 'PKR 280,000',
        'image': 'assets/images/iphone.jpg',
      },
      {
        'title': 'Honda Civic 2022',
        'price': 'PKR 5,000,000',
        'image': 'assets/images/car.jpg',
      },
      // Add more mock ads
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Marketplace")),
      body: ListView.builder(
        itemCount: ads.length,
        itemBuilder: (context, index) {
          final ad = ads[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: Image.asset(ad['image']!, width: 50),
              title: Text(ad['title']!),
              subtitle: Text(ad['price']!),
            ),
          );
        },
      ),
    );
  }
}
