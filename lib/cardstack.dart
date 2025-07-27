import 'package:flutter/material.dart';

class CardsStackPage extends StatefulWidget {
  const CardsStackPage({super.key});

  @override
  State<CardsStackPage> createState() => _CardsStackPageState();
}

class _CardsStackPageState extends State<CardsStackPage> {
  int selectedIndex = -1;

  final List<Map<String, dynamic>> cards = [
    {"title": "Card 1", "color": Colors.blue, "desc": "This is the first card"},
    {"title": "Card 2", "color": Colors.red, "desc": "This is the second card"},
    {
      "title": "Card 3",
      "color": Colors.green,
      "desc": "This is the third card",
    },
    {
      "title": "Card 4",
      "color": Colors.orange,
      "desc": "This is the fourth card",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Cards Stacks"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Center(
        child: SizedBox.expand(
          child: Stack(
            alignment: Alignment.center,
            children: List.generate(cards.length, (index) {
              double topOffset =
                  selectedIndex == index
                      ? MediaQuery.of(context).size.height * 0.15
                      : MediaQuery.of(context).size.height * 0.35 + index * 18;
              double scale = selectedIndex == index ? 1.1 : 1.0;

              return AnimatedPositioned(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                top: topOffset,
                left: (MediaQuery.of(context).size.width * 0.1),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = selectedIndex == index ? -1 : index;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    width: MediaQuery.of(context).size.width * 0.8 * scale,
                    height: 180 * scale,
                    decoration: BoxDecoration(
                      color: cards[index]["color"],
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        if (selectedIndex == index)
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 20,
                            spreadRadius: 2,
                            offset: const Offset(0, 8),
                          ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            cards[index]["title"],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (selectedIndex == index)
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                cards[index]["desc"],
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
