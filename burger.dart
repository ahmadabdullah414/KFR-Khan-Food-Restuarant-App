import 'package:flutter/material.dart';
import 'package:kfr/cart.dart';

import 'package:kfr/home.dart';
import 'package:kfr/menu.dart';



class Burger extends StatefulWidget {
  const Burger({super.key});

  @override
  State<Burger> createState() => _BurgerState();
}

class _BurgerState extends State<Burger> with TickerProviderStateMixin {
  int count = 0;
  late AnimationController _imageController;

  final double burgerPrice = 8.99; // Price for a burger

  @override
  void initState() {
    super.initState();
    _imageController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _imageController.dispose();
    super.dispose();
  }

  void _updateCount(bool increment) {
    setState(() {
      if (increment) {
        count++;
      } else if (count > 0) {
        count--;
      }
    });
  }

  void _addToCart() {
    if (count > 0) {
      final cartItem = CartItem(name: 'Burger', price: burgerPrice, quantity: count, image: 'assets/burger3.png');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Addtocart(),
          settings: RouteSettings(arguments: cartItem),
        ),
      );
    }
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Addtocart()),
                );
              },
            ),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            children: [
              FadeTransition(
                opacity: _imageController,
                child: Container(
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.4,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/burger5.png'),
                      fit: BoxFit.fitWidth,
                    ),
                    color: Colors.orange,
                    border: Border.all(width: 0.2, color: Colors.white70),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Center(
                child: Text('\$8.99',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.white)),
              ),
              SizedBox(height: screenHeight * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    backgroundColor: Colors.black45,
                    onPressed: () {
                      _updateCount(false);
                    },
                    child: const Icon(Icons.arrow_back_ios, color: Colors.red),
                  ),
                  Container(
                    width: screenWidth * 0.4,
                    height: screenHeight * 0.05,
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
                      _updateCount(true);
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
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextButton(
                  onPressed: _addToCart,
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
                    Text('Buns', style: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500, color: Colors.amber)),
                    Text('Onion', style: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500, color: Colors.amber)),
                    Text('Tomato', style: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500, color: Colors.amber)),
                    Text('Cheese', style: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500, color: Colors.amber)),
                    Text('Zinger Sauce', style: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500, color: Colors.amber)),
                    Text('Chicken Breast', style: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.w500, color: Colors.amber)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
