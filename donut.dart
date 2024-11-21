import 'package:flutter/material.dart';
import 'package:kfr/cart.dart';
import 'package:kfr/home.dart';

class Donut extends StatefulWidget {
  const Donut({super.key});

  @override
  State<Donut> createState() => _DonutState();
}

class _DonutState extends State<Donut> {
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
                  width: screenWidth * 0.8, // Responsive width
                  height: screenHeight * 0.4, // Responsive height
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/donut5.png'),
                      fit: BoxFit.fitWidth,
                    ),
                    color: Colors.orange,
                    border: Border.all(width: 0.2, color: Colors.white70),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Center(child: Text('\$10.99',style: TextStyle(fontSize:18,fontWeight:FontWeight.w900,color: Colors.white),)),
                SizedBox(height: screenHeight * 0.02),
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
                      width: screenWidth * 0.25, // Responsive width
                      height: screenHeight * 0.05, // Responsive height
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        border: Border.all(width: 0.2, color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          '$count',
                          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 25, color: Colors.black),
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
                  width: screenWidth * 0.3, // Responsive width
                  height: screenHeight * 0.05, // Responsive height
                  decoration: BoxDecoration(
                    color: Colors.green,
                    border: Border.all(width: 0.2, color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  Addtocart()));
                    },
                    child: const Center(
                      child: Text(
                        'Order Now!',
                        style: TextStyle(fontWeight: FontWeight.w900, color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.02),
                  child: Text(
                    'Core Ingredients',
                    style: TextStyle(fontSize: screenWidth * 0.06, fontWeight: FontWeight.w900, color: Colors.amber),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.01),
                  child: Column(
                    children: [
                      Text('Salt', style: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500, color: Colors.amber)),
                      Text('Eggs', style: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500, color: Colors.amber)),
                      Text('Flour', style: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500, color: Colors.amber)),
                      Text('Sugar', style: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500, color: Colors.amber)),
                      Text('Butter or oil', style: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500, color: Colors.amber)),
                      Text('Milk or water', style: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500, color: Colors.amber)),
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
}
