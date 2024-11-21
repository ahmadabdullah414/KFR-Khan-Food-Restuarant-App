import 'package:flutter/material.dart';
import 'package:kfr/home.dart';


class CoffeeItem {
  final String name;
  final int quantity;

  CoffeeItem({required this.name, required this.quantity});
}

class Cart {
  static final List<CoffeeItem> _items = [];

  static void addItem(CoffeeItem item) {
    _items.add(item);
    // You can also implement logic to handle duplicates if needed
  }

  static List<CoffeeItem> get items => _items; // To access cart items
}

class Coffee extends StatefulWidget {
  const Coffee({super.key});

  @override
  State<Coffee> createState() => _CoffeeState();
}

class _CoffeeState extends State<Coffee> {
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

  void _addToCart() {
    if (count > 0) {
      // Create the item to add
      final cartItem = CoffeeItem(name: 'Coffee', quantity: count);
      Cart.addItem(cartItem); // Add to cart
      // Optionally show a confirmation message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$count Coffee(s) added to cart!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen width and height for responsiveness
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
                _addToCart(); // Go to cart page
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
          child: Center(
            child: Column(
              children: [
                Container(
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.4,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/cofee.png'),
                      fit: BoxFit.cover,
                    ),
                    color: Colors.orange,
                    border: Border.all(width: 0.2, color: Colors.white70),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Center(child: Text('\$2.59',style: TextStyle(fontSize:18,fontWeight:FontWeight.w900,color: Colors.white),)),
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
                      width: screenWidth * 0.4,
                      height: screenHeight * 0.05,
                      decoration: BoxDecoration(
                          color: Colors.amber,
                          border: Border.all(width: 0.2, color: Colors.grey),
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: Text(
                          '$count',
                          style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 25,
                              color: Colors.black),
                        ),
                      ),
                    ),
                    FloatingActionButton(
                      backgroundColor: Colors.black45,
                      onPressed: () {
                        count++;
                        setState(() {});
                      },
                      child: const Icon(Icons.arrow_forward_ios_sharp,
                          color: Colors.green),
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
                      borderRadius: BorderRadius.circular(5)),
                  child: TextButton(
                    onPressed: _addToCart, // Update this line to add to cart
                    child: const Text('Order Now!',
                        style: TextStyle(
                            fontWeight: FontWeight.w900, color: Colors.black)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.02),
                  child: Text(
                    'Core Ingredients',
                    style: TextStyle(
                        fontSize: screenWidth * 0.06,
                        fontWeight: FontWeight.w900,
                        color: Colors.amber),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.01),
                  child: Column(
                    children: [
                      Text(
                        'Milk',
                        style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.w500,
                            color: Colors.amber),
                      ),
                      Text(
                        'Sugar',
                        style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.w500,
                            color: Colors.amber),
                      ),
                      Text(
                        'Ice cubes',
                        style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.w500,
                            color: Colors.amber),
                      ),
                      Text(
                        'Flavorings',
                        style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.w500,
                            color: Colors.amber),
                      ),
                      Text(
                        'Ground coffee beans',
                        style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.w500,
                            color: Colors.amber),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
