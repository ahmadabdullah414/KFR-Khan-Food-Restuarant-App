import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kfr/cart.dart';
import 'package:kfr/home.dart';

class Juice extends StatefulWidget {
  const Juice({super.key});

  @override
  State<Juice> createState() => _JuiceState();
}

class _JuiceState extends State<Juice> {
  List imageList = [
    {"id": 1, "image_path": 'assets/bur.png',},
    {"id": 2, "image_path": 'assets/fry.png',},
    {"id": 3, "image_path": 'assets/don.png',},
  ];
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  int count = 0;
  double _opacity = 0.0; // Opacity for the animation

  @override
  void initState() {
    super.initState();
    // Start the animation after a short delay
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _opacity = 1.0; // Fade in
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    // Get screen size using MediaQuery
    var screenSize = MediaQuery.of(context).size;
    double screenHeight = screenSize.height;
    double screenWidth = screenSize.width;

    return Scaffold(
      backgroundColor: Colors.black87,

      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, size: 30, color: Colors.amber),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Flexible(
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MyHomePage()),
                  );
                },
                child: const Text(
                  'KFR',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Colors.amber),
                ),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart, size: 30, color: Colors.amber),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) =>  Addtocart()),
                );
              },
            ),
          ),
        ],
        automaticallyImplyLeading: false,
      ),

      body: AnimatedOpacity(
        duration: const Duration(milliseconds: 500),
        opacity: _opacity,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Column(
              children: [
                Container(
                  width: screenWidth * 0.8, // Responsive width based on screen size
                  height: screenHeight * 0.4, // Responsive height based on screen size
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/juice.png'),
                      fit: BoxFit.fitWidth,
                    ),
                    color: Colors.orange,
                    border: Border.all(width: 0.2, color: Colors.white70),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Center(child: Text('\$1.99',style: TextStyle(fontSize:18,fontWeight:FontWeight.w900,color: Colors.white),)),
                SizedBox(height: screenHeight * 0.02), // Responsive spacing
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton(
                      backgroundColor: Colors.black45,
                      onPressed: () {
                        if (count > 0) {
                          count--;
                          setState(() {});
                        }
                      },
                      child: const Icon(Icons.arrow_back_ios, color: Colors.red),
                    ),

                    Container(
                      width: screenWidth * 0.4,
                      height: screenHeight * 0.07,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        border: Border.all(width: 0.2, color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          '$count',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: screenWidth * 0.06, // Dynamic font size
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),

                    FloatingActionButton(
                      backgroundColor: Colors.black45,
                      onPressed: () {
                        count++;
                        setState(() {});
                      },
                      child: const Icon(Icons.arrow_forward_ios_sharp, color: Colors.green),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),

                Container(
                  width: screenWidth * 0.3,
                  height: screenHeight * 0.05,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    border: Border.all(width: 0.2, color: Colors.grey),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (context) =>  Addtocart()));
                      },
                      child: Center(
                        child: Text(
                          'Order Now!',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                            fontSize: screenWidth * 0.04, // Dynamic font size
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.02),
                  child: Text(
                    'Core Ingredients',
                    style: TextStyle(
                      fontSize: screenWidth * 0.05, // Dynamic font size
                      fontWeight: FontWeight.w900,
                      color: Colors.amber,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.01),
                  child: Column(
                    children: [
                      Text('Ice cubes (optional)', style: _ingredientTextStyle(screenWidth)),
                      Text('Milk (dairy or plant-based)', style: _ingredientTextStyle(screenWidth)),
                      Text('Sweetener (sugar, honey, etc.)', style: _ingredientTextStyle(screenWidth)),
                      Text('Ripe mangoes (fresh or frozen)', style: _ingredientTextStyle(screenWidth)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextStyle _ingredientTextStyle(double screenWidth) {
    return TextStyle(
      fontSize: screenWidth * 0.04, // Dynamic font size for ingredient list
      fontWeight: FontWeight.w500,
      color: Colors.amber,
    );
  }
}
